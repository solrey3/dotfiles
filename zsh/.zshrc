# ~/.zshrc

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/budchris/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/budchris/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/budchris/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/budchris/google-cloud-sdk/completion.zsh.inc'; fi

# Aliases
alias hist="history 1"
alias 2b="cd ~/Nextcloud/obsidian; nvim"

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

# Add $HOME/bin to PATH
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Set the terminal to handle backspace correctly
stty erase '^?'

# Environment Variables
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Enable zsh completion if available
if [ -f /usr/local/share/zsh/site-functions/_bash_completion ]; then
  . /usr/local/share/zsh/site-functions/_bash_completion
elif [ -f /usr/share/zsh/functions/Completion ]; then
  . /usr/share/zsh/functions/Completion
fi

# Append history list and avoid duplicate entries
setopt APPEND_HISTORY
HISTCONTROL=ignoredups:erasedups # no duplicate entries

# Use up/down arrow keys to search history
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Remove that annoying message from mac about using bash
export BASH_SILENCE_DEPRECATION_WARNING=1

# Set STARSHIP_CONFIG environment variable
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"
export PATH="/usr/local/nvim/bin:$PATH"

export TERM=xterm-256color
