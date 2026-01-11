# ~/.zshrc

#############################################
# Terminal & Environment Settings
#############################################
stty erase '^?'

#############################################
# Aliases
#############################################
# Traditional ls replacements with eza (if available)
if command -v eza &> /dev/null; then
  alias ls="eza"
  alias ll="eza -l"
  alias la="eza -la"
  alias lt="eza -T"
  alias lg="eza -l --git"
else
  # Fallback to traditional ls
  alias l='ls -CF'
  alias la='ls -A'
  alias ll='ls -lh'
fi

# fd aliases (if available)
if command -v fd &> /dev/null; then
  alias find="fd"
fi

# Other aliases
alias dtf="cd ~/.dotfiles/ && nvim"
alias hist="history 1"
alias k=kubectl
alias nixc="cd ~/.nix-config/ && nvim"
alias nc="cd ~/nix-config; nvim README.md"
alias p2="cd ~/Nextcloud/obsidian/player2; nvim readme.md"
alias vi="nvim"
alias vim="nvim"
alias nano="nvim"
alias neofetch="fastfetch"
alias gcm="git commit -m"
alias gco="git checkout"

# URL encode/decode utilities
alias urldecode='python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))"'

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
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/go/bin:/usr/local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

#############################################
# Oh-My-Zsh Configuration
#############################################
# Note: Oh-My-Zsh provides git, z (similar to zoxide), sudo, and kubectl plugins
# If oh-my-zsh is not installed, you can install it from: https://ohmyz.sh/
# Or use zsh without it - the aliases above will still work

# Uncomment and configure if oh-my-zsh is installed:
# export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"
# plugins=(git z sudo kubectl)
# source $ZSH/oh-my-zsh.sh

# Syntax highlighting and autosuggestions
# Install manually if not using oh-my-zsh:
# - zsh-syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting
# - zsh-autosuggestions: https://github.com/zsh-users/zsh-autosuggestions

#############################################
# Initialize zoxide (modern cd replacement)
#############################################
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

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
