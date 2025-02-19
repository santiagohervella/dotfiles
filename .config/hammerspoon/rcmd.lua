-- To stop complaints about missing globals hs and spoon
---@diagnostic disable: undefined-global

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:andUse("LeftRightHotkey")

-- Track the most recently used application index for each hotkey
local lastUsedApp = {}

-- Function to bind hotkeys and cycle through apps
local function bindHotkeys(hotkeys)
	for _, hotkey in ipairs(hotkeys) do
		lastUsedApp[hotkey.key] = nil -- Initialize the most recently used app to nil
		spoon.LeftRightHotkey:bind({ "rOption" }, hotkey.key, function()
			local apps = hotkey.apps
			local currentApp = hs.application.frontmostApplication()
			local appName = currentApp and currentApp:name() or nil
			local appIndex = lastUsedApp[hotkey.key] and hs.fnutils.indexOf(apps, lastUsedApp[hotkey.key]) or 1
			local originalAppIndex = appIndex
			local appFound = false

			repeat
				if appName == apps[appIndex] then
					-- Move to the next app in the list
					appIndex = appIndex % #apps + 1
				end

				local app = hs.appfinder.appFromName(apps[appIndex])

				if app then
					app:activate()
					-- Update the most recently used app
					lastUsedApp[hotkey.key] = apps[appIndex]
					appFound = true
				else
					-- Move to the next app in the list
					appIndex = appIndex % #apps + 1
				end
			until appFound or appIndex == originalAppIndex

			if not appFound and appName ~= apps[originalAppIndex] then
				hs.alert.show("App not found in " .. table.concat(apps, ", "))
			end
		end)
	end
end

local hotkeys = {
	{ key = "1", apps = { "1Password 7", "1Password" } },
	{ key = "A", apps = { "Arc" } },
	{ key = "B", apps = { "Beekeeper Studio" } },
	{ key = "E", apps = { "Microsoft Edge" } },
	{ key = "F", apps = { "Finder", "Figma" } },
	{ key = "G", apps = { "Ghostty" } },
	{ key = "H", apps = { "Horse" } },
	{ key = "I", apps = { "iTerm2" } },
	{ key = "K", apps = { "Keyboard Maestro" } },
	{ key = "M", apps = { "Messages", "Music" } },
	{ key = "N", apps = { "Notes" } },
	{ key = "O", apps = { "Omnifocus", "Obsidian" } },
	{ key = "P", apps = { "Postman", "Play", "Preview", "PyCharm" } },
	{ key = "Q", apps = { "QuickTime Player" } },
	{ key = "R", apps = { "Reeder" } },
	{ key = "S", apps = { "Slack" } },
	{ key = "T", apps = { "TextEdit", "Transmission" } },
	{ key = "V", apps = { "AWS VPN Client" } },
	{ key = "Z", apps = { "zoom.us", "Zed", "Zen Browser" } },
	{ key = "W", apps = { "WezTerm" } },
}

bindHotkeys(hotkeys)
spoon.LeftRightHotkey:start()

local function applicationWatcher(appName, eventType, _)
	if eventType == hs.application.watcher.activated then
		for _, hotkey in ipairs(hotkeys) do
			if hs.fnutils.contains(hotkey.apps, appName) then
				lastUsedApp[hotkey.key] = appName
			end
		end
	end
end

APP_WATCHER = hs.application.watcher.new(applicationWatcher)
APP_WATCHER:start()
