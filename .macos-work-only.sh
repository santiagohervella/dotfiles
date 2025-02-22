#!/usr/bin/env bash

# This was initially sourced from: https://github.com/geerlingguy/dotfiles/blob/master/.osx

# This configuration sets up preferences and configurations that are only
# relevant on a work machine. All changes that are relevant to all Macs
# belong in .osx

# Warn that some commands will not be run if the script is not run as root.
if [[ $EUID -ne 0 ]]; then
  RUN_AS_ROOT=false
  printf "Certain commands will not be run without sudo privileges. To run as root, run the same command prepended with 'sudo', for example: $ sudo $0\n\n" | fold -s -w 80
else
  RUN_AS_ROOT=true
  # Update existing `sudo` timestamp until `.osx` has finished
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi


###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set background to dark-grey color
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/System/Library/Desktop Pictures/Solid Colors/Black.png"'

# Found this here:
# https://github.com/philiprein/macos-settings/blob/main/system_settings/lock_screen.sh#L30-L35
# show large clock (default: on lock screen)
# on screen saver and lock screen = true, true
# on lock screen = true, false
# never = false, false
sudo defaults write /Library/Preferences/com.apple.loginwindow UsesLargeDateTime -bool false
defaults -currentHost write com.apple.screensaver showClock -bool false

###############################################################################
# Bartender
###############################################################################

# Get the directory where the script is located
directory_of_macos_work_script="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Path to the ProfileSettings.plist file
bartender_arrangement_path="$directory_of_macos_work_script/files/bartender/work-menu-bar-arrangement.plist"
bartender_plist="$HOME/Library/Preferences/com.surteesstudios.Bartender.plist"

# Skip if bartender has never been opened
if [ -f "$bartender_plist" ]; then
    /usr/libexec/PlistBuddy -c "Delete :ProfileSettings" "$bartender_plist"
    # Merge only works with an existing key...
    /usr/libexec/PlistBuddy -c "Add :ProfileSettings dict" "$bartender_plist"
    /usr/libexec/PlistBuddy -c "Merge ${bartender_arrangement_path} :ProfileSettings" "$bartender_plist"
fi

# Found this nice shorthand loop here:
# https://github.com/megalithic/dotfiles/blob/106a574767ec5dab29ac86e754396df5726d1085/macos#L598C1-L616C5
# This way I don't have to duplicate the applescript line for each app
apps_to_startup=(
  "DisplayLink Manager"
)
for app in "${apps_to_startup[@]}"; do
  log "setting to \"${app}\" to launch at startup."

  # Enable apps at startup
  osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/${app}.app", hidden:true}' >/dev/null && log_ok "DONE"
done

###############################################################################
# Login Items
###############################################################################

# Found this nice shorthand loop here:
# https://github.com/megalithic/dotfiles/blob/106a574767ec5dab29ac86e754396df5726d1085/macos#L598C1-L616C5
# This way I don't have to duplicate the applescript line for each app
apps_to_startup=(
  "DisplayLink Manager"
)
for app in "${apps_to_startup[@]}"; do
  log "setting to \"${app}\" to launch at startup."

  # Enable apps at startup
  osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/${app}.app", hidden:true}' >/dev/null && log_ok "DONE"
done

###############################################################################
# Kill/restart affected applications                                          #
###############################################################################

# Restart affected applications if `--no-restart` flag is not present.
if [[ ! ($* == *--no-restart*) ]]; then
  for app in "Finder"; do
    killall "${app}" > /dev/null 2>&1
  done
fi
