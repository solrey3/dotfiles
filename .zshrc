# Path to your oh-my-zsh installation (if using oh-my-zsh).
# export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
# ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to use command execution time stamps.
# HIST_STAMPS="yyyy-mm-dd"

# Source oh-my-zsh.
# source $ZSH/oh-my-zsh.sh

# Set PATH.
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"

# Aliases.
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

# Load NVM (Node Version Manager).
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Enable command autocompletion.
autoload -U compinit
compinit

# Custom prompt.
PROMPT='%n@%m %1~ %# '

# Enable Zsh autosuggestions (optional, requires installation).
# source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable Zsh syntax highlighting (optional, requires installation).
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Add any additional configuration below this line.
