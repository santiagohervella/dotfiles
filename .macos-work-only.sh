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

###############################################################################
# Kill/restart affected applications                                          #
###############################################################################

# Restart affected applications if `--no-restart` flag is not present.
if [[ ! ($* == *--no-restart*) ]]; then
  for app in "Finder"; do
    killall "${app}" > /dev/null 2>&1
  done
fi
