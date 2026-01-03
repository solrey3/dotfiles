#!/bin/bash

# Check if a hostname argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <new-hostname>"
  exit 1
fi

# Set the new hostname
NEW_HOSTNAME=$1

# Change the ComputerName
sudo scutil --set ComputerName "$NEW_HOSTNAME"

# Change the HostName
sudo scutil --set HostName "$NEW_HOSTNAME"

# Change the LocalHostName
sudo scutil --set LocalHostName "$NEW_HOSTNAME"

# Verify the changes
echo "New ComputerName: $(scutil --get ComputerName)"
echo "New HostName: $(scutil --get HostName)"
echo "New LocalHostName: $(scutil --get LocalHostName)"

echo "Hostname has been updated to '$NEW_HOSTNAME'."
