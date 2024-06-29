
# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/budchris/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/budchris/opt/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/budchris/opt/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/budchris/opt/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<


complete -C /opt/homebrew/bin/terraform terraform

# source /Users/budchris/.docker/init-bash.sh || true # Added by Docker Desktop

export BASH_SILENCE_DEPRECATION_WARNING=1

# Source .bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
