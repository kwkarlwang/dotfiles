#!/bin/bash
# Save the current kitty OS window's tabs (cwd, title, user_vars) so they
# can be restored with kitty-restore-session.sh.
#
# Usage: kitty-save-session.sh [output-file]
#        default output: ~/.config/kitty/session.json
set -euo pipefail

out="${1:-$HOME/.config/kitty/session.json}"
mkdir -p "$(dirname "$out")"

source "$(dirname "$0")/_kitty_socket.sh"
_kitty_pick_socket || { echo "no reachable kitty listener" >&2; exit 1; }

# Pick the OS window we were invoked from; fall back to the first one.
kitty @ ls | jq --arg winenv "${KITTY_WINDOW_ID:-}" '
  (map(select(.is_focused)) | first) // .[0]
  | {
      tabs: [ .tabs[] | {
        title,
        layout,
        active_window_idx: (
          [.windows[] | .is_active] as $a
          | ($a | index(true)) // 0
        ),
        windows: [ .windows[] | {
          title,
          cwd,
          is_active,
          user_vars: (.user_vars // {})
        }]
      }]
    }
' > "$out"

count=$(jq '.tabs | length' "$out")
echo "Saved $count tabs to $out"
