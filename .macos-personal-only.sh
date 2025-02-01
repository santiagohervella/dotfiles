#!/usr/bin/env bash

# This was initially sourced from: https://github.com/geerlingguy/dotfiles/blob/master/.osx

# This configuration sets up preferences and configurations that are only
# relevant on a personal machine. All changes that are relevant to all Macs
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
# Transmission.app                                                            #
###############################################################################

# Set download location
defaults write org.m0k.transmission DownloadFolder -string "${HOME}/Documents/torrents"
defaults write org.m0k.transmission DownloadLocationConstant -bool true

# Prompt for confirmation before downloading
defaults write org.m0k.transmission DownloadAsk -bool true
defaults write org.m0k.transmission MagnetOpenAsk -bool true

# Don’t prompt for confirmation before removing non-downloading active transfers
defaults write org.m0k.transmission CheckRemoveDownloading -bool true

# Trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -bool false

# Hide the donate message
defaults write org.m0k.transmission WarningDonate -bool false
# Hide the legal disclaimer
defaults write org.m0k.transmission WarningLegal -bool false

# IP block list.
# Source: https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission/
defaults write org.m0k.transmission BlocklistNew -bool true
defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true

# Randomize port on launch
defaults write org.m0k.transmission RandomPort -bool true

# Be bad community member. Don't upload or seed anything
# I should change this on my media server once torrenting traffic is tunneled
defaults write org.m0k.transmission RatioLimit -int 0
defaults write org.m0k.transmission UploadLimit -int 0

###############################################################################
# Bartender
###############################################################################


# Get the directory where the script is located
directory_of_macos_personal_script="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Path to the ProfileSettings.plist file
bartender_arrangement_path="$directory_of_macos_personal_script/files/bartender/work-menu-bar-arrangement.plist"
bartender_plist="$HOME/Library/Preferences/com.surteesstudios.Bartender.plist"

# Skip if bartender has never been opened
if [ -f "$bartender_plist" ]; then
    /usr/libexec/PlistBuddy -c "Delete :ProfileSettings" "$bartender_plist"
    # Merge only works with an existing key...
    /usr/libexec/PlistBuddy -c "Add :ProfileSettings dict" "$bartender_plist"
    /usr/libexec/PlistBuddy -c "Merge ${bartender_arrangement_path} :ProfileSettings" "$bartender_plist"
fi

###############################################################################
# Kill/restart affected applications                                          #
###############################################################################

# Restart affected applications if `--no-restart` flag is not present.
if [[ ! ($* == *--no-restart*) ]]; then
  for app in "Transmission"; do
    killall "${app}" > /dev/null 2>&1
  done
fi
