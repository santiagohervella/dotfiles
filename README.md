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
# Do not run this command inside of tmux as it makes something go wonky
ansible-playbook main.yml --ask-become-pass
```

## Run part of the playbook using tags

```sh
ansible-playbook main.yml --ask-become-pass --tags homebrew
```

## Useful homebrew commands

### Update all homebrew cask apps

```sh
brew upgrade --cask --greedy
```

### Update homebrew cask apps interactively

```
brew cu --all --interactive
```

### Update one specific hombrew cask app

```sh
brew upgrade --cask <cask_name>
```

Without the `greedy` flag, apps that are set to autoupdate will not update via the normal `brew update` command

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
    - rz -> Zoom size
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
    - EasyFind
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

## On the media server (Mac mini)

- Enable Jellyfin in `./config.yml` (not checked in):

  ```yaml
  configure_jellyfin: true
  jellyfin_storage_dir: /Volumes/elisanti-media-drive/jellyfin
  jellyfin_tailscale_funnel: true # Optional: expose it on the internet
  ```

  then run `ansible-playbook main.yml --ask-become-pass --tags jellyfin`
- If using Funnel:
  - Approve the link the playbook prints to enable Funnel on the tailnet
  - Add Tailscale to Login Items in System Settings (its own "Launch at login" setting can't turn itself on)
  - In Jellyfin, set Dashboard → Networking → Known proxies to `127.0.0.1, ::1` so it sees real client IPs instead of treating every Funnel request as local
- Don't open Jellyfin.app. It's only installed for the server binary inside it; the LaunchAgent runs the server with storage on the media drive, while the app's launcher would start a second server using `~/.local/share/jellyfin`, which is stowed from this repo
- Approve the macOS prompt allowing `jellyfin` to access the removable volume, if one appears
- Finish setup at `http://<mac-mini>:8096`. Logs are in `<jellyfin_storage_dir>/log`, plus `~/Library/Logs/jellyfin-launchd.log` (stderr only) if the server fails to start

### *arr stack

Seerr (requests) → Sonarr (TV) / Radarr (movies) → Prowlarr (indexers) → qBittorrent (behind Proton VPN via gluetun) → libraries on the media drive → Jellyfin rescans. Runs with Docker Compose in OrbStack; Jellyfin stays native for hardware transcoding.

There are two Sonarr/Radarr pairs. `sonarr`/`radarr` manage the shared `TV Shows`/`Movies` (1080p, 720p is fine, no upgrades). `sonarr-4k`/`radarr-4k` manage Santi's private `Santi TV Shows`/`Santi Movies` (4K, falling back to 1080p) and are Seerr's "4K" servers, so "Request in 4K" means "add to Santi's library". Keeping them as separate instances is what keeps Santi's titles out of everything the partner's account can see in Seerr (only users with 4K permission see 4K statuses), and lets the same title exist in both libraries

- Get a WireGuard key: account.protonvpn.com → Downloads → WireGuard configuration, platform GNU/Linux, **NAT-PMP (Port Forwarding) on**, any P2P server. Only the `PrivateKey` is used
- Enable it in `./config.yml`:

  ```yaml
  configure_arr: true
  arr_media_dir: /Volumes/elisanti-media-drive
  arr_wireguard_private_key: <PrivateKey from the Proton config>
  arr_vpn_server_countries: United States # Optional: nearby servers are faster
  arr_seerr_tailscale_funnel: true # Optional: Seerr at https://<machine>.<tailnet>.ts.net:8443
  ```

  then run `ansible-playbook main.yml --tags arr`
- First run only, on the Mini's screen: open OrbStack.app and finish onboarding (choose Docker), and approve its prompt to access removable volumes. Until that's approved, any container touching the drive hangs OrbStack's VM
- App config is in Docker volumes inside OrbStack, not in this repo. The one-time wiring done through the apps' APIs/UIs:
  - Sonarr/Radarr (and the `-4k` pair, same settings): root folders `/data/TV Shows` / `/data/Movies` (`-4k`: `/data/Santi TV Shows` / `/data/Santi Movies`); naming matches the existing library (`Show (Year)/Season 01/Show S01E01`, `Movie (Year)/Movie (Year)`); a Jellyfin connection (`host.docker.internal:8096`, API key `arr-stack`) that refreshes the library on import; qBittorrent download client at `gluetun:8080` (categories `tv-sonarr`/`radarr`, `-4k`: `tv-sonarr-4k`/`radarr-4k`); "Unmonitor deleted" on, so media deleted from Jellyfin/Infuse isn't downloaded again; minimum free space 100 GB
  - Prowlarr: Sonarr/Radarr apps (`http://sonarr:8989`, `http://radarr:7878`, `http://sonarr-4k:8989`, `http://radarr-4k:7878`), public indexers, and a FlareSolverr proxy (`http://flaresolverr:8191`) for indexers tagged `flaresolverr` (1337x, EZTV, ...)
  - Recyclarr: `/config/configs/{sonarr,radarr}.yml` (API keys in `/config/secrets.yml`) sync TRaSH-based profiles daily: "1080p (720p fallback)" on `sonarr`/`radarr`, tuned for speed over quality: all 720p/1080p qualities rank equally, release-group/streaming bonuses are zeroed and the LQ/x265/AV1 bans lifted (so the best-seeded copy wins), almost no minimum file size (2 MB/min, preferred 12 MB/min), no upgrades, and "4K (1080p fallback)" preferring Dolby Vision on the `-4k` pair
  - qBittorrent: "Bypass authentication for clients on localhost" on, so gluetun can set the port Proton forwards; categories per app (above), with Automatic Torrent Management on so each category downloads into its own `downloads/<folder>`; seed to ratio 1 or 24h, then stop (Sonarr/Radarr then remove it); upload capped at 2 Mbit/s since home upload is ~34 Mbit/s
  - Seerr: signed in with Jellyfin at `host.docker.internal:8096`, "Enable Proxy Support" on (it's behind Funnel), only the shared Jellyfin libraries enabled. Default servers are `sonarr`/`radarr`, "4K" servers are the `-4k` pair, all with Enable Scan on. Users get Request + Auto-approve but not 4K. Web Push on (Request Available + Failed)
- Admin UIs on the LAN/tailnet: Seerr `:5055`, Sonarr `:8989` (Santi's: `:8990`), Radarr `:7878` (Santi's: `:7879`), Prowlarr `:9696`, qBittorrent `:8080`. Login is `santi` with the password in `~/.arr-stack/admin-password`
- Updating: the containers don't update themselves. Rerun `--tags arr` every month or so: it pulls new images and recreates whatever changed
- Backups: a LaunchAgent runs `~/.arr-stack/backup.sh` nightly, which archives each app's config volume to `<arr_media_dir>/arr-backups/<date>/` (14 days kept). To restore an app: `docker-compose stop <app>`, extract its archive into the `arr_<app>` volume, `docker-compose start <app>`. Log: `~/Library/Logs/arr-backup.log`
- Decluttarr: watches the shared `sonarr`/`radarr` queues (not the `-4k` pair) every 10 minutes and removes + blocklists downloads that are stalled, stuck on metadata, failed or unimportable for ~30 minutes, so the next-best copy is grabbed. Slow downloads are deliberately left alone (for rare films a slow copy may be the only one). Its config (API keys, qBittorrent login) is `/app/config/config.yaml` in its volume, written once by hand; set `test_run: true` there to have it only log
- Health alerts: with the same Pushover keys, a LaunchAgent runs `~/.arr-stack/health-check.py` every 15 minutes and notifies Santi when something has been broken for two checks in a row (drive unmounted or under 200 GB free, Jellyfin down, a container stopped/unhealthy, VPN without a forwarded port, a Sonarr/Radarr health error, a Funnel address off, a missing nightly backup), and again when it recovers. Log: `~/Library/Logs/arr-health.log`
- Stuck request alerts: with `arr_pushover_app_token` and `arr_pushover_user_key` in `config.yml`, a LaunchAgent runs `~/.arr-stack/stuck-requests.py` daily at 10:00 and sends Santi a Pushover notification (once per request) for any Seerr request still searching after `arr_stuck_request_days` (2) with nothing downloading. The requester isn't notified. Log: `~/Library/Logs/arr-stuck-requests.log`
- Indexers: Prowlarr syncs its indexers to all four Sonarr/Radarr. Internet Archive is good for old/public-domain films; it uses a "Search only" sync profile (no RSS), because its RSS query regularly times out at archive.org and the failures get the whole indexer disabled. Indexers behind Cloudflare need the `flaresolverr` tag
- Logs: `docker-compose logs <service>` in `~/.arr-stack` (`docker-compose` is in OrbStack.app/Contents/MacOS/xbin if not on PATH)

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
- Install the [Elgato Thunderbolt Dock Utility](https://update.elgato.com/mac/thunderbolt-dock-update/download.php)
- Create and populate `~/.zsh_env_vars`
  - YARN_NPM_AUTH_TOKEN
  - GEMINI_API_KEY
  - DATADOG_API_KEY, DATADOG_APP_KEY
  - PAGERDUTY_API_TOKEN
  - OPENAI_API_KEY

# In case you completely forget how any of this works

I found [this post](https://phelipetls.github.io/posts/introduction-to-ansible/) a bit too late after I'd already done tons of reading / learning on Ansible, but if you forget everything it would make for a great refresher!

This repo is set up to use Ansible to manage a macOS machine. This includes system settings, apps and packages with homebrew, and your dev environment using neovim.

I'll try to roughly walk you through the flow.

- The first `xcode-select --install` command does a few things, but most importantly, it installs `git`
- Cloning this repo locally is self-explanatory

#### Running the ./install script

TODO: Write this explanation

# Handy commands

## If making changes on a work laptop that you actually want to commit from your personal

On the work machine, run:

```sh
git diff > my-cool-changes.patch
```

And if you have untracked files, stage them `git add .` and then run:

```sh
git diff --staged > my-cool-changes.patch
```

The get that file onto a personal machine and run:

```sh
git apply my-cool-changes.patch
```

# TODOs

## Done but needs to be tested

- Bartender / menu bar spacing

## Required

## Improvements

- Obsidian config
  - Apparently all of this lives in the `.obsidian` directory at the root of your Obsidian vault
- Cargo + bob for managing nvim versions
- Maybe make the kdiff3 config symlinking an ansible task rather than doing it in the `.macos.sh` script
- Caps Lock -> Control could be done through Karabiner instead of System Settings to remove one manual step
- Try kdiff3's 3 way merge and if so, set is as the merge tool in the git config like this:
  `https://github.com/geerlingguy/dotfiles/blob/master/.gitconfig#L21`
- Explore zsh's vi mode
- Try out the [DeskPad utility app](https://github.com/Stengo/DeskPad) for better screen sharing on video calls
  - Here's a good [video demo](https://www.youtube.com/watch?v=O-as2_bud9s) of what it does
- Maybe try out [Folke's desktop wallpaper](https://github.com/folke/dot/blob/master/config/wall.png)?
- Evaluate if you want to keep atuin or use just fzf. [This toot](https://hachyderm.io/@mitchellh/115967643749932536) reminded me of this

### Neovim

#### Ideas

- Breakpoints, DAP
  - Omerxx video, [DEBUG in Neovim. Like a BOSS.](https://www.youtube.com/watch?v=RziPWdTzSV8)
  - This new plugin [nvim-dap-view](https://github.com/igorlfs/nvim-dap-view) could be a great alternative to the very busy nvmi-dap-ui that everyone uses
- New Neovim config has quirks that are not fun. Try to figure those out...
  - The LSP diagnostics don't always refresh upon exiting insert mode. Hard to reproduce so I'll just have to be on the lookout for this
- Maybe set look into Obsidian plugins or general note taking improvements
  - Omerxx's video [The Holy Grail of Neovim Note Taking](https://www.youtube.com/watch?v=5ht8NYkU9wQ)
  - Linkarzu's recent videos on the subject
    - [How I Recreated (and Improved) My Obsidian Note-Taking Workflow in Neovim](https://www.youtube.com/watch?v=k_g8q5JeisY)
    - [My complete Neovim markdown setup and workflow in 2025](https://www.youtube.com/watch?v=1YEbKDlxfss)
  - [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) to preview markdown in the browser and have the position of the page synced to the editor
- Maybe check out [lsp-timeout.nvim](https://github.com/hinell/lsp-timeout.nvim/tree/main) to kill LSP servers after a certain amount of time
  - I don't really think I need this one, but before deciding on that, I should do a bit of research while I'm working to see if there are tons of leftover language servers all the time

#### To read or watch

- Check out some of the talks linked in [the readme](https://github.com/preservim/vim-pencil) of the vim-pencil plugin
- Read the entirety of [this famous vim stackoverflow response](https://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim/1220118#1220118)

### Terminal Emulators

- Do try to recreate your iTerm2 config in WezTerm. I really like that it's in lua
  - Here's [Folke's WezTerm config](https://github.com/folke/dot/blob/master/config/wezterm/wezterm.lua) as a reference

### Hammerspoon

- Maybe set up Omerxx's [GoMaCal Hammerspoon thing](https://github.com/omerxx/GoMaCal) to get calendar messages in your face?
  - Here is how he uses it in his [`init.lua`](https://github.com/omerxx/dotfiles/blob/master/hammerspoon/init.lua#L21)
- It might be simpler to make the right option key the hyper key using karabiner. It could still act as option when combined with any other modifier key or with the arrow keys. But otherwise, boom now everything is hyper-letter to switch, rather than needing to carefully keep track of the right option key's state in hammerspoon
