---@diagnostic disable: undefined-global
-- reload config
local keymap = hs.keycodes.map
local path = os.getenv("HOME") .. "/dotfiles/hammerspoon/.hammerspoon/"
hs.pathwatcher.new(path, hs.reload):start()

local browserName = "Brave Browser"

----------------------------------------------------------------------
--                          reload config                           --
----------------------------------------------------------------------
local reloadConfig = function()
	hs.alert.show("Config reloaded")
	hs.reload()
end
hs.hotkey.bind({ "cmd", "ctrl", "alt" }, "r", reloadConfig)

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
	local listOfBrowsers = { "Chromium", "Brave" }
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

	hs.eventtap.keyStroke({ "cmd", "option" }, hs.keycodes.map["b"], 2e5, app)
	hs.eventtap.keyStroke({ "cmd" }, hs.keycodes.map["l"], 2e5, app)
	hs.eventtap.keyStrokes(website, app)
	hs.eventtap.keyStroke({}, hs.keycodes.map["return"], 2e5, app)
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
		hs.eventtap.keyStroke({}, hs.keycodes.map.tab, 5e3, fortiClient)
		hs.eventtap.keyStroke({}, hs.keycodes.map.tab, 5e3, fortiClient)
		hs.eventtap.keyStrokes(ignore.fortiUsername, fortiClient)
		hs.eventtap.keyStroke({}, hs.keycodes.map.tab, 5e3, fortiClient)
		hs.eventtap.keyStrokes(ignore.fortiPassword, fortiClient)
		hs.eventtap.keyStroke({}, hs.keycodes.map["return"], 5e3, fortiClient)
		hs.eventtap.keyStroke({}, hs.keycodes.map.tab, 5e3, fortiClient)
		hs.eventtap.keyStroke({}, hs.keycodes.map.tab, 5e3, fortiClient)
		hs.eventtap.keyStroke({}, hs.keycodes.map.tab, 5e3, fortiClient)
		hs.eventtap.keyStroke({ "cmd" }, hs.keycodes.map["h"], 5e3, fortiClient)
	end)

	hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "o", function()
		hs.eventtap.keyStrokes(ignore.gitUsername)
		hs.eventtap.keyStroke({}, hs.keycodes.map["return"])
		hs.eventtap.keyStrokes(ignore.gitPassword)
		hs.eventtap.keyStroke({}, hs.keycodes.map["return"])
	end)
end
----------------------------------------------------------------------
--                          launch browser                          --
----------------------------------------------------------------------
hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "b", function()
	local browserIsRunning = hs.application.find(browserName) ~= nil
	if browserIsRunning then
		hs.osascript.applescript([[tell application "]] .. browserName .. [["
			make new window
		end tell]])
	else
		hs.application.open(browserName)
	end
end)
