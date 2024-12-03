-- -- Old app switching config
-- local favoriteApps = {
--   { name = "goland"},
--   { name = "Firefox"},
--   { name = "alacritty"},
--   { name = "emacs"}
-- }

-- local obj = {}
-- obj.currentWindows = {}

-- theWindows = hs.window.filter.new()
-- theWindows:setDefaultFilter{}
-- theWindows:setSortOrder(hs.window.filter.sortByFocusedLast)
-- obj.currentWindows = {}
-- obj.previousSelection = nil  -- the idea is that one switches back and forth between two windows all the time

-- for i,v in ipairs(theWindows:getWindows()) do
--    table.insert(obj.currentWindows, v)
-- end

-- function obj:focus_by_app(appName)
--   print(' [' .. appName ..']')
--   for i,v in ipairs(obj.currentWindows) do
--      print('           [' .. v:application():name() .. ']')
--      if string.find(string.lower(v:application():name()), appName) then
--         print("Focusing window" .. v:title())
--         v:focus()
--         return v
--      end
--   end
--   return nil
-- end


-- -- Function to cycle between open Windows of the application
-- function cycleWindows(appBundleID)
--   local app = hs.application.get(appBundleID)
-- --  print(app:name())
--   if app then
--     local windows = hs.window.filter.new{app:name()}:getWindows()
--     windows[#windows]:focus()
--   end
-- end

-- -- Function to launch or focus an app
-- function launchOrFocusApp(appBundleID)
--   -- cycleWindows(appBundleID)
--   obj:focus_by_app(appBundleID)
-- end

-- Bind hotkeys for favorite apps
-- for i, app in ipairs(favoriteApps) do
--   hs.hotkey.bind({"alt"}, tostring(i), function() launchOrFocusApp(app.name) end)
-- end

d = hs.application("Dock")
for i=1,9 do
    hs.hotkey.bind({"alt"}, tostring(i), function()
        iconNumber = i
        icon = hs.axuielement.applicationElement(d)[1][iconNumber]
        if icon:attributeValue("AXRoleDescription") == "application dock item" then
            icon:performAction("AXPress")
        else
            print ("not an application")
        end
    end)
end

-- New app switching config from 
local hotswitchHs = require("hotswitch-hs/hotswitch-hs")
hotswitchHs.enableAutoUpdate() -- If you don't want to update automatically, remove this line.
hotswitchHs.enableAllSpaceWindows()
hs.hotkey.bind({"command"}, ".", hotswitchHs.openOrClose) -- Set a keybind you like to open HotSwitch-HS panel.

-- hs.loadSpoon("FnMate")

-- j, k, h and l keys are returned as \n, \v, \b and \f when ctrl is pressed down so we have to modify the if else accordingly
-- Also, you have to provide input monitoring access to hammerspoon in macOS for this to work
function catcher(event)
    if event:getFlags()['ctrl'] then
        if event:getCharacters(true) == "h" then
            return true, {hs.eventtap.event.newKeyEvent({}, "left", true)}
        elseif event:getCharacters(true) == "l" then
            return true, {hs.eventtap.event.newKeyEvent({}, "right", true)}
        elseif event:getCharacters(true) == "j" then
            return true, {hs.eventtap.event.newKeyEvent({}, "down", true)}
        elseif event:getCharacters(true) == "k" then
            return true, {hs.eventtap.event.newKeyEvent({}, "up", true)}
        elseif event:getCharacters(true) == "[" then
            return true, {hs.eventtap.event.newKeyEvent({}, "escape", true)}
        end
    end
end
fn_tapper = hs.eventtap.new({hs.eventtap.event.types.keyDown}, catcher):start()
