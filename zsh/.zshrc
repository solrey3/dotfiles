# ~/.zshrc

#############################################
# Terminal & Environment Settings
#############################################
stty erase '^?'

#############################################
# Aliases
#############################################
alias dtf="cd ~/.dotfiles/ && nvim"
alias hist="history 1"
alias k=kubectl
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -lh'
alias nixc="cd ~/.nix-config/ && nvim"
alias p2="cd ~/Repos/github.com/solrey3/notes/ && nvim todo.md"
alias vi="nvim"
alias vim="nvim"
alias gcm="git commit -m"
alias gco="git checkout"

#############################################
# Shell History Configuration (after oh-my-zsh)
#############################################
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
unsetopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY

# Use up/down arrow keys for history search
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

#############################################
# PATH Setup
#############################################
export PATH="$HOME/bin:/usr/local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/nvim/bin:$PATH"

#############################################
# Command Completion
#############################################
if [ -f /usr/local/share/zsh/site-functions/_bash_completion ]; then
  . /usr/local/share/zsh/site-functions/_bash_completion
elif [ -f /usr/share/zsh/functions/Completion ]; then
  . /usr/share/zsh/functions/Completion
fi

#############################################
# macOS Bash Deprecation Warning
#############################################
export BASH_SILENCE_DEPRECATION_WARNING=1

#############################################
# Starship Prompt Setup
#############################################
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
if command -v starship >/dev/null; then
  eval "$(starship init zsh)"
fi
