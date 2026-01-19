# ~/.bashrc

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# =============================================================================
# History Configuration
# =============================================================================
# Append to history file, don't overwrite
shopt -s histappend

# No duplicate entries, erase duplicates
export HISTCONTROL=ignoredups:erasedups

# History size
HISTSIZE=1000
HISTFILESIZE=2000

# =============================================================================
# Shell Options
# =============================================================================
# Check window size after each command
shopt -s checkwinsize

# Set the terminal to handle backspace correctly
stty erase '^?'

# Default parameters for "less": -R: ANSI colors; -i: case insensitive search
LESS="-R -i"

# =============================================================================
# PATH Configuration
# =============================================================================
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/go/bin:$PATH"

# Go (system install)
export PATH="$PATH:/usr/local/go/bin"

# Homebrew (macOS)
export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# =============================================================================
# Environment Variables
# =============================================================================
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export BASH_SILENCE_DEPRECATION_WARNING=1
export NIXPKGS_ALLOW_UNFREE=1
export STARSHIP_CONFIG=~/.config/starship.toml

# =============================================================================
# Prompt Configuration
# =============================================================================
# Set variable identifying the chroot you work in
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# Color variables for prompt customization
red='\[\e[0;31m\]'
RED='\[\e[1;31m\]'
blue='\[\e[0;34m\]'
BLUE='\[\e[1;34m\]'
cyan='\[\e[0;36m\]'
CYAN='\[\e[1;36m\]'
green='\[\e[0;32m\]'
GREEN='\[\e[1;32m\]'
yellow='\[\e[0;33m\]'
YELLOW='\[\e[1;33m\]'
PURPLE='\[\e[1;35m\]'
purple='\[\e[0;35m\]'
nc='\[\e[0m\]'

# Set fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Custom colored prompt based on user
if [ "$UID" = 0 ]; then
  PS1="$red\u$nc@$red\H$nc:$CYAN\w$nc\\n$red#$nc "
else
  PS1="$PURPLE\u$nc@$CYAN\H$nc:$GREEN\w$nc\\n$GREEN\$$nc "
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# =============================================================================
# Color Support
# =============================================================================
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# =============================================================================
# Aliases
# =============================================================================
# Traditional ls replacements with eza (if available)
if command -v eza &>/dev/null; then
  alias ls="eza"
  alias ll="eza -l"
  alias la="eza -la"
  alias lt="eza -T"
  alias lg="eza -l --git"
else
  # Fallback to traditional ls
  alias ll='ls -lh'
  alias la='ls -A'
  alias l='ls -CF'
fi

# fd aliases (if available)
if command -v fd &>/dev/null; then
  alias find="fd"
fi

# Editor aliases
alias vi="nvim"
alias vim="nvim"

# Navigation and utility aliases
alias hist="history 1"
alias dtf="cd ~/.dotfiles; nvim"
alias notes="cd ~/Documents/Notes; nvim"

# Git aliases
alias gcm="git commit -m"
alias gco="git checkout"

# Kubernetes
alias k="kubectl"

# URL encode/decode utilities
alias urldecode='python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))"'

# Alert alias for long running commands (use: sleep 10; alert)
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Source additional aliases if available
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# =============================================================================
# Completions
# =============================================================================
# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
  fi
fi

# Terraform completion
if [ -x /opt/homebrew/bin/terraform ]; then
  complete -o nospace -C /opt/homebrew/bin/terraform terraform
fi

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then
  . "$HOME/google-cloud-sdk/path.bash.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then
  . "$HOME/google-cloud-sdk/completion.bash.inc"
fi

# =============================================================================
# Interactive Shell Settings
# =============================================================================
if [[ $- == *i* ]]; then
  # Use up/down arrow keys to search history
  bind '"\e[A": history-search-backward'
  bind '"\e[B": history-search-forward'
fi

# =============================================================================
# Tool Initializations
# =============================================================================
# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Cargo (Rust)
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Nix
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# zoxide (if available)
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
fi

# starship prompt (should be last to override PS1)
if command -v starship &>/dev/null; then
  eval "$(starship init bash)"
fi
