#!/bin/bash
# Shared helper for the tab-color hooks.
#
# We can't use `kitty @ set-tab-color` here because it expects a reply on
# the same channel and there's no --no-response flag in kitty 0.46. So we
# write raw DCS bytes ourselves with `no_response:true` in the payload —
# fire-and-forget, kitty's ack never comes back to echo into the shell.
#
# We can't write to /dev/tty either: Claude Code spawns hooks detached
# from the controlling terminal (TTY=?? in ps), so open("/dev/tty")
# returns ENXIO. Instead, walk up the process tree to find an ancestor
# (claude → shell → kitty/ssh) that has a real PTY, and write DCS bytes
# to that device. Locally that's kitty's PTY slave; under arca-et it's
# the SSH session's PTY, whose master is back on the local kitty — same
# bytes, same destination.
#
# Pass hex colors like "ffb86c", or the literal word "null" to clear.

# Find a writable PTY device by walking up the process tree.
# Echoes the device path (e.g. /dev/ttys001, /dev/pts/3) and returns 0,
# or returns 1 if no ancestor has a real ctty.
_kitty_ctty() {
    local pid=$PPID t
    while [ -n "$pid" ] && [ "$pid" != "0" ] && [ "$pid" != "1" ]; do
        t=$(ps -o tty= -p "$pid" 2>/dev/null | tr -d ' ')
        case "$t" in
            ''|'?'|'??') ;;
            *) printf '/dev/%s' "$t"; return 0 ;;
        esac
        pid=$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')
    done
    return 1
}

kitty_set_tab_color() {
    [ -z "$KITTY_WINDOW_ID" ] && [ -z "$KITTY_TAB_MATCHER" ] && return 0
    local ctty
    ctty=$(_kitty_ctty) || return 0
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
    } > "$ctty" 2>/dev/null || true
}
