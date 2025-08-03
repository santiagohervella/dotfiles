export EDITOR=nvim
export VISUAL="$EDITOR"

bindkey -s ^f "~/.config/tmux/tmux-sessionizer\n"

# Until I find out why these broke, hardcoding them back in
bindkey '^R' history-incremental-search-backward
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

if [ -f "$HOME/.zsh_env_vars" ]; then
  source $HOME/.zsh_env_vars
fi

# Source all custom zsh functions
# I prefer this to putting them in /bin
for file in "$HOME/.config/zsh/source/*"; do source "$file"; done

# This is so programs don't look for config files in application support
export XDG_CONFIG_HOME="$HOME/.config"

# Everything we want to use globally through Python needs to be in the PATH
# ansible and friends primarily
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
# homebrew installed tools should be in the PATH
export PATH="/opt/homebrew/bin:$PATH"

alias n="nvim"
alias "n."="nvim ."
alias "cd../"="cd ../"
alias lg="lazygit"
alias c="clear"
alias cat='bat'
alias prc='gh pr create -w'
alias prv='gh pr view -w'

# I don't want to use oh-my-zsh, but I used these aliases from the git plugin
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/README.md
alias gst="git status"
alias gco="git checkout"
alias gl="git pull"
alias gcm="git checkout main"

# Used to undo a commit that has not yet been pushed. It takes the files in the commit and puts them back into local staged files.
# Can't remember what happens to existing local changes when you do this, so maybe just stash them or do a non-committal test?
alias gitundo='git reset HEAD~1'

# Aliases for custom scripts
alias ggit="$HOME/.config/zsh/alias/new-git-branch"

eval "$(starship init zsh)"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"


# nodenv as the node version manager
# https://github.com/nodenv/nodenv
eval "$(nodenv init -)"

# pyenv as the python version manager
# https://github.com/pyenv/pyenv?tab=readme-ov-file#zsh
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
