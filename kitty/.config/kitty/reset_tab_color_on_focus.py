"""Kitty watcher: 'unread indicator' model for tab colors.

Behavior:
  * Stop/Notification hooks paint a tab, but if the tab is focused
    when the hook fires, clear immediately — user already sees it.
  * Focusing a painted (background) tab clears the color.
  * cmd+, marks a tab purple; it doesn't set the marker user-var,
    so it persists until the next focus change.

Hooks send set-tab-color plus set-user-vars `claude_tab_pending=1`.
We use window.is_focused to decide whether to paint or clear.
"""
from kitty.boss import Boss
from kitty.window import Window


def _reset_tab(boss: Boss, window: Window) -> None:
    boss.call_remote_control(
        window,
        (
            'set-tab-color',
            '--match', f'window_id:{window.id}',
            'active_bg=NONE',
            'inactive_bg=NONE',
        ),
    )


def on_focus_change(boss: Boss, window: Window, data: dict) -> None:
    if data.get('focused'):
        for uv in ('claude_tab_pending', 'tab_sticky'):
            if window.user_vars.get(uv) == '1':
                window.set_user_var(uv, '')
        _reset_tab(boss, window)


def on_set_user_var(boss: Boss, window: Window, data: dict) -> None:
    if data.get('key') != 'claude_tab_pending':
        return
    if data.get('value') != '1':
        return
    if not getattr(window, 'is_focused', False):
        return
    window.set_user_var('claude_tab_pending', '')
    _reset_tab(boss, window)
