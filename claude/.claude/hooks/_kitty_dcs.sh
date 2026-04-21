#!/bin/bash
# Shared helper for the tab-color hooks.
#
# We can't use `kitty @ set-tab-color` here because `kitty @` writes the
# DCS request to /dev/tty and then reads a response from /dev/tty — and
# under remote Claude Code, Claude's TUI is already consuming /dev/tty
# input, stealing kitty's reply. The `kitty @` call hangs, Claude's 5 s
# hook timeout kills it, and the color never changes. There's no
# --no-response flag in kitty 0.46.
#
# So we write the raw DCS bytes ourselves and exit. Fire-and-forget.
# `no_response:true` in the payload prevents kitty's ack from echoing
# back into the remote shell.
#
# Pass hex colors like "ffb86c", or the literal word "null" to clear.

kitty_set_tab_color() {
    [ -z "$KITTY_WINDOW_ID" ] && [ -z "$KITTY_TAB_MATCHER" ] && return 0
    # set-tab-color uses window_id:N; set-user-vars uses id:N. When
    # KITTY_TAB_MATCHER is set (remote via arca-et), its `var:...` form
    # works for both commands.
    local tab_match uv_match active=$1 inactive=$2
    if [ -n "$KITTY_TAB_MATCHER" ]; then
        tab_match="$KITTY_TAB_MATCHER"
        uv_match="$KITTY_TAB_MATCHER"
    else
        tab_match="window_id:$KITTY_WINDOW_ID"
        uv_match="id:$KITTY_WINDOW_ID"
    fi
    [ "$active"   != "null" ] && active=$((0x$active))
    [ "$inactive" != "null" ] && inactive=$((0x$inactive))
    local color_payload uv_payload
    printf -v color_payload \
        '{"cmd":"set-tab-color","version":[0,26,0],"no_response":true,"payload":{"colors":{"active_bg":%s,"inactive_bg":%s},"match":"%s"}}' \
        "$active" "$inactive" "$tab_match"
    # `claude_tab_pending=1` signals the watcher: "hook just painted this
    # tab; clear it immediately if the window is currently focused".
    printf -v uv_payload \
        '{"cmd":"set-user-vars","version":[0,26,0],"no_response":true,"payload":{"var":["claude_tab_pending=1"],"match":"%s"}}' \
        "$uv_match"
    {
        printf '\033P@kitty-cmd%s\033\\' "$color_payload"
        printf '\033P@kitty-cmd%s\033\\' "$uv_payload"
    } > /dev/tty 2>/dev/null || true
}
