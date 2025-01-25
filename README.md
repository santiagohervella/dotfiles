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

# Run playbook

```sh
# Bootstrap macOS
ansible-playbook main.yml
```

# Remaining manual steps
