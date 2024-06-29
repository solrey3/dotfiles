#!/bin/bash

# Function to create a new Tmux session
create_session() {
	session_name=$1
	window_name=$2
	command=$3

	tmux new-session -d -s "$session_name" -n "$window_name"
	tmux send-keys -t "$session_name:$window_name" "$command" C-m
}

# Function to create a new window in an existing session
create_window() {
	session_name=$1
	window_name=$2
	command=$3

	tmux new-window -t "$session_name" -n "$window_name"
	tmux send-keys -t "$session_name:$window_name" "$command" C-m
}

# Create Home session with 3 windows
create_session "Home" "Yo" "bash"
create_window "Home" "Pi" "ssh budchris@solr-raspberrypi.local"
create_window "Home" "Config" "cd ~/dotfiles; nvim"

# Create Work session with 2 windows
create_session "Work" "Local" "cd ~/Projects/sn; nvim"
create_window "Work" "Remote" "ssh player1@workstation"

# Create Player2 session with 1 window
create_session "Player2" "Main" "cd ~/Nextcloud/obsidian/vault/Player2"

# Attach to the Home session by default
tmux attach-session -t Home
