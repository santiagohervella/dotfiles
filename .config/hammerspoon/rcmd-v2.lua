-- rcmd-v2.lua - App switcher using right-option + letter/number
-- Switches between running apps based on their first letter, with MRU ordering
-- Written by Claude

--------------------------------------------------------------------------------
-- Configuration
--------------------------------------------------------------------------------

-- Manual overrides: map app names to custom keys
local OVERRIDES = {
	["Ghostty"] = "i",
	["AWS VPN Client"] = "v",
}

--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------

local dockAppsCache = {} -- Running apps with Dock presence: { appName = appObject }
local mruByKey = {} -- MRU lists per key: { a = {"Arc", "Activity Monitor"}, ... }

--------------------------------------------------------------------------------
-- List Helpers
--------------------------------------------------------------------------------

-- Find index of item in list, returns nil if not found
local function indexOf(list, item)
	for i, v in ipairs(list) do
		if v == item then
			return i
		end
	end
	return nil
end

-- Remove all occurrences of item from list (in-place)
local function removeAll(list, item)
	for i = #list, 1, -1 do
		if list[i] == item then
			table.remove(list, i)
		end
	end
end

--------------------------------------------------------------------------------
-- Core Logic
--------------------------------------------------------------------------------

-- Get the key an app should respond to (considering overrides)
local function getAppKey(appName)
	local override = OVERRIDES[appName]
	if override then
		return override:lower()
	end

	local firstChar = appName:sub(1, 1):lower()
	return firstChar:match("[a-z0-9]") -- Returns nil for non-alphanumeric
end

-- Get all running apps that show in the Dock
local function getDockApps()
	local apps = {}
	for _, app in ipairs(hs.application.runningApplications()) do
		local name = app:name()
		if name and name ~= "" and app:kind() == 1 then
			apps[name] = app
		end
	end
	return apps
end

-- Refresh the Dock apps cache and sync MRU lists
local function refreshDockAppsCache()
	dockAppsCache = getDockApps()

	-- Remove closed apps from MRU lists
	for _, mruList in pairs(mruByKey) do
		for i = #mruList, 1, -1 do
			if not dockAppsCache[mruList[i]] then
				table.remove(mruList, i)
			end
		end
	end

	-- Add new apps to MRU lists
	for appName in pairs(dockAppsCache) do
		local key = getAppKey(appName)
		if key then
			mruByKey[key] = mruByKey[key] or {}
			if not indexOf(mruByKey[key], appName) then
				table.insert(mruByKey[key], appName)
			end
		end
	end
end

-- Move app to front of its MRU list
local function updateMRU(appName)
	local key = appName and getAppKey(appName)
	if not key then
		return
	end

	mruByKey[key] = mruByKey[key] or {}
	removeAll(mruByKey[key], appName)
	table.insert(mruByKey[key], 1, appName)
end

-- Get running apps for a key, ordered by MRU
local function getAppsForKey(key)
	local apps = {}
	for _, appName in ipairs(mruByKey[key] or {}) do
		if dockAppsCache[appName] then
			table.insert(apps, appName)
		end
	end
	return apps
end

-- Activate the next app for a given key
local function activateNextApp(key)
	local apps = getAppsForKey(key)

	if #apps == 0 then
		hs.alert.show("No apps for '" .. key:upper() .. "'", 0.5)
		return
	end

	-- Find current app's position in the list
	local currentApp = hs.application.frontmostApplication()
	local currentName = currentApp and currentApp:name()
	local currentIndex = indexOf(apps, currentName) or 0

	-- Cycle to next app (or first if current isn't in list)
	local nextIndex = (currentIndex % #apps) + 1
	local targetName = apps[nextIndex]
	local targetApp = dockAppsCache[targetName]

	if not targetApp then
		return
	end

	-- Try to activate, refreshing stale references if needed
	local success = targetApp:activate()
	if not success then
		local freshApp = hs.application.get(targetName)
		if freshApp then
			dockAppsCache[targetName] = freshApp
			success = freshApp:activate()
		end
	end

	if success then
		updateMRU(targetName)
	else
		-- App is gone, clean up and retry
		dockAppsCache[targetName] = nil
		local appKey = getAppKey(targetName)
		if appKey and mruByKey[appKey] then
			removeAll(mruByKey[appKey], targetName)
		end
		activateNextApp(key)
	end
end

--------------------------------------------------------------------------------
-- Event Handling
--------------------------------------------------------------------------------

local appWatcher = hs.application.watcher.new(function(appName, eventType)
	if eventType == hs.application.watcher.activated then
		if appName and not dockAppsCache[appName] then
			refreshDockAppsCache()
		end
		if appName then
			updateMRU(appName)
		end
	elseif eventType == hs.application.watcher.launched or eventType == hs.application.watcher.terminated then
		refreshDockAppsCache()
	end
end)

--------------------------------------------------------------------------------
-- Hotkey Setup
--------------------------------------------------------------------------------

local function setupHotkeys()
	-- Letters a-z
	for i = 97, 122 do
		local letter = string.char(i)
		spoon.LeftRightHotkey:bind({ "rOption" }, letter, function()
			activateNextApp(letter)
		end)
	end

	-- Numbers 0-9
	for i = 0, 9 do
		local num = tostring(i)
		spoon.LeftRightHotkey:bind({ "rOption" }, num, function()
			activateNextApp(num)
		end)
	end
end

--------------------------------------------------------------------------------
-- Initialization
--------------------------------------------------------------------------------

local function init()
	hs.loadSpoon("SpoonInstall")
	spoon.SpoonInstall:andUse("LeftRightHotkey")

	refreshDockAppsCache()

	-- Put frontmost app at front of its MRU list
	local frontmost = hs.application.frontmostApplication()
	if frontmost then
		updateMRU(frontmost:name())
	end

	appWatcher:start()
	setupHotkeys()
	spoon.LeftRightHotkey:start()
end

init()

--------------------------------------------------------------------------------
-- Debug
--------------------------------------------------------------------------------

-- Call this from Hammerspoon console when an app isn't switching properly:
--   rcmd.debug("v")  -- for Vivaldi
--   rcmd.debug("z")  -- for zoom.us
--   rcmd.debug()     -- for all apps
local function debugKey(key)
	print("========== RCMD DEBUG ==========")
	print("Time: " .. os.date("%Y-%m-%d %H:%M:%S"))
	print("")

	-- Get fresh state from system
	local freshApps = getDockApps()

	if key then
		print("Debugging key: '" .. key .. "'")
		print("")

		-- Show cached state for this key
		print("-- CACHED STATE --")
		local cachedApps = getAppsForKey(key)
		if #cachedApps == 0 then
			print("  No apps in cache for this key")
		else
			for i, appName in ipairs(cachedApps) do
				local cached = dockAppsCache[appName]
				local pid = cached and cached:pid() or "nil"
				local isRunning = cached and cached:isRunning() or false
				print(string.format("  %d. %s (pid=%s, isRunning=%s)", i, appName, pid, isRunning))
			end
		end
		print("")

		-- Show fresh state for this key
		print("-- FRESH STATE (what system sees now) --")
		local freshForKey = {}
		for appName, app in pairs(freshApps) do
			if getAppKey(appName) == key then
				table.insert(freshForKey, { name = appName, app = app })
			end
		end
		if #freshForKey == 0 then
			print("  No running apps for this key")
		else
			for _, item in ipairs(freshForKey) do
				local inCache = dockAppsCache[item.name] and "yes" or "NO!"
				local cachedPid = dockAppsCache[item.name] and dockAppsCache[item.name]:pid() or "n/a"
				local freshPid = item.app:pid()
				local pidMatch = (cachedPid == freshPid) and "match" or "MISMATCH!"
				print(string.format("  %s: inCache=%s, cachedPid=%s, freshPid=%s (%s)",
					item.name, inCache, cachedPid, freshPid, pidMatch))
			end
		end
	else
		-- Show all apps
		print("-- ALL CACHED APPS --")
		local sortedKeys = {}
		for k in pairs(mruByKey) do
			table.insert(sortedKeys, k)
		end
		table.sort(sortedKeys)

		for _, k in ipairs(sortedKeys) do
			local apps = getAppsForKey(k)
			if #apps > 0 then
				print(string.format("  [%s]: %s", k, table.concat(apps, ", ")))
			end
		end
		print("")

		-- Show apps in fresh state but not in cache
		print("-- MISSING FROM CACHE --")
		local missing = {}
		for appName in pairs(freshApps) do
			if not dockAppsCache[appName] then
				table.insert(missing, appName)
			end
		end
		if #missing == 0 then
			print("  None")
		else
			for _, appName in ipairs(missing) do
				print("  " .. appName)
			end
		end
		print("")

		-- Show stale entries (in cache but not running)
		print("-- STALE IN CACHE --")
		local stale = {}
		for appName, app in pairs(dockAppsCache) do
			if not freshApps[appName] or not app:isRunning() then
				table.insert(stale, appName)
			end
		end
		if #stale == 0 then
			print("  None")
		else
			for _, appName in ipairs(stale) do
				print("  " .. appName)
			end
		end
	end

	print("")
	print("================================")
end

--------------------------------------------------------------------------------
-- Module API
--------------------------------------------------------------------------------

return {
	refresh = refreshDockAppsCache,
	debug = debugKey,
	overrides = OVERRIDES,
}
