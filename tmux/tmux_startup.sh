#!/bin/bash

# ~/.config/tmux/tmux_startup.sh

# Function to create a session with specified windows and panes
create_session() {
    session_name=$1
    tmux new-session -d -s "$session_name" -n temp_window

    # Shift to first window to use it for the first named window
    tmux rename-window -t "$session_name":1 temp_window
}

# Function to create a window and set up panes
create_window() {
    session_name=$1
    window_name=$2
    shift 2

    tmux new-window -t "$session_name" -n "$window_name"
    while [[ $# -gt 0 ]]; do
        tmux split-window "$@"
        shift
    done
    tmux select-layout tiled
}

# Function to run commands in panes
run_command_in_pane() {
    session_name=$1
    window_index=$2
    pane_index=$3
    command=$4

    tmux send-keys -t "$session_name:$window_index.$pane_index" "$command" C-m
}

# Set up the 'home' session
create_session "home"

# Window: local
tmux rename-window -t home:1 'local'
tmux split-window -h -t home:1
run_command_in_pane "home" 1 0 "nvim ~"
run_command_in_pane "home" 1 1 "cd ~"

# Window: pi
create_window "home" "pi"
tmux split-window -h -t home:2
tmux split-window -v -t home:2.1
run_command_in_pane "home" 2 0 "ssh budchris@solr-raspberrypi.local"
run_command_in_pane "home" 2 1 "ssh -L 5901:localhost:5901 -C -N -l budchris solr-raspberrypi.local"
run_command_in_pane "home" 2 2 "open vnc://localhost:5901"

# Window: jukebox
create_window "home" "jukebox"

# Set up the 'work' session
create_session "work"

# Window: status
tmux rename-window -t work:1 'status'
run_command_in_pane "work" 1 0 "nvim ~/Projects/sn"

# Window: v4
create_window "work" "v4"
tmux split-window -h -t work:2
run_command_in_pane "work" 2 0 "nvim ~/Projects/sn/sn-v4"
run_command_in_pane "work" 2 1 "cd ~/Projects/sn/sn-v4"

# Window: v1
create_window "work" "v1"
tmux split-window -h -t work:3
run_command_in_pane "work" 3 0 "nvim ~/Projects/sn/simplenight"
run_command_in_pane "work" 3 1 "cd ~/Projects/sn/simplenight"

# Set up the 'remote' session
create_session "remote"

# Window: workstation
tmux rename-window -t remote:1 'workstation'
run_command_in_pane "remote" 1 0 "ssh player1@workstation"

# Attach to the 'home' session by default
tmux attach-session -t home
