#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Rather reasonable Size
# @raycast.mode silent

# Optional parameters:

# Documentation:
# @raycast.description Resize the window to a rather reasonable size

-- ignoring application responses
tell application "Keyboard Maestro Engine"
	do script "E4A468D4-40A3-44F5-B7B3-8D88A53BC19B"
	-- or: do script "Resize window to reasonable size"
	-- or: do script "E4A468D4-40A3-44F5-B7B3-8D88A53BC19B" with parameter "Whatever"
end tell
-- end ignoring

