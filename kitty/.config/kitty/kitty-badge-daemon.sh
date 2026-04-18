#!/bin/bash
# Background daemon: polls Kitty terminal windows every 1s.
# Counts how many windows are showing a Claude permission prompt.
# Updates the Kitty dock badge accordingly.
# Managed by launchd (com.claude.kitty-badge).

while true; do
  # Auto-discover Kitty's socket (re-discover each loop in case Kitty restarts)
  sock=$(ls /tmp/kitty-* 2>/dev/null | head -1)
  if [[ -n "$sock" ]]; then
    export KITTY_LISTEN_ON="unix:$sock"
  else
    unset KITTY_LISTEN_ON
    sleep 5
    continue
  fi

  # Get IDs of all windows (silently skip if Kitty isn't running)
  window_ids=$(kitten @ ls 2>/dev/null | jq -r '[.[] | .tabs[] | .windows[] | .id] | .[]' 2>/dev/null)

  if [[ -z "$window_ids" ]]; then
    kitten @ kitten dock_badge.py 0 2>/dev/null
    sleep 1
    continue
  fi

  # Count windows showing a permission prompt
  count=0
  for wid in $window_ids; do
    text=$(kitten @ get-text --match id:"$wid" 2>/dev/null | tail -20)
    if echo "$text" | grep -q "Do you want to"; then
      count=$((count + 1))
    fi
  done

  # Always set badge (kitten @ kitten can silently fail)
  kitten @ kitten dock_badge.py "$count" 2>/dev/null

  sleep 1
done
