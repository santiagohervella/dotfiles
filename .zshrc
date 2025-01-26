# TODO: Bring in anything from Coast .zshrc and take another look at the one on your personal machine at ~/.zshrc

# tmux
bindkey -s ^f "~/.config/tmux/tmux-sessionizer\n"

export EDITOR=nvim
export VISUAL="$EDITOR"

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

# Used to undo a commit that has not yet been pushed. It takes the files in the commit and puts them back into local staged files.
# Can't remember what happens to existing local changes when you do this, so maybe just stash them or do a non-committal test?
alias gitundo='git reset HEAD~1'
