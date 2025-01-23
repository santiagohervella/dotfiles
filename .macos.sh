#!/usr/bin/env bash

# This was initially sourced from:
# https://github.com/geerlingguy/dotfiles/blob/master/.osx

# A bunch of changes were also made based on:
# https://github.com/mathiasbynens/dotfiles/blob/main/.macos

# And:
# https://github.com/herrbischoff/awesome-macos-command-line

# This configuration sets up preferences and configurations for all the built-in services and
# apps.
#
# Options:
#   --no-restart: Don't restart any apps or services after running the script.
#
# If you want to figure out what default needs changing, do the following:
#
#   1. `cd /tmp`
#   2. Store current defaults in file: `defaults read > before`
#   3. Make a change to your system.
#   4. Store new defaults in file: `defaults read > after`
#   5. Diff the files: `diff before after`

# Warn that some commands will not be run if the script is not run as root.
if [[ $EUID -ne 0 ]]; then
  RUN_AS_ROOT=false
  printf "Certain commands will not be run without sudo privileges. To run as root, run the same command prepended with 'sudo', for example: $ sudo $0\n\n" | fold -s -w 80
else
  RUN_AS_ROOT=true
  # Update existing `sudo` timestamp until `.osx` has finished
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Show scroll bars only when scrolling
defaults write NSGlobalDomain AppleShowScrollBars -string WhenScrolling

# Disable "Allow wallpaper tinting in windows"
defaults write NSGlobalDomain AppleReduceDesktopTinting -int 1

# Turn off "Click wallpaper to reveal desktop"
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -int 0

# Show battery in menu bar. 
# Sadly, showing the percentage doesn't seem like a default 
# and must be set manually
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: Haptic feedback (light, silent clicking)
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1

# Trackpad tracking speed 
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 3

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate, and make it happen more quickly.
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write NSGlobalDomain KeyRepeat -int 1

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# https://github.com/mathiasbynens/dotfiles/blob/main/.macos#L127C1-L130C65
# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

###############################################################################
# Screen                                                                      #
###############################################################################

# Save screenshots to Downloads folder.
defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
# defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
# defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# Set Downloads as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show hidden files by default
# defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
# defaults write com.apple.finder ShowStatusBar -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
# defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use column view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `Nlsv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Show the ~/Library folder
chflags nohidden ~/Library

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Set the icon size of Dock items
defaults write com.apple.dock tilesize -int 65

# Set delay to show the dock to 0
defaults write com.apple.dock autohide-delay -float 0

# Set the timer to hide the dock once you move away to 0
defaults write com.apple.dock autohide-time-modifier -float 0

# Enable the 'reduce transparency' option. Save GPU cycles.
# This is in System Settings -> Accessibility -> Display -> Reduce transparency
defaults write com.apple.universalaccess reduceTransparency -bool true

# Turn off "Show suggested and recent apps in Dock"
defaults write com.apple.dock autohide-time-modifier -bool false

# Use dockutil to remove everything from the dock
dockutil --remove all

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
# 14: Quick Note
# Bottom right screen corner → Quick Note
defaults write com.apple.dock wvous-br-corner -int 14
defaults write com.apple.dock wvous-br-modifier -int 0

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# Spotlight                                                                   #
###############################################################################

if [[ "$RUN_AS_ROOT" = true ]]; then
  # Disable Spotlight indexing for any volume that gets mounted and has not yet
  # been indexed before.
  # Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
  sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

  # Restart spotlight
  killall mds > /dev/null 2>&1
fi

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

###############################################################################
# Messages                                                                    #
###############################################################################

# Disable smart quotes as it’s annoying for messages that contain code
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Disable continuous spell checking
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

###############################################################################
# App Store                                                                   #
###############################################################################

# Disable in-app rating requests from apps downloaded from the App Store.
defaults write com.apple.appstore InAppReviewEnabled -int 0

###############################################################################
# TextEdit
###############################################################################

# Use plain text mode as default
defaults write com.apple.TextEdit RichText -int 0

###############################################################################
# Hammerspoon
###############################################################################

# By default, hammerspoon's config is in ~/.hammerspoon/init.lua
# Change it to be in ~/.config/
defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

###############################################################################
# Kill/restart affected applications                                          #
###############################################################################

# Restart affected applications if `--no-restart` flag is not present.
if [[ ! ($* == *--no-restart*) ]]; then
  for app in "cfprefsd" "Dock" "Finder" "SystemUIServer" "Terminal" "Activity Monitor" "TextEdit"; do
    killall "${app}" > /dev/null 2>&1
  done
fi

printf "Please log out and log back in to make all settings take effect.\n"
