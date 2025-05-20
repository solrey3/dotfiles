# ~/.zshrc

#############################################
# Terminal & Environment Settings
#############################################
stty erase '^?'

#############################################
# Aliases
#############################################
alias dtf="cd ~/Repos/github.com/solrey3/dotfiles/ && nvim"
alias hist="history 1"
alias k=kubectl
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -lh'
alias nixc="cd ~/Repos/github.com/solrey3/nix-config/ && nvim"
alias p2="cd ~/Repos/github.com/solrey3/notes/ && nvim todo.md"
alias vi="nvim"
alias vim="nvim"

#############################################
# Installation Instructions (if applicable)
#############################################
# Nix:      nix-env -iA nixpkgs.neovim google-cloud-sdk terraform starship
# apt:      sudo apt-get install neovim google-cloud-sdk terraform starship
# Homebrew: brew install neovim google-cloud-sdk terraform starship

#############################################
# Oh-My-Zsh Configuration
#############################################
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"    # Change this theme if you prefer another one
[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"
source "$ZSH/custom/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
plugins=(git z sudo kubectl zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)

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
# Terraform Command Completion 
#############################################
autoload -U compinit && compinit
if [ -x "/opt/homebrew/bin/terraform" ]; then
  compdef _terraform terraform="/opt/homebrew/bin/terraform"
fi

#############################################
# Google Cloud SDK Setup
#############################################
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

#############################################
# Conda Initialization
#############################################
# >>> conda initialize >>>
__conda_setup="$('$HOME/miniconda/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
elif [ -f "$HOME/miniconda/etc/profile.d/conda.sh" ]; then
  . "$HOME/miniconda/etc/profile.d/conda.sh"
else
  export PATH="$HOME/miniconda/bin:$PATH"
fi
unset __conda_setup
# <<< conda initialize <<<

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
