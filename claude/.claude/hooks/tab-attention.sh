#!/bin/bash
[ -z "$KITTY_WINDOW_ID" ] && [ -z "$KITTY_TAB_MATCHER" ] && exit 0
command -v kitty >/dev/null 2>&1 || exit 0
matcher="${KITTY_TAB_MATCHER:-window_id:$KITTY_WINDOW_ID}"
kitty @ set-tab-color --match "$matcher" \
    active_bg="#ff5555" inactive_bg="#cc4444" >/dev/null 2>&1 || true
exit 0
