#!/bin/sh
#
### Install Ruby and Cask ###
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew install caskroom/cask/brew-cask
mkdir -p ~/Library/LaunchAgents
### CLI Tools ###
brew cask install --appdir=/Applications iterm2
brew cask install --appdir=/Applications xquartz
### DEVELOPMENT TOOLS ###
brew cask install --appdir=/Applications java
brew cask install --appdir=/Applications sublime-text
brew cask install --appdir=/Applications sequel-pro
brew cask install --appdir=/Applications robomongo
brew cask install --appdir=/Applications github-desktop
brew cask install --appdir=/Applications google-cloud-sdk
brew cask install --appdir=/Applications cakebrew
brew cask install --appdir=/Applications eclipse-php
### WEB BROWSING ###
brew cask install --appdir=/Applications google-chrome
brew cask install --appdir=/Applications firefox
brew cask install --appdir=/Applications vivaldi
brew cask install --appdir=/Applications torbrowser
brew cask install --appdir=/Applications lastpass
brew cask install --appdir=/Applications fluid
#brew cask install --appdir=/Applications flash-player
brew cask install --appdir=/Applications xmarks-safari
#brew cask install --appdir=/Applications private-internet-access
### WEB STORAGE ###
brew cask install --appdir=/Applications bittorrent-sync
brew cask install --appdir=/Applications dropbox
brew cask install --appdir=/Applications google-drive
brew cask install --appdir=/Applications owncloud
### PRODUCTIVITY TOOLS ###
brew cask install --appdir=/Applications evernote
brew cask install --appdir=/Applications skitch
### FILE TRANSFER TOOLS ###
brew cask install --appdir=/Applications cyberduck
#brew cask install --appdir=/Applications filezilla
brew cask install --appdir=/Applications transmission
brew cask install --appdir=/Applications sabnzbd
### COMMUNICATION TOOLS ###
brew cask install --appdir=/Applications skype
brew cask install --appdir=/Applications hipchat
brew cask install --appdir=/Applications adium
brew cask install --appdir=/Applications chitchat
brew cask install --appdir=/Applications messenger
brew cask install --appdir=/Applications limechat
brew cask install --appdir=/Applications teamviewer
### FILE MANAGEMENT TOOLS ###
brew cask install --appdir=/Applications double-commander
brew cask install --appdir=/Applications the-unarchiver
#brew cask install --appdir=/Applications crashplan
### OSX TOOLS ###
brew cask install --appdir=/Applications menumeters
brew cask install --appdir=/Applications geektool
brew cask install --appdir=/Applications linein
#brew cask install --appdir=/Applications quicksilver
#brew cask install --appdir=/Applications alfred
#brew cask install --appdir=/Applications synergy
### GAMES ###
brew cask install --appdir=/Applications steam
brew cask install --appdir=/Applications kega-fusion
brew cask install --appdir=/Applications snes9x
brew cask install --appdir=/Applications nestopia
brew cask install --appdir=/Applications mame
#brew cask install --appdir=/Applications logitech-gaming-software
#brew cask install --appdir=/Applications xbox360-controller-driver
### MULTIMEDIA ###
brew cask install --appdir=/Applications kodi
brew cask install --appdir=/Applications vlc
brew cask install --appdir=/Applications jadengellar-helium
brew cask install --appdir=/Applications sonora
brew cask install --appdir=/Applications spotify
brew cask install --appdir=/Applications rdio
brew cask install --appdir=/Applications tomahawk
brew cask install --appdir=/Applications atraci
brew cask install --appdir=/Applications handbrake
brew cask install --appdir=/Applications audacity
brew cask install --appdir=/Applications gimp
brew cask install --appdir=/Applications picasa
brew cask install --appdir=/Applications google-earth
brew cask install --appdir=/Applications kindle
brew cask install --appdir=/Applications calibre
brew cask install --appdir=/Applications burn
### SYSTEM ADMINISTRATION TOOLS ###
brew cask install --appdir=/Applications tunnelblick
brew cask install --appdir=/Applications unetbootin
brew cask install --appdir=/Applications nmap
brew cask install --appdir=/Applications wireshark
brew cask install --appdir=/Applications virtualbox
brew cask install --appdir=/Applications vagrant
brew cask install --appdir=/Applications dockertoolbox
