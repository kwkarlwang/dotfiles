#!/bin/bash
# Helper: export KITTY_LISTEN_ON pointing at a reachable kitty
# remote-control listener, or leave it alone if the current one works.
# Kitty may listen on either unix:/tmp/kitty-<pid> (from listen_on in
# kitty.conf) or tcp:localhost:2888 (from macos-launch-services-cmdline),
# depending on launch method — see the comment in kitty.conf. Source this
# before calling `kitty @` / `kitten @` from a context without a TTY.

_kitty_pick_socket() {
    local s
    # Existing value wins if it works.
    if [[ -n "${KITTY_LISTEN_ON:-}" ]] && kitten @ --to "$KITTY_LISTEN_ON" ls >/dev/null 2>&1; then
        return 0
    fi
    # Unix socket (per-pid, from kitty.conf listen_on).
    while IFS= read -r s; do
        if kitten @ --to "unix:$s" ls >/dev/null 2>&1; then
            export KITTY_LISTEN_ON="unix:$s"
            return 0
        fi
    done < <(find -L /tmp -maxdepth 1 -type s -name 'kitty-[0-9]*' 2>/dev/null)
    # TCP (from macos-launch-services-cmdline on cold Launch-Services starts).
    if kitten @ --to tcp:localhost:2888 ls >/dev/null 2>&1; then
        export KITTY_LISTEN_ON="tcp:localhost:2888"
        return 0
    fi
    # DCS-over-PTY fallback: works when invoked from a kitty shell prompt
    # even if no socket is bound. Requires /dev/tty for kitty's reply.
    if [[ -w /dev/tty && -r /dev/tty ]]; then
        unset KITTY_LISTEN_ON
        if kitten @ ls >/dev/null 2>&1; then
            return 0
        fi
    fi
    return 1
}
