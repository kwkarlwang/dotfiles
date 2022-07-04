---@diagnostic disable: undefined-global
-- reload config
local keymap = hs.keycodes.map
local path = os.getenv("HOME") .. "/dotfiles/hammerspoon/.hammerspoon/"
hs.pathwatcher.new(path, hs.reload):start()

-- local browserName = "Brave Browser"
-- local browserName = "Google Chrome"
local browserName = "Safari"

----------------------------------------------------------------------
--                          reload config                           --
----------------------------------------------------------------------
local reloadConfig = function()
	hs.reload()
end
hs.hotkey.bind({ "cmd", "ctrl", "alt" }, "r", reloadConfig)
hs.alert.show("Config reloaded")

----------------------------------------------------------------------
--                       dismiss notification                       --
----------------------------------------------------------------------
local dismissNotification = function()
	hs.osascript.javascriptFromFile(path .. "close_notifications.js")
end
hs.hotkey.bind({ "rightshift" }, keymap["escape"], dismissNotification)

----------------------------------------------------------------------
--                      send test notification                      --
----------------------------------------------------------------------
hs.hotkey.bind({ "cmd", "ctrl", "shift" }, "/", function()
	hs.notify.new({ title = "hammerspoon" }):send()
end)

----------------------------------------------------------------------
--                         Connect AirPods                          --
----------------------------------------------------------------------
local airpodsId = "ac-1d-06-ac-a7-29"
local connectAirPods = function()
	local cmd = "blueutil --connect " .. airpodsId
	hs.execute(cmd, true)
end

local disconnectAirPods = function()
	local cmd = "blueutil --disconnect " .. airpodsId
	hs.execute(cmd, true)
end
local toggleAirPods = function()
	local device = hs.audiodevice.defaultOutputDevice()
	local isAirPods = string.find(tostring(device), "AirPods") ~= nil
	if isAirPods == true then
		hs.alert.show("Disconnecting AirPods")
		disconnectAirPods()
	else
		hs.alert.show("Connecting AirPods")
		connectAirPods()
	end
end
hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "a", toggleAirPods)

----------------------------------------------------------------------
--                        Change resolution                         --
----------------------------------------------------------------------

-- function dump(o)
-- 	if type(o) == "table" then
-- 		local s = "{ "
-- 		for k, v in pairs(o) do
-- 			if type(k) ~= "number" then
-- 				k = '"' .. k .. '"'
-- 			end
-- 			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
-- 		end
-- 		return s .. "} "
-- 	else
-- 		return tostring(o)
-- 	end
-- end

local toggleResolution = function()
	local allScreens = hs.screen.allScreens()
	local screen = nil
	for _, val in pairs(allScreens) do
		if string.find(tostring(val), "Built%-in") ~= nil then
			screen = val
		end
	end
	if screen == nil then
		return
	end

	local mode = screen:currentMode()
	if mode["w"] == 1536 then
		local width = 1152
		local height = 720
		hs.alert.show("Switching to lower resolution")
		screen:setMode(width, height, mode["scale"], mode["freq"], mode["depth"])
	else
		local width = 1536
		local height = 960
		hs.alert.show("Switching to higher resolution")
		screen:setMode(width, height, mode["scale"], mode["freq"], mode["depth"])
	end
end
hs.hotkey.bind({ "cmd", "ctrl", "shift" }, "s", toggleResolution)
----------------------------------------------------------------------
--                            Open Gmail                            --
----------------------------------------------------------------------
local checkBrowser = function(app)
	local listOfBrowsers = { "Chromium", "Brave", "Chrome" }
	for _, v in pairs(listOfBrowsers) do
		if string.find(app, v) ~= nil then
			return true
		end
	end
	return false
end
local goToWebsite = function(website)
	local app = hs.application.frontmostApplication()
	local isBrowser = checkBrowser(tostring(app))
	if isBrowser == false then
		return
	end

	hs.eventtap.keyStroke({ "cmd", "option" }, "b", 2e5, app)
	hs.eventtap.keyStroke({ "cmd" }, "l", 2e5, app)
	hs.eventtap.keyStrokes(website, app)
	hs.eventtap.keyStroke({}, keymap["return"], 2e5, app)
end
local goToPersonal = function()
	local url = "https://mail.google.com/mail/u/0/#inbox"
	goToWebsite(url)
end
local goToSchool = function()
	local url = "https://mail.google.com/mail/u/1/#inbox"
	goToWebsite(url)
end

local goToWork = function()
	local url = "https://mail.google.com/mail/u/2/#inbox"
	goToWebsite(url)
end

local goToCalendar = function()
	local url = "https://calendar.google.com/calendar/u/2/r"
	goToWebsite(url)
end
hs.hotkey.bind({ "cmd", "alt" }, "1", goToPersonal)
hs.hotkey.bind({ "cmd", "alt" }, "2", goToSchool)
hs.hotkey.bind({ "cmd", "alt" }, "3", goToWork)
hs.hotkey.bind({ "cmd", "alt" }, "4", goToCalendar)
----------------------------------------------------------------------
--                               Work                               --
----------------------------------------------------------------------
local status_ok, ignore = pcall(require, "ignore")
if status_ok then
	hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "p", function()
		local fortiClient = hs.application.open("FortiClient", 3, true)
		if fortiClient == nil then
			hs.alert.show("failed to launch")
			return
		end
		hs.timer.usleep(5e5)
		hs.eventtap.keyStroke({}, keymap.tab, 5e3, fortiClient)
		hs.eventtap.keyStroke({}, keymap.tab, 5e3, fortiClient)
		hs.eventtap.keyStrokes(ignore.fortiUsername, fortiClient)
		hs.eventtap.keyStroke({}, keymap.tab, 5e3, fortiClient)
		hs.eventtap.keyStrokes(ignore.fortiPassword, fortiClient)
		hs.eventtap.keyStroke({}, keymap["return"], 5e3, fortiClient)
		hs.eventtap.keyStroke({}, keymap.tab, 5e3, fortiClient)
		hs.eventtap.keyStroke({}, keymap.tab, 5e3, fortiClient)
		hs.eventtap.keyStroke({}, keymap.tab, 5e3, fortiClient)
		hs.eventtap.keyStroke({ "cmd" }, "h", 5e3, fortiClient)
	end)

	hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "o", function()
		hs.eventtap.keyStrokes(ignore.gitUsername)
		hs.eventtap.keyStroke({}, keymap["return"])
		hs.eventtap.keyStrokes(ignore.gitPassword)
		hs.eventtap.keyStroke({}, keymap["return"])
	end)
end
----------------------------------------------------------------------
--                          launch browser                          --
----------------------------------------------------------------------
hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "b", function()
	if browserName == "Safari" then
		local browserIsRunning = hs.application.get(browserName) ~= nil
		if browserIsRunning then
			hs.osascript.applescript([[tell application "]] .. browserName .. [["
				make new document at end of documents
			end tell]])
		end
		hs.application.launchOrFocus(browserName)
	else
		local browserIsRunning = hs.application.find(browserName) ~= nil
		if browserIsRunning then
			hs.alert(hs.application.find(browserName))
			hs.osascript.applescript([[tell application "]] .. browserName .. [["
			make new window
		end tell]])
		else
			hs.application.open(browserName)
		end
	end
end)
----------------------------------------------------------------------
--                            remap keys                            --
----------------------------------------------------------------------
local enableHotkeyForApps = function(appNames, hotkeys)
	local filter = hs.window.filter.new(appNames)
	filter:subscribe(hs.window.filter.windowFocused, function()
		for _, hotkey in pairs(hotkeys) do
			hotkey:enable()
		end
	end)
	filter:subscribe(hs.window.filter.windowUnfocused, function()
		for _, hotkey in pairs(hotkeys) do
			hotkey:disable()
		end
	end)
end
local goRight = function()
	hs.eventtap.keyStroke({}, "Right", 1)
end
local goRightHotkey = hs.hotkey.new({ "ctrl" }, "s", goRight, nil, goRight)
local goLeft = function()
	hs.eventtap.keyStroke({}, "Left", 1)
end
local goLeftHotkey = hs.hotkey.new({ "ctrl" }, "a", goLeft, nil, goLeft)
local leftClickHotkey = hs.hotkey.new({ "ctrl" }, "f", function()
	hs.eventtap.leftClick(hs.mouse.absolutePosition())
end)
enableHotkeyForApps({ browserName }, { goRightHotkey, goLeftHotkey, leftClickHotkey })
