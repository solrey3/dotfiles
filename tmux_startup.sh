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

# Create Yo session with 3 windows
create_session "Yo" "Player1" "cd ~/dotfiles"
# create_window "Yo" "Player2" "cd ~/Nextcloud/obsidian/player2; nvim todo.md"
create_window "Yo" "Work" "cd ~/Projects/sn"

# Select the Player2 window
tmux select-window -t "Yo:Player1"

# Attach to the Home session by default
tmux attach-session -t Yo
