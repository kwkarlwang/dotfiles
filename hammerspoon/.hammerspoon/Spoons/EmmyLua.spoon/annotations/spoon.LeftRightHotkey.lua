--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- This spoon addresses a limitation within the [hs.hotkey](hs.hotkey.html) module that allows the creation of hotkeys bound to specific left or right keyboard modifiers while leaving the other side free.
--
-- This is accomplished by creating unactivated hotkeys for each definition and using an [hs.eventtap](hs.eventtap.html) watcher to detect when modifier keys are pressed and conditionally activating only those hotkeys which correspond to the left or right modifiers currently active as specified by the `bind` and `new` methods of this spoon.
--
-- The `LeftRightHotkeyObject` that is returned by [LeftRightHotkey:new](#new) and [LeftRightHotkey:bind](#bind) supports the following methods in a manner similar to the [hs.hotkey](hs.hotkey.html) equivalents:
--
--  * `LeftRightHotkeyObject:enable()`   -- enables the registered hotkey.
--  * `LeftRightHotkeyObject:disable()`  -- disables the registered hotkey.
--  * `LeftRightHotkeyObject:delete()`   -- deletes the registered hotkey.
--  * `LeftRightHotkeyObject:isEnabled() -- returns a boolean value specifying whether the hotkey is currently enabled (true) or disabled (false)
--
-- The following modifiers are recognized by this spoon in the modifier table when setting up hotkeys with this spoon:
--    * "lCmd", "lCommand", or "l⌘" for the left Command modifier
--    * "rCmd", "rCommand", or "r⌘" for the right Command modifier
--    * "lCtrl", "lControl" or "l⌃" for the left Control modifier
--    * "rCtrl", "rControl" or "r⌃" for the right Control modifier
--    * "lAlt", "lOpt", "lOption" or "l⌥" for the left Option modifier
--    * "rAlt", "rOpt", "rOption" or "r⌥" for the right Option modifier
--    * "lShift" or "l⇧" for the left Shift modifier
--    * "rShift" or "r⇧" for the right Shift modifier
--
-- The modifiers table for any given hotkey is all inclusive; this means that if you specify `{ "rShift", "lShift" }` then *both* the left and right shift keys *must* be pressed to trigger the hotkey -- if you want either/or, then stick with [hs.hotkey](hs.hotkey.html).
--
-- Alternatively, if you want to setup a hotkey when *either* command key is pressed with *only* the right shift, you would need to set up two hotkeys with this spoon:
--  e.g. `LeftRightHotkey:bind({ "rCmd", "rShift" }, "a", myFunction)` *and* `LeftRightHotkey:bind({ "lCmd", "rShift" }, "a", myFunction)`
--
-- This spoon works by using an eventtap to detect flag changes (modifier keys) and when they change, the appropriate hotkeys are enabled or disabled. This means that you should be aware of the following:
--  * like all eventtaps, if the Hammerspoon application is particularly busy with some other task, it is possible for the flag change to be missed or for the macOS to disable the eventtap entirely.
--  * behind the scenes, when a given set of flag changes occur that match a defined hotkey, the hotkey is actually enabled through `hs.hotkey:enable()` -- this means that in truth, either side's modifiers would trigger the callback. Under normal circumstances this won't be noticed because as soon as you switch to the alternate side's modifier, the flag change event will be detected and the hotkey will be disabled. However, as noted above, if Hammerspoon is particularly busy, it is possible for this event to be missed.
--    * a timer runs (once this Spoon has been started the first time) which will check to see if the eventtap has been internally disabled and re-enable it if necessary; alternatively you can re-issue [LeftRightHotkey:start()](#start) to force the eventtap to be reset if necessary.
--    * if your hotkeys seem out of sync, try pressing and releasing any modifier key -- this will reset the enabled/disabled hotkeys if a previous flag change was missed, but the eventtap is still running or has been reset by one of the methods described above.
--
-- Like all Spoons, don't forget to use the [LeftRightHotkey:start()](#start) method to activate the modifier key watcher.
--
-- Download: `svn export https://github.com/asmagill/hammerspoon-config-take2/trunk/_Spoons/LeftRightHotkey.spoon`
---@class spoon.LeftRightHotkey
local M = {}
spoon.LeftRightHotkey = M

-- Create and enable a new hotkey with the specified left/right specific modifiers.
--
-- Parameters:
-- Parameters:
--  * mods - A table containing as elements the keyboard modifiers required, which should be one or more of the following:
--    * "lCmd", "lCommand", or "l⌘" for the left Command modifier
--    * "rCmd", "rCommand", or "r⌘" for the right Command modifier
--    * "lCtrl", "lControl" or "l⌃" for the left Control modifier
--    * "rCtrl", "rControl" or "r⌃" for the right Control modifier
--    * "lAlt", "lOpt", "lOption" or "l⌥" for the left Option modifier
--    * "rAlt", "rOpt", "rOption" or "r⌥" for the right Option modifier
--    * "lShift" or "l⇧" for the left Shift modifier
--    * "rShift" or "r⇧" for the right Shift modifier
--  * key - A string containing the name of a keyboard key (as found in [hs.keycodes.map](hs.keycodes.html#map) ), or a raw keycode number
--  * message - (optional) A string containing a message to be displayed via [hs.alert()](hs.alert.html) when the hotkey has been triggered; if omitted, no alert will be shown
--  * pressedfn - A function that will be called when the hotkey has been pressed, or nil
--  * releasedfn - A function that will be called when the hotkey has been released, or nil
--  * repeatfn - A function that will be called when a pressed hotkey is repeating, or nil
--
-- Returns:
--  * a new enabled hotkey with the specified left/right modifiers.
--
-- Notes:
--  * This function is just a wrapper that performs `LeftRightHotkey:new(...):enable()`
--  * The modifiers table is adjusted for use when conditionally activating the appropriate hotkeys based on the current modifiers in effect, but the other arguments are passed to [hs.hotkey.bind](hs.hotkey.html#bind) as is and any caveats or considerations outlined there also apply here.
function M:bind(mods, key, message, pressedfn, releasedfn, repeatfn, ...) end

-- Deletes all previously set callbacks for a given keyboard combination
--
-- Parameters:
--  * mods - A table containing as elements the keyboard modifiers required, which should be one or more of the following:
--    * "lCmd", "lCommand", or "l⌘" for the left Command modifier
--    * "rCmd", "rCommand", or "r⌘" for the right Command modifier
--    * "lCtrl", "lControl" or "l⌃" for the left Control modifier
--    * "rCtrl", "rControl" or "r⌃" for the right Control modifier
--    * "lAlt", "lOpt", "lOption" or "l⌥" for the left Option modifier
--    * "rAlt", "rOpt", "rOption" or "r⌥" for the right Option modifier
--    * "lShift" or "l⇧" for the left Shift modifier
--    * "rShift" or "r⇧" for the right Shift modifier
--  * key - A string containing the name of a keyboard key (as found in [hs.keycodes.map](hs.keycodes.html#map) ), or a raw keycode number
--
-- Returns:
--  * None
function M:deleteAll(mods, key, ...) end

-- Disables all previously set callbacks for a given keyboard combination
--
-- Parameters:
--  * mods - A table containing as elements the keyboard modifiers required, which should be one or more of the following:
--    * "lCmd", "lCommand", or "l⌘" for the left Command modifier
--    * "rCmd", "rCommand", or "r⌘" for the right Command modifier
--    * "lCtrl", "lControl" or "l⌃" for the left Control modifier
--    * "rCtrl", "rControl" or "r⌃" for the right Control modifier
--    * "lAlt", "lOpt", "lOption" or "l⌥" for the left Option modifier
--    * "rAlt", "rOpt", "rOption" or "r⌥" for the right Option modifier
--    * "lShift" or "l⇧" for the left Shift modifier
--    * "rShift" or "r⇧" for the right Shift modifier
--  * key - A string containing the name of a keyboard key (as found in [hs.keycodes.map](hs.keycodes.html#map) ), or a raw keycode number
--
-- Returns:
--  * None
function M:disableAll(mods, key, ...) end

-- Create a new hotkey with the specified left/right specific modifiers.
--
-- Parameters:
--  * mods - A table containing as elements the keyboard modifiers required, which should be one or more of the following:
--    * "lCmd", "lCommand", or "l⌘" for the left Command modifier
--    * "rCmd", "rCommand", or "r⌘" for the right Command modifier
--    * "lCtrl", "lControl" or "l⌃" for the left Control modifier
--    * "rCtrl", "rControl" or "r⌃" for the right Control modifier
--    * "lAlt", "lOpt", "lOption" or "l⌥" for the left Option modifier
--    * "rAlt", "rOpt", "rOption" or "r⌥" for the right Option modifier
--    * "lShift" or "l⇧" for the left Shift modifier
--    * "rShift" or "r⇧" for the right Shift modifier
--  * key - A string containing the name of a keyboard key (as found in [hs.keycodes.map](hs.keycodes.html#map) ), or a raw keycode number
--  * message - (optional) A string containing a message to be displayed via [hs.alert()](hs.alert.html) when the hotkey has been triggered; if omitted, no alert will be shown
--  * pressedfn - A function that will be called when the hotkey has been pressed, or nil
--  * releasedfn - A function that will be called when the hotkey has been released, or nil
--  * repeatfn - A function that will be called when a pressed hotkey is repeating, or nil
--
-- Returns:
--  * a new, initially disabled, hotkey with the specified left/right modifiers.
--
-- Notes:
--  * The modifiers table is adjusted for use when conditionally activating the appropriate hotkeys based on the current modifiers in effect, but the other arguments are passed to [hs.hotkey.new](hs.hotkey.html#new) as is and any caveats or considerations outlined there also apply here.
function M:new(mods, key, message, pressedfn, releasedfn, repeatfn, ...) end

-- Starts watching for flag (modifier key) change events that can determine if the right or left modifiers have been pressed.
--
-- Parameters:
--  * None
--
-- Returns:
--  * the LeftRightHotkey spoon object
--
-- Notes:
--  * this enables the use of hotkeys created by using this Spoon.
---@return spoon.LeftRightHotkey
function M:start() end

-- Stops watching for flag (modifier key) change events that can determine if the right or left modifiers have been pressed.
--
-- Parameters:
--  * None
--
-- Returns:
--  * the LeftRightHotkey spoon object
--
-- Notes:
--  * this will implicitly disable all hotkeys created by using this Spoon -- only those hotkeys which are defined with [hs.hotkey](hs.hotkey.html) directly will still be available.
---@return spoon.LeftRightHotkey
function M:stop() end

