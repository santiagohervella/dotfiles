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
- Set up Raycast settings by navigating to `~/.config/raycast/` and double clicking on the latest `.rayconfig` file
- Installation of apps from the Mac App Store will fail if you don't manually sign in beforehand.
- Install [Supercharge](https://sindresorhus.gumroad.com/l/supercharge) by Sindre Sorhus
- Install [Festivitas](https://www.festivitas.app/) by Simon Støvring
- Remap Caps Lock to Control is System Settings. Couldn't find a way to do this programatically. This is mostly so we don't accidentally turn on Caps Lock, but very very occassionally it can be nice to have as Control
- Use Launchpad to go through pre-installed apps and delete ones that are not needed
  - iMovie
  - Pages
- Test screen for dead pixels using [Test My Screen](https://testmyscreen.com/)
- Launch Karabiner and follow all the instructions to let it set up
- Give apps the proper permissions:
  - Accessibility
    - AltTab
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
    - Arc
    - Keyboard Maestro
    - Raycast
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

This repo is set up to use Ansible to manage a macOS machine. This includes system settings, apps and packages with homebrew, and your dev environment using neovim.

I'll try to roughly walk you through the flow.

- The first `xcode-select --install` command does a few things, but most importantly, it installs `git`
- Cloning this repo locally is self-explanatory

#### Running the ./install script

# TODO

- iTerm2 profiles
- Maybe make the kdiff3 config symlinking an ansible task rather than doing it in the `.macos.sh` script
- Keyboard Maestro macros
- Caps Lock -> Control could be done through Karabiner instead of System Settings to remove one manual step
