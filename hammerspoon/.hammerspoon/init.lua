---@diagnostic disable: undefined-global
-- reload config
local keymap = hs.keycodes.map
local path = os.getenv("HOME") .. "/dotfiles/hammerspoon/.hammerspoon/"
hs.pathwatcher.new(path, hs.reload):start()
require("forticlient")

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
	local cmd = "/usr/local/bin/blueutil --connect " .. airpodsId
	hs.execute(cmd, false)
end

local disconnectAirPods = function()
	local cmd = "/usr/local/bin/blueutil --disconnect " .. airpodsId
	hs.execute(cmd, false)
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
--                        CHange resolution                         --
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
