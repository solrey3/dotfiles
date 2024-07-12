# ~/.bashrc

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/budchris/google-cloud-sdk/path.bash.inc' ]; then . '/Users/budchris/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/budchris/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/budchris/google-cloud-sdk/completion.bash.inc'; fi

# Aliases
alias hist="history 1"
alias p2="cd ~/Nextcloud/obsidian/player2; nvim"

# Completion for terraform
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Add $HOME/bin to PATH
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="$HOME/anaconda3/bin:$PATH"

# Set the terminal to handle backspace correctly
stty erase '^?'

# Environment Variables
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Enable bash completion if available
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
elif [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

# Append history list and avoid duplicate entries
shopt -s histappend
export HISTCONTROL=ignoredups:erasedups # no duplicate entries

# Use up/down arrow keys to search history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Remove that annoying message from mac about using bash
export BASH_SILENCE_DEPRECATION_WARNING=1

# Set STARSHIP_CONFIG environment variable
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init bash)"

# Use `xclip` for system clipboard integration
# bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -selection clipboard -in"

# export PATH="/Users/budchris/miniconda/bin:$PATH"  # commented out by conda initialize
