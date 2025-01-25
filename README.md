# dotfiles

# Install git

`xcode-select --install`

# Clone the repository

```sh
mkdir ~/Documents/projects
cd ~/Documents/projects
git clone git@github.com:santiagohervella/dotfiles.git
cd dotfiles
```

# Install Ansible

```sh
./install
```

# Configure playbook

Change the `machine_type` variable in `./default.config.yml` to be 'personal' or 'work'

# Run playbook

```sh
# Bootstrap macOS
ansible-playbook main.yml
```

# Remaining manual steps

## On all Macs

- Sign into iCloud
- Installation of apps from the Mac App Store will fail if you don't manually sign in beforehand.
- Install [Supercharge](https://sindresorhus.gumroad.com/l/supercharge) by Sindre Sorhus
- Install [Festivitas](https://www.festivitas.app/) by Simon Støvring
- Use Launchpad to go through pre-installed apps and delete ones that are not needed
  - iMovie
- Test screen for dead pixels using [Test My Screen](https://testmyscreen.com/)

## On personal Macs

### If primary Mac

- Install Calibre with `brew install --cask calibre`
- Install [Forecast](https://overcast.fm/forecast)
- Install [inAudible](https://github.com/rmcrackan/inAudible/tree/master/_installers)
- Install [Audio Hijack] with `brew install --cask audio-hijack`
- Install Logic Pro
- Install DaisyDisk with `brew install --cask daisydisk`
- Install [Reeder Classic](https://apps.apple.com/us/app/reeder-classic/id1529448980) from the Mac App Store

## On work Macs

- TODO

# In case you completely forget how any of this works

This repo is set up to use Ansible to manage a macOS machine. This includes system settings, apps and packages with homebrew, and your dev environment using neovim.

I'll try to roughly walk you through the flow.

- The first `xcode-select --install` command does a few things, but most importantly, it installs `git`
- Cloning this repo locally is self-explanatory

#### Running the ./install script
