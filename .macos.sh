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

# Set the default app for .mp3 files to QuickTime Player instead of Music
duti -s com.apple.QuickTimePlayerX mp3 all

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

# Set the Globe key to do nothing
defaults write com.apple.HIToolbox AppleFnUsageType -int 0

# Keyboard -> Keyboard shortcuts

# Disable both "Spotlight" keyboard shortcuts
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 65 "<dict><key>enabled</key><false/></dict>"

# Disable both "Launchpad & Dock" shortcuts
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 160 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 52 "<dict><key>enabled</key><false/></dict>"

# Disable all "Mission Control" shortcuts except "Application Windows"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 118 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 163 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 175 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 190 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 222 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 32 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 36 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 79 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 81 "<dict><key>enabled</key><false/></dict>"

# "Input Sources" shortcuts
# Disable "Select the previous input source"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 60 "<dict><key>enabled</key><false/></dict>"
# Set "Select next source in Input menu" to ctrl+option+shift+command+space
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 61 "
  <dict>
    <key>enabled</key><true/>
    <key>value</key><dict>
      <key>type</key><string>standard</string>
      <key>parameters</key>
      <array>
        <integer>32</integer>
        <integer>49</integer>
        <integer>1966080</integer>
      </array>
    </dict>
  </dict>
"

# "App Shortcuts" shortcuts
# Disable "Show Help menu" under "All Applications"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 98 "<dict><key>enabled</key><false/></dict>"

# For reference:
# @: Command
# $: Shift
# ~: Alt
# ^: Ctrl
# Launch System Settings using the global Apple menu with ctrl+option+command+s
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "System Settings..." -string "@~^s"
 
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
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
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

# Hide the dock
defaults write com.apple.dock autohide -bool true

# Set the icon size of dock items
defaults write com.apple.dock tilesize -int 65

# Set delay to show the dock to 0
defaults write com.apple.dock autohide-delay -float 0

# Set the timer to hide the dock once you move away to 0
defaults write com.apple.dock autohide-time-modifier -float 0

# Enable the 'reduce transparency' option. Save GPU cycles.
# This is in System Settings -> Accessibility -> Display -> Reduce transparency
defaults write com.apple.universalaccess reduceTransparency -bool true

# Turn off "Show suggested and recent apps in Dock"
defaults write com.apple.dock showhidden -bool true

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

# Found these preferences here:
# https://github.com/sbusso/nixconfig/blob/main/home/programs/hammerspoon/default.nix
defaults write org.hammerspoon.Hammerspoon HSAutoLoadExtensions -bool true
defaults write org.hammerspoon.Hammerspoon HSConsoleDarkModeKey -bool true
defaults write org.hammerspoon.Hammerspoon HSPreferencesDarkModeKey -bool true
defaults write org.hammerspoon.Hammerspoon MJShowDockIconKey -bool false
defaults write org.hammerspoon.Hammerspoon MJShowMenuIconKey -bool true
defaults write org.hammerspoon.Hammerspoon SUAutomaticallyUpdate -bool true
defaults write org.hammerspoon.Hammerspoon SUEnableAutomaticChecks -bool true
defaults write org.hammerspoon.Hammerspoon SUEnableAutomaticChecks -bool true

###############################################################################
# iTerm2
###############################################################################

# Don’t display the are you sure prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Set iTerm2 preferences
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.config/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

###############################################################################
# OmniFocuse 4
###############################################################################

# Setup shortcut to Search Everything using the menu bar command to shift+command+e
defaults write com.omnigroup.OmniFocus4 NSUserKeyEquivalents -dict-add "Search Everything" -string "@$e"

###############################################################################
# kdiff3
###############################################################################

# Symlink kdiff3 config
if [ -f "$HOME/Library/Preferences/kdiff3rc" ]; then
  rm "$HOME/Library/Preferences/kdiff3rc"
fi
# For reference, this is how I found out the correct path:
# https://github.com/dracula/kdiff3/issues/4#issuecomment-1501010105
ln -s $HOME/.config/kdiff3/kdiff3rc $HOME/Library/Preferences/kdiff3rc

###############################################################################
# Login Items
###############################################################################

# Hammerspoon
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Hammerspoon.app", hidden:true}' > /dev/null
# Keyboard Maestro Engine
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Keyboard Maestro.app/Contents/MacOS/Keyboard Maestro Engine.app", hidden:true}' > /dev/null
# Raycast
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Raycast.app", hidden:true}' > /dev/null
# Supercharge
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Supercharge.app", hidden:true}' > /dev/null
# Menu Bar Calendar
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Menu Bar Calendar.app", hidden:true}' > /dev/null




###############################################################################
# Kill/restart affected applications                                          #
###############################################################################

# Restart affected applications if `--no-restart` flag is not present.
if [[ ! ($* == *--no-restart*) ]]; then
  for app in "cfprefsd" "Dock" "Finder" "SystemUIServer" "Terminal" "Activity Monitor" "TextEdit" "iTerm2" "Hammerspoon"; do
    killall "${app}" > /dev/null 2>&1
  done
fi

printf "Please log out and log back in to make all settings take effect.\n"
