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
- Sign into iCloud
- Raycast
  - Set up Raycast settings by navigating to `~/.config/raycast/` and double clicking on the latest `.rayconfig` file
  - Go to Script Commands under Extensions in preferences and manually set the aliases for any scripts
    - rr -> Rather reasonable size
    - ps -> Presentation size
- Installation of apps from the Mac App Store will fail if you don't manually sign in beforehand.
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
      - Right to left (not all apply to all machines. If not, just skip):
        - System clock should be the analog clock. Find the defaults command for this
        - Use Mini Calendar to show "Jan 26 5:15:05 PM"
        - Use Menu Bar Calendar as the icon to click to browse the calendar
        - System battery with percentage
        - Wifi
        - Sound
        - Bartender `···`
        - iStat Menus network activity
        - iStat Menus CPU graph
        - iStat Menus GPU graph
        - Backblaze
        - Mullvad
      - Anything not mentioned here lives in Bartender
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

## On personal Macs

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

- TODO

# In case you completely forget how any of this works

I found [this post](https://phelipetls.github.io/posts/introduction-to-ansible/) a bit too late after I'd already done tons of reading / learning on Ansible, but if you forget everything it would make for a great refresher!

This repo is set up to use Ansible to manage a macOS machine. This includes system settings, apps and packages with homebrew, and your dev environment using neovim.

I'll try to roughly walk you through the flow.

- The first `xcode-select --install` command does a few things, but most importantly, it installs `git`
- Cloning this repo locally is self-explanatory

#### Running the ./install script

TODO: Write this explanation

# TODOs

## Required

- Figure out bartender / menu bar spacing situation
- Browser setup

## Improvements

- Terimnal prompt
- Cargo + bob for managing nvim versions
- Finder sidebar config
- Maybe make the kdiff3 config symlinking an ansible task rather than doing it in the `.macos.sh` script
- Caps Lock -> Control could be done through Karabiner instead of System Settings to remove one manual step
- Try kdiff3's 3 way merge and if so, set is as the merge tool in the git config like this:
  `https://github.com/geerlingguy/dotfiles/blob/master/.gitconfig#L21`
- Avante for nvim? Check out these links:
  - [AI in Neovim (NeovimConf 2024)](https://www.joshmedeski.com/posts/ai-in-neovim-neovimconf-2024/)
  - [Get the Cursor AI experience in Neovim with avante nvim](https://www.youtube.com/watch?v=4kzSV2xctjc)
  - [avante.nvim](https://github.com/yetone/avante.nvim)
- New Neovim config has a bunch of quirks that are not fun. Try to figure those out...
- Explore zsh's vi mode
