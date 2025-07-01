-- d = hs.application("Dock")
-- for i=1,9 do
--     hs.hotkey.bind({"alt"}, tostring(i), function()
--         iconNumber = i
--         icon = hs.axuielement.applicationElement(d)[1][iconNumber]
--         if icon:attributeValue("AXRoleDescription") == "application dock item" then
--             icon:performAction("AXPress")
--         else
--             print ("not an application")
--         end
--     end)
-- end

local function launchOrFocusOrRotate(app)
	local focusedWindow = hs.window.focusedWindow()
	-- Output of the above is an hs.window object

	-- I can get the application it belongs to via the :application() method
	-- See https://www.hammerspoon.org/docs/hs.window.html#application
	local focusedWindowApp = focusedWindow:application()
	-- This returns an hs.application object

	-- Get the name of this application; this isn't really useful fof us as launchOrFocus needs the app name on disk
	-- I do use it below, further on...
	local focusedWindowAppName = focusedWindowApp:name()

	-- This gives the path - /Applications/<application>.app
	local focusedWindowPath = focusedWindowApp:path()

	-- I need to extract <application> from that
	local appNameOnDisk = string.gsub(focusedWindowPath, "/Applications/", "")
	local appNameOnDisk = string.gsub(appNameOnDisk, ".app", "")
	-- Finder has this as its path
	local appNameOnDisk = string.gsub(appNameOnDisk, "/System/Library/CoreServices/", "")

	-- If already focused, try to find the next window
	if focusedWindow and appNameOnDisk == app then
		-- hs.application.get needs the name as per hs.application:name() and not the name on disk
		-- It can also take pid or bundle, but that doesn't help here
		-- Since I have the name already from above, I can use that though
		local appWindows = hs.application.get(focusedWindowAppName):allWindows()

		-- https://www.hammerspoon.org/docs/hs.application.html#allWindows
		-- A table of zero or more hs.window objects owned by the application. From the current space.

		if #appWindows > 0 then
			-- It seems that this list order changes after one window get focused,
			-- Let's directly bring the last one to focus every time
			-- https://www.hammerspoon.org/docs/hs.window.html#focus
			if app == "Finder" then
				-- If the app is Finder the window count returned is one more than the actual count, so I subtract
				appWindows[#appWindows - 1]:focus()
			else
				appWindows[#appWindows]:focus()
			end
		else
			-- this should not happen, but just in case
			hs.application.launchOrFocus(app)
		end
	else -- if not focused
		hs.application.launchOrFocus(app)
	end
end

local ctrlCmdShortcuts = {
	{ "1", "IntelliJ IDEA" },
	{ "2", "Ghostty" },
	{ "3", "Vivaldi" },
	{ "4", "Obsidian" },
	{ "5", "Finder" },
	{ "s", "Slack" },
	{ "z", "zoom.us" },
	{ "x", "Postman" },
	{ "a", "Zotero" },
}

for i, shortcut in ipairs(ctrlCmdShortcuts) do
	hs.hotkey.bind({ "alt" }, shortcut[1], function()
		-- hs.application.launchOrFocus(shortcut[2])
		launchOrFocusOrRotate(shortcut[2])
	end)
end

-- New app switching config from
-- local hotswitchHs = require("hotswitch-hs/hotswitch-hs")
-- hotswitchHs.enableAutoUpdate() -- If you don't want to update automatically, remove this line.
-- hotswitchHs.enableAllSpaceWindows()
-- hs.hotkey.bind({ "command" }, ".", hotswitchHs.openOrClose) -- Set a keybind you like to open HotSwitch-HS panel.

-- hs.loadSpoon("FnMate")

-- j, k, h and l keys are returned as \n, \v, \b and \f when ctrl is pressed down so we have to modify the if else accordingly
-- Also, you have to provide input monitoring access to hammerspoon in macOS for this to work
function catcher(event)
	if event:getFlags()["ctrl"] then
		if event:getCharacters(true) == "h" then
			return true, { hs.eventtap.event.newKeyEvent({}, "left", true) }
		elseif event:getCharacters(true) == "l" then
			return true, { hs.eventtap.event.newKeyEvent({}, "right", true) }
		elseif event:getCharacters(true) == "j" then
			return true, { hs.eventtap.event.newKeyEvent({}, "down", true) }
		elseif event:getCharacters(true) == "k" then
			return true, { hs.eventtap.event.newKeyEvent({}, "up", true) }
		elseif event:getCharacters(true) == "[" then
			return true, { hs.eventtap.event.newKeyEvent({}, "escape", true) }
		end
	end
end
fn_tapper = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, catcher):start()
