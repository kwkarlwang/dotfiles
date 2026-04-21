#!/bin/bash
# Restore tabs saved by kitty-save-session.sh into the CURRENT kitty OS
# window. Each tab is recreated via `kitty @ launch --type=tab`:
#   - Local claude tab  -> cwd + `claude --resume <id>; exec zsh`
#   - Remote arca-et tab -> `arca-et <remote_cwd> <id>` (drops into claude
#     if a session id was stamped; otherwise just opens the et connection)
#   - Plain tab         -> cwd only
#
# Usage: kitty-restore-session.sh [--close-source <window_id>] [input-file]
#        default input: ~/.config/kitty/session.json
# When invoked from the cmd+shift+r keybind, kitty substitutes
# @active-kitty-window-id into the --close-source arg so the tab that
# issued the restore can be closed once the new tabs are spawned.
set -euo pipefail

close_source=""
if [ "${1:-}" = "--close-source" ]; then
    close_source="$2"
    shift 2
fi

in="${1:-$HOME/.config/kitty/session.json}"
[ -f "$in" ] || { echo "no session file at $in" >&2; exit 1; }

source "$(dirname "$0")/_kitty_socket.sh"
_kitty_pick_socket || { echo "no reachable kitty listener" >&2; exit 1; }

# Use a zsh login shell so arca-et / claude are on PATH.
ZSH="${SHELL:-/bin/zsh}"

jq -c '.tabs[]' "$in" | while IFS= read -r tab; do
    title=$(jq -r '.title // ""' <<<"$tab")
    win=$(jq -c --argjson i "$(jq '.active_window_idx' <<<"$tab")" '.windows[$i] // .windows[0]' <<<"$tab")

    cwd=$(jq -r '.cwd // ""' <<<"$win")
    uv_sid=$(jq -r '.user_vars.claude_session_id // ""' <<<"$win")
    uv_cwd=$(jq -r '.user_vars.claude_cwd // ""' <<<"$win")
    uv_remote=$(jq -r '.user_vars.claude_remote // ""' <<<"$win")
    uv_arca_cwd=$(jq -r '.user_vars.arca_cwd // ""' <<<"$win")

    # A tab is remote if either the SessionStart hook stamped it
    # (claude_remote=1) or the remote zshrc stamped arca_cwd (used by
    # the existing clone-tab flow). Prefer claude_cwd when both exist
    # — it's the cwd claude saw most recently; arca_cwd is the cwd
    # arca-et was invoked with.
    is_remote=0
    [ "$uv_remote" = "1" ] && is_remote=1
    [ -n "$uv_arca_cwd" ]  && is_remote=1
    remote_cwd="${uv_cwd:-$uv_arca_cwd}"

    args=(@ launch --type=tab)
    [ -n "$title" ] && args+=(--tab-title "$title")

    if [ "$is_remote" = "1" ]; then
        # Remote arca-et tab. Land in $HOME locally; arca-et handles the cd.
        args+=(--cwd "$HOME")
        args+=(--env "CLAUDE_RESTORE_REMOTE_CWD=${remote_cwd}")
        args+=(--env "CLAUDE_RESTORE_SESSION_ID=${uv_sid:-}")
        args+=("$ZSH" -ic 'arca-et "$CLAUDE_RESTORE_REMOTE_CWD" "$CLAUDE_RESTORE_SESSION_ID"; exec zsh -i')
    elif [ -n "$uv_sid" ]; then
        # Local claude tab. Prefer claude_cwd (stamped at SessionStart,
        # reliable) over the kitty live cwd reading, which can be a
        # transient child-process cwd like "/" when claude is busy.
        tab_cwd="${uv_cwd:-$cwd}"
        [ -n "$tab_cwd" ] && args+=(--cwd "$tab_cwd")
        args+=(--env "CLAUDE_RESTORE_SESSION_ID=$uv_sid")
        args+=("$ZSH" -ic 'claude --resume "$CLAUDE_RESTORE_SESSION_ID"; exec zsh -i')
    else
        # Plain tab — just land in the saved cwd.
        [ -n "$cwd" ] && args+=(--cwd "$cwd")
    fi

    kitty "${args[@]}"
done

echo "Restored $(jq '.tabs | length' "$in") tabs from $in"

# Close the tab that issued the restore (if its window id was passed).
# Skip close if the id looks unresolved (literal placeholder leaked through).
if [[ -n "$close_source" && "$close_source" =~ ^[0-9]+$ ]]; then
    kitty @ close-window --match "id:$close_source" 2>/dev/null || true
fi
