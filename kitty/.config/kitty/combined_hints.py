"""
Custom kitten for `kitten hints --customize-processing`.

Combines in a single invocation:
  1. OSC 8 embedded hyperlinks (e.g. Claude Code output, `ls --hyperlink`).
  2. Plain-text URLs (http/https/ftp/file/ssh/git) and bare `go/foo` links.

kitty strips OSC 8 escape codes before passing `text` to custom processors, so
we re-fetch the screen via `kitty @ get-text --ansi --match recent:1`, parse
OSC 8 display/URL pairs from the ANSI dump, and locate the display strings in
the stripped `text` we were handed (that's the coordinate system kitty uses
for the hint overlay).
"""
import os
import re
import subprocess


# URL body with embedded soft-wrap tolerance: a long URL may be split across
# terminal lines either as a bare `\n` (true terminal wrap) or `\n  ` (Claude
# Code / markdown-style indented continuation). `[^\s<>"\x00]+` matches a run
# of URL chars; the continuation group allows additional runs following a
# newline + optional spaces/tabs. The match text will contain embedded
# whitespace which handle_result strips before calling `open`.
_URL_CHAR = r'[^\s<>"\x00]'
# Line break can be \r\n, \n, or \r alone — all are common in different
# contexts. Followed by optional indentation before URL chars resume.
_LINE_BREAK = r'(?:\r\n|\n|\r)'
_URL_WRAP = r'(?:' + _LINE_BREAK + r'[ \t]*' + _URL_CHAR + r'+)*'
_GO_CHAR = r'[A-Za-z0-9_./:?=&%#+@~-]'
_GO_WRAP = r'(?:' + _LINE_BREAK + r'[ \t]*' + _GO_CHAR + r'+)*'
URL_REGEX = re.compile(
    r'\b(?:https?|ftp|file|ssh|git)://' + _URL_CHAR + r'+' + _URL_WRAP
    + r'|\bgo/[A-Za-z0-9]' + _GO_CHAR + r'*' + _GO_WRAP
)

# OSC 8 opener: ESC ] 8 ; params ; URI ST   (ST = ESC \ or BEL)
OSC8_OPEN = re.compile(r'\x1b\]8;[^;]*;([^\x07\x1b]*)(?:\x1b\\|\x07)')
OSC8_CLOSE = re.compile(r'\x1b\]8;[^;]*;(?:\x1b\\|\x07)')
# Any other CSI or OSC escape we should skip over while extracting display text.
CSI = re.compile(r'\x1b\[[0-9;?]*[a-zA-Z]')
OTHER_OSC = re.compile(r'\x1b\][^\x07\x1b]*(?:\x07|\x1b\\)')
TWO_CHAR_ESC = re.compile(r'\x1b[NOP-_]')


def _extract_osc8_pairs(ansi_text):
    """Yield (url, display_text) for each OSC 8 hyperlink region."""
    i = 0
    n = len(ansi_text)
    while i < n:
        m = OSC8_OPEN.search(ansi_text, i)
        if not m:
            return
        url = m.group(1)
        j = m.end()
        # Collect display chars until OSC 8 close (or another opener).
        disp = []
        while j < n:
            c = OSC8_CLOSE.match(ansi_text, j)
            if c:
                j = c.end()
                break
            o = OSC8_OPEN.match(ansi_text, j)
            if o:
                # nested opener without explicit close — bail on this segment
                break
            esc = CSI.match(ansi_text, j) or OTHER_OSC.match(ansi_text, j) or TWO_CHAR_ESC.match(ansi_text, j)
            if esc:
                j = esc.end()
                continue
            disp.append(ansi_text[j])
            j += 1
        if url and disp:
            yield url, ''.join(disp)
        i = j


def _fetch_ansi_screen():
    """Fetch the ANSI screen text of the window that invoked the hints kitten.

    The kitten runs in an overlay window, so `recent:1` is unreliable — it can
    race and pick up the overlay itself (which kitty wraps with its own `mark:N`
    OSC 8 sequences). Instead, look up our own window's `overlay_for` field via
    `kitty @ ls` and fetch from that parent window directly.
    """
    listen_on = os.environ.get('KITTY_LISTEN_ON') or ''
    base = ['kitty', '@']
    if listen_on:
        base += ['--to', listen_on]

    target_match = 'recent:1'
    our_id = os.environ.get('KITTY_WINDOW_ID')
    if our_id:
        try:
            import json
            ls = subprocess.run(base + ['ls'], capture_output=True, text=True, timeout=2)
            if ls.returncode == 0:
                data = json.loads(ls.stdout)
                for os_win in data:
                    for tab in os_win.get('tabs', []):
                        for w in tab.get('windows', []):
                            if str(w.get('id')) == str(our_id):
                                parent = w.get('overlay_for')
                                if parent is not None:
                                    target_match = f'id:{parent}'
                                raise StopIteration
        except StopIteration:
            pass
        except Exception:
            pass

    try:
        r = subprocess.run(
            base + ['get-text', '--ansi', '--match', target_match, '--extent', 'screen'],
            capture_output=True, text=True, timeout=2,
        )
        if r.returncode == 0:
            return r.stdout
    except Exception:
        pass
    return ''


def _find_all(haystack, needle):
    """Yield all non-overlapping start indices of `needle` in `haystack`."""
    if not needle:
        return
    start = 0
    while True:
        idx = haystack.find(needle, start)
        if idx < 0:
            return
        yield idx
        start = idx + len(needle)


# Characters kitty uses to pad short lines to the terminal width. If a `\n`
# is preceded by a padding char, it's a hard line break; otherwise it's a
# soft wrap we should collapse so long URLs can match across visual lines.
_PADDING_CHARS = (' ', '\t', '\x00')


def _unwrap_soft_breaks(text):
    """Return (unwrapped, unwrapped_to_original_index_map).

    Used for OSC 8 display-text lookups, where the hyperlink display in the
    ANSI stream is a single run but kitty may have laid it out across
    multiple visual lines in `text`.

    A `\n` counts as a soft wrap (removed along with immediately following
    spaces/tabs) when the char before it is NOT padding — i.e. the line had
    real content up to its edge, so it must have wrapped. Otherwise it's a
    hard line break and stays.
    """
    out = []
    pos_map = []
    n = len(text)
    i = 0
    while i < n:
        c = text[i]
        if c == '\n' and out and out[-1] not in _PADDING_CHARS:
            i += 1
            while i < n and text[i] in (' ', '\t'):
                i += 1
            continue
        out.append(c)
        pos_map.append(i)
        i += 1
    return ''.join(out), pos_map


def mark(text, args, Mark, extra_cli_args):
    ansi = _fetch_ansi_screen()

    # Collect candidates from both sources, then greedily pick a non-overlapping
    # subset. Priority 0 (OSC 8 hyperlinks) beats priority 1 (regex URLs) on tie.
    # priority, start, end, url/text, is_hyperlink, groupdict
    candidates = []

    # OSC 8 display lookups run against the unwrapped view, so positions need
    # mapping back to `text`. URL_REGEX matches directly on `text` via the
    # `\n\s*` continuation group it has built in.
    unwrapped, pos_map = _unwrap_soft_breaks(text)

    def _orig_range(u_start, u_end):
        if u_start >= len(pos_map) or u_end == 0:
            return None
        s = pos_map[u_start]
        e = pos_map[u_end - 1] + 1 if u_end <= len(pos_map) else len(text)
        return s, e

    if ansi:
        pairs = list(_extract_osc8_pairs(ansi))
        pairs.sort(key=lambda p: -len(p[1]))
        for url, display in pairs:
            # When kitty auto-hyperlinks plain-text URLs on display, a wrapped
            # URL becomes one OSC 8 region per visual line, each with display
            # equal to a *substring* of the URL itself. Those fragmentary marks
            # are exactly what URL_REGEX already handles (as a single span
            # across wraps), so skip them and avoid double-marking.
            if display in url:
                continue
            for pos in _find_all(unwrapped, display):
                r = _orig_range(pos, pos + len(display))
                if r is None:
                    continue
                candidates.append((0, r[0], r[1], url, True, {'url': url}))

    for m in URL_REGEX.finditer(text):
        # Strip embedded whitespace (soft-wrap `\n` + any indent) so what we
        # hand to `open` is a clean URL, even though the on-screen mark spans
        # multiple lines.
        raw = m.group()
        cleaned = re.sub(r'\s+', '', raw)
        # Strip trailing sentence punctuation that's almost never part of a URL
        # (a URL ending with `.` or `,` in prose is almost always "end of URL +
        # end of sentence"). Shrink the mark end to match.
        end = m.end()
        while cleaned and cleaned[-1] in '.,;:!?)]}>\'"':
            cleaned = cleaned[:-1]
            end -= 1
        if not cleaned:
            continue
        candidates.append((1, m.start(), end, cleaned, False, {}))

    # Greedy non-overlap accept, ordered by priority then position.
    candidates.sort(key=lambda c: (c[0], c[1]))
    taken = []  # list of (start, end, url, is_hyperlink, groupdict)
    for _prio, s, e, url, is_h, gd in candidates:
        if any(not (e <= ts or s >= te) for ts, te, _u, _h, _g in taken):
            continue
        taken.append((s, e, url, is_h, gd))

    # Yield in start-order so indices align with screen order.
    taken.sort(key=lambda t: t[0])
    for idx, (s, e, url, is_h, gd) in enumerate(taken):
        yield Mark(idx, s, e, url, gd, is_hyperlink=is_h)


def handle_result(args, data, target_window_id, boss, *extra):
    # kitty's built-in handle_result.impl calls custom handle_result with
    # 5 positional args (last = data['extra_cli_args']); accept *extra.
    matches = data.get('match') or []
    if isinstance(matches, str):
        matches = [matches]
    for url in matches:
        if not url:
            continue
        if url.startswith('go/'):
            url = 'http://' + url
        subprocess.Popen(['open', url])
