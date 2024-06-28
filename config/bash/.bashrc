# ~/.bashrc

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/budchris/google-cloud-sdk/path.bash.inc' ]; then . '/Users/budchris/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/budchris/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/budchris/google-cloud-sdk/completion.bash.inc'; fi

# Aliases
alias hist="history 1"

# Completion for terraform
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/budchris/miniconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
	eval "$__conda_setup"
else
	if [ -f "/Users/budchris/miniconda3/etc/profile.d/conda.sh" ]; then
		. "/Users/budchris/miniconda3/etc/profile.d/conda.sh"
	else
		export PATH="/Users/budchris/miniconda3/bin:$PATH"
	fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Add $HOME/bin to PATH
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Load bash completions if available
if [ -f /usr/local/etc/bash_completion ]; then
	. /usr/local/etc/bash_completion
elif [ -f /opt/homebrew/etc/bash_completion ]; then
	. /opt/homebrew/etc/bash_completion
fi

# Set the terminal to handle backspace correctly
stty erase '^?'

# Environment Variables
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Remove that annoying message from mac about using bash
export BASH_SILENCE_DEPRECATION_WARNING=1

# Set STARSHIP_CONFIG environment variable
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init bash)"
