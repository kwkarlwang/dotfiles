#!/bin/bash
# SessionStart hook: stamp the current Claude Code session id and cwd onto
# the local kitty tab via DCS remote control. Works for local sessions
# (KITTY_WINDOW_ID set) and remote arca-et sessions (KITTY_TAB_MATCHER set
# by the arca-et wrapper; DCS bytes ride the et PTY back to the local kitty).
#
# User-vars written:
#   claude_session_id=<uuid>   used by kitty-restore-session.sh for `claude --resume`
#   claude_cwd=<path>          cwd as Claude sees it (remote path for arca-et tabs)
#   claude_remote=1            set only when running under arca-et
set -u

# Need a match target. Bail silently if neither is available (not in kitty).
if [ -n "${KITTY_TAB_MATCHER:-}" ]; then
    match="$KITTY_TAB_MATCHER"
    remote=1
elif [ -n "${KITTY_WINDOW_ID:-}" ]; then
    match="id:$KITTY_WINDOW_ID"
    remote=0
else
    exit 0
fi

input=$(cat)
session_id=$(printf '%s' "$input" | jq -r '.session_id // empty')
cwd=$(printf '%s' "$input" | jq -r '.cwd // empty')
[ -z "$session_id" ] && exit 0

# Build vars list with jq so cwd special chars (quotes, backslashes) are safe.
vars_json=$(jq -cn --arg sid "$session_id" --arg cwd "$cwd" --argjson remote "$remote" '
  [ "claude_session_id=\($sid)" ]
  + (if $cwd   != "" then ["claude_cwd=\($cwd)"] else [] end)
  + (if $remote == 1 then ["claude_remote=1"]    else [] end)
')

payload=$(jq -cn --argjson vars "$vars_json" --arg match "$match" '
  {cmd:"set-user-vars", version:[0,26,0], no_response:true,
   payload:{var:$vars, match:$match}}
')

printf '\033P@kitty-cmd%s\033\\' "$payload" > /dev/tty 2>/dev/null || true
