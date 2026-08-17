# Dotfiles Repository

## Philosophy

Everything needed to set up a Mac lives in this repo. Running `ansible-playbook main.yml --ask-become-pass` should fully configure a new machine.

Any system customization must be compatible with this approach - if it can't be automated or stowed, it doesn't belong here.

## Structure

- **Ansible**: `main.yml` orchestrates everything, `default.config.yml` has variables, `tasks/` has task files
- **Stow**: Dotfiles in repo root get symlinked to `$HOME` (e.g., `.zshrc`, `.config/*`)
- **macOS settings**: `.macos.sh` scripts configure system preferences

## Commands

- Full setup: `ansible-playbook main.yml --ask-become-pass`
- Single tag: `ansible-playbook main.yml --ask-become-pass --tags <tag>`
- Available tags: `homebrew`, `mas`, `dotfiles`, `osx`, `extra-packages`, `post`

## Key files

- `default.config.yml` - homebrew packages, mas apps, feature flags
- `.stow-local-ignore` - files excluded from stowing
- `README.md` - manual post-setup steps that can't be automated
