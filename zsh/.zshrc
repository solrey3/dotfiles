# ~/.zshrc

export TERM=xterm-256color

# Set the terminal to handle backspace correctly
stty erase '^?'

# Aliases
alias hist="history 1"
alias vi="nvim"
alias vim="nvim"
alias p2="cd ~/Nextcloud/obsidian/player2; nvim todo.md"
alias dtf="cd ~/dotfiles; nvim"
# some more ls aliases
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'
alias nano="nvim"

# Add $HOME/bin to PATH
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"
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

# # Append history list and avoid duplicate entries
# setopt APPEND_HISTORY
# HISTCONTROL=ignoredups:erasedups # no duplicate entries

# Use up/down arrow keys to search history
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Enable zsh completion if available
if [ -f /usr/local/share/zsh/site-functions/_bash_completion ]; then
  . /usr/local/share/zsh/site-functions/_bash_completion
elif [ -f /usr/share/zsh/functions/Completion ]; then
  . /usr/share/zsh/functions/Completion
fi

# Environment Variables for gcloud
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/budchris/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/budchris/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/budchris/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/budchris/google-cloud-sdk/completion.zsh.inc'; fi

# Completion for terraform
autoload -U compinit
compinit
compdef _terraform terraform=/opt/homebrew/bin/terraform

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/budchris/miniconda/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/Users/budchris/miniconda/etc/profile.d/conda.sh" ]; then
    . "/Users/budchris/miniconda/etc/profile.d/conda.sh"
  else
    export PATH="/Users/budchris/miniconda/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Remove that annoying message from mac about using bash
export BASH_SILENCE_DEPRECATION_WARNING=1

# Set STARSHIP_CONFIG environment variable
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"
export PATH="/usr/local/nvim/bin:$PATH"

