# dotfiles

# Install git

`xcode-select --install`

# Clone the repository

```sh
mkdir ~/Documents/projects
cd ~/Documents/projects
# TODO: git clone git@github.com:santiagohervella/dotfiles.git
git clone https://github.com/santiagohervella/dotfiles.git
cd dotfiles
```

# Install ansible

```sh
./install
```

## Add ansible and homebrew to PATH

Ansible and it's goodies get installed inside Python's bin directory. PATH will get set up with `.zshrc` once we run the playbook. We just need to add Python's bin to the PATH for our current session so that we can call `ansible`.

Same deal with homebrew.

```sh
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
```

# Configure playbook

Change the `machine_type` variable in `./default.config.yml` to be 'personal' or 'work'

# Run playbook

```sh
# Set up macOS
ansible-playbook main.yml --ask-become-pass
```

# Remaining manual steps

## On all Macs

- Set screen resolution. This could probably be done with a script, but since each machine is different, let's keep it manual
- Set up TouchID if on a MacBook
- Sign into 1Password
- Sign into iCloud
- Raycast
  - Set up Raycast settings by navigating to `~/.config/raycast/` and double clicking on the latest `.rayconfig` file
  - Go to Script Commands under Extensions in preferences and manually set the aliases for any scripts
    - rr -> Rather reasonable size
    - ps -> Presentation size
- Manually sign into the Mac App Store
  - Programatic installation of apps from the Mac App Store will fail if you don't manually sign in beforehand.
  - Only previously purchased apps can be installed
- Install [Supercharge](https://sindresorhus.gumroad.com/l/supercharge) by Sindre Sorhus
- Install [Festivitas](https://www.festivitas.app/) by Simon Støvring
- Remap Caps Lock to Control is System Settings. Couldn't find a way to do this programatically. This is mostly so we don't accidentally turn on Caps Lock, but very very occassionally it can be nice to have as Control
- Use Launchpad to go through pre-installed apps and delete ones that are not needed
  - iMovie
  - Pages
- Test screen for dead pixels using [Test My Screen](https://testmyscreen.com/)
- Launch Karabiner and follow all the instructions to let it set up
- Keyboard Maestro
  - Delete all default macros from Keyboard Maestro
  - Navigate to `~/.config/keyboard-maestro` and double click on the appropriate macro library. In the popup window, click "Insert" to import the macros
  - Fill in all the sensitive information in each macro that has "FILL ME IN" anywhere
  - Add the license (stored in 1Password)
- Bartender
  - Add the license (stored in 1Password)
  - In general settings, check the box to start Bartender at login
- Choose, install, and use a global version of `node` using `nodenv`
  - To list all remote versions you can install, use `nodenv install --list-all`
- Arc Browser
  - Copy over the Application Support directory from previous relevant Mac
  - Log in to relevant Arc account
  - Log into all accounts (Google, etc)
  - Reinstall Chrome extensions
    - No need to adjust any extension settings, those are all brought over by the Application Support directory
- Set up the GitHub CLI by running `gh auth login`
  - Select HTTPS for the preferred protocol and authenticate with an authentication token
- Clone all relevant repos
- Give apps the proper permissions:
  - Accessibility
    - AltTab
    - Bartender 5
    - Festivitas
    - Hammerspoon
    - Keyboard Maestro
    - Keyboard Maestro Engine
    - Raycast
    - Supercharge
    - zoom.us
  - Full Disk Access
    - Alacritty
    - Ghostty
    - Kitty
    - Terminal
    - WezTerm
    - Zed
    - iTerm2
    - karabiner_grabber
  - Input Monitoring
    - Karabiner-EventViewer
    - karabiner_grabber
  - Camera
    - Arc
    - Persona Webcam
    - zoom.us
  - Screen & System Audio Recording
    - AltTab
    - Bartender 5
    - Arc
    - Keyboard Maestro
    - Raycast
    - Slack
    - zoom.us
- Adjust notifications
  - Turn off for Tips app

## On personal Macs

- Finder
  - Customize the sidebar to be in this order
    - AirDrop
    - Applications
    - Desktop
    - Documents
    - Audiobooks (Primary only)
    - Downloads
    - Home
    - Shortcuts (Primary only)
    - Logic (Primary only)
    - Volumes
    - iCloud Drive

### If primary Mac

- Install Calibre with `brew install --cask calibre`
- Install [Forecast](https://overcast.fm/forecast)
- Install [inAudible](https://github.com/rmcrackan/inAudible/tree/master/_installers)
- Install [Audio Hijack] with `brew install --cask audio-hijack`
- Install Logic Pro
- Install DaisyDisk with `brew install --cask daisydisk`
- Install [Reeder Classic](https://apps.apple.com/us/app/reeder-classic/id1529448980) from the Mac App Store
- Add Hyperduck to login items with `osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Hyperduck.app", hidden:true}' > /dev/null`

## On work Macs

- Finder
  - Customize the sidebar to be in this order
    - AirDrop
    - Applications
    - Desktop
    - Documents
    - Downloads
    - Home
    - Volumes
    - iCloud Drive
- Set up iMessage with work Apple Account
- PyCharm
  - Log into work Jetbrains account to get the license
  - Install IdeaVim plugin

# In case you completely forget how any of this works

I found [this post](https://phelipetls.github.io/posts/introduction-to-ansible/) a bit too late after I'd already done tons of reading / learning on Ansible, but if you forget everything it would make for a great refresher!

This repo is set up to use Ansible to manage a macOS machine. This includes system settings, apps and packages with homebrew, and your dev environment using neovim.

I'll try to roughly walk you through the flow.

- The first `xcode-select --install` command does a few things, but most importantly, it installs `git`
- Cloning this repo locally is self-explanatory

#### Running the ./install script

TODO: Write this explanation

# TODOs

## Done but needs to be tested

- Bartender / menu bar spacing
  - Still needs work arrangement plist file brought into the repo

## Required

## Improvements

- Superchange keyboard shortcuts
- Cargo + bob for managing nvim versions
- Maybe make the kdiff3 config symlinking an ansible task rather than doing it in the `.macos.sh` script
- Caps Lock -> Control could be done through Karabiner instead of System Settings to remove one manual step
- Try kdiff3's 3 way merge and if so, set is as the merge tool in the git config like this:
  `https://github.com/geerlingguy/dotfiles/blob/master/.gitconfig#L21`
- Avante for nvim? Check out these links:
  - [AI in Neovim (NeovimConf 2024)](https://www.joshmedeski.com/posts/ai-in-neovim-neovimconf-2024/)
  - [Get the Cursor AI experience in Neovim with avante nvim](https://www.youtube.com/watch?v=4kzSV2xctjc)
  - [avante.nvim](https://github.com/yetone/avante.nvim)
- New Neovim config has a bunch of quirks that are not fun. Try to figure those out...
  - I don't love how the folkse todo plugin highlights things. I keep hitting my keymap to disable highlighting, but I otherwise like the plugin
- Explore zsh's vi mode
