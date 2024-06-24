#!/bin/bash

# Check if tmux is installed
if ! command -v tmux &> /dev/null; then
    echo "tmux could not be found"
    exit 1
fi

# Start or attach to the home session
tmux new-session -d -s home -n 'Home - Window 1'
tmux new-window -t home:2 -n 'Home - Window 2'
tmux split-window -h -t home:2
tmux split-window -v -t home:2.1
tmux new-window -t home:3 -n 'Home - Window 3'

# Start or attach to the work session
tmux new-session -d -s work -n 'Work - Window 1'
tmux new-window -t work:2 -n 'Work - Window 2'
tmux split-window -h -t work:2
tmux split-window -v -t work:2.1
tmux new-window -t work:3 -n 'Work - Window 3'

# Attach to the home session by default
tmux attach-session -t home
