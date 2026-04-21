#!/bin/bash
# Background daemon: polls kitty every 1s and counts tabs that have a
# color override ("needs attention" from Claude Stop/permission or a
# manual cmd+, mark). Updates the kitty dock badge.
# Managed by launchd (com.claude.kitty-badge).
#
# Since `kitty @ ls` doesn't expose tab color overrides in its JSON,
# we count via user-vars instead: every painting action also sets a
# signaling user-var on the window. Two names are used to preserve the
# focus-based clearing semantics:
#   - claude_tab_pending=1 : set by hooks; watcher auto-clears if tab
#                             is focused when the hook fires.
#   - tab_sticky=1          : set by cmd+,; survives on focused tabs,
#                             cleared only on focus-change.

source "$(dirname "$0")/_kitty_socket.sh"

while true; do
  # Re-probe every tick so daemon recovers when kitty is restarted.
  _kitty_pick_socket || { sleep 1; continue; }

  count=$(kitten @ ls 2>/dev/null \
    | jq '[.[] | .tabs[] | select(any(.windows[]; .user_vars.claude_tab_pending == "1" or .user_vars.tab_sticky == "1"))] | length' 2>/dev/null)

  if [[ -z "$count" ]]; then
    count=0
  fi

  kitten @ kitten dock_badge.py "$count" 2>/dev/null

  sleep 1
done
