# dotfiles

Karl's personal machine config, managed with GNU stow.

## Layout

Each top-level directory is a **stow package** whose contents mirror paths
under `$HOME`. Installing:

```
cd ~/dotfiles && stow <package>
```

Stow creates symlinks from `$HOME/<relative-path>` → `~/dotfiles/<package>/<relative-path>`.
Editing the dotfile and editing the symlinked target are equivalent.

Current packages: `alacritty`, `btop`, `claude`, `emacs`, `formatters`,
`hammerspoon`, `karabiner`, `kitty`, `lazygit`, `ranger`, `surfingkeys`,
`vim`, `yabai`, `yazi`, `zathura`, `zim` (zsh).

The `*.sh` files (`brew.sh`, `kitty.sh`, `ranger.sh`, `zim.sh`) are bootstrap
installers for their respective packages, not stow content.

## Private per-machine config

`~/.zshrc.other` is sourced at the end of `~/.zshrc` (zim package) but is
**NOT in the stow tree** — it's machine-local. Put host-specific functions,
secrets, or experimental stuff there rather than in the stow'd zshrc.

## kitty ↔ claude hooks integration

`kitty/` and `claude/` cross-reference each other:

- Claude Code hooks under `claude/.claude/hooks/` write raw DCS escape
  sequences to `/dev/tty` to drive `set-tab-color` on the local kitty.
  They rely on `$KITTY_TAB_MATCHER` (set by the `arca-et` wrapper in
  `~/.zshrc.other`) or `$KITTY_WINDOW_ID` (set automatically by kitty).
- Kitty's tab-color reset binding (`cmd+shift+,`) lives in `kitty.conf`.

Gotchas:
- `listen_on` in `kitty.conf` only accepts UNIX sockets. For TCP, use
  `--listen-on=tcp:...` in `kitty/.config/kitty/macos-launch-services-cmdline`
  (only honored by macOS Launch Services — `open -a kitty` after full
  Cmd-Q, not relaunches from a terminal).
- `kitty @ set-user-vars` matches windows with `id:N`; `set-tab-color`
  matches with `window_id:N`. Different conventions for different commands.
- `kitty @ ls` does **not** report tab-color overrides — don't use it to
  verify `set-tab-color` worked.
- Databricks Arca's sshd silently accepts TCP reverse tunnels (`ssh -R`)
  but doesn't actually forward data. That's why remote tab-coloring goes
  over DCS-via-PTY, not a socket.
- kitty's `@active-kitty-window-id` placeholder substitutes only in
  launch command args, not in `--env` values. If you need to pass the
  source window id to a new tab, use a `combine` action that sets a
  user-var on the source first, then launch + query the marker from the
  new tab (see `cmd+shift+t` binding in `kitty.conf`).
- DCS remote-control responses leak back to the originating shell as
  text unless the payload includes `"no_response":true`. Always set it
  for fire-and-forget sequences.
