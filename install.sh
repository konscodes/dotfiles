#!/usr/bin/env bash
## Installation script for dotfiles ##
set -e  # enable the 'errexit' option
cd $HOME


# Set environment variables
DOTFILES_ROOT=$(pwd -P)
DOTFILES_GIT_CMD="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"


# Create information output functions
info () {
  printf "\r  [ \033[00;34mINFO\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo
  exit
}


# Create main functions
install_dotfiles () {
  info 'installing dotfiles'
  mkdir $HOME/.dotfiles
  echo ".dotfiles" >> .gitignore
  git clone --bare https://github.com/konscodes/dotfiles.git $HOME/.dotfiles
  $DOTFILES_GIT_CMD config --local status.showUntrackedFiles no
  $DOTFILES_GIT_CMD restore --staged .
  $DOTFILES_GIT_CMD restore .
  $DOTFILES_GIT_CMD status
  success
}

install_packets_linux() {
  info 'Uptating sources'
  sudo apt update
  sudo apt install zsh

  info 'Installing Oh My Zsh'
  /bin/bash -c "$(curl -fsSL \
  https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  info 'Installing exa'
  curl http://ftp.jp.debian.org/debian/pool/main/r/rust-exa/exa_0.9.0-5+b1_amd64.deb | sudo dpkg -i -

}

# Function to check if Homebrew is installed
check_homebrew() {
  info 'Checking if Homebrew is installed'
  if ! command -v brew &> /dev/null
  then
      return 1
  fi
  return 0
}

install_packets_mac() {
  info 'Installing Homebrew'
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL \
  https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if ! check_homebrew; then
    fail 'homebrew installation failed'
  fi
  
  info 'Installing Oh My Zsh'
  /bin/bash -c "$(curl -fsSL \
  https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  info 'Installing exa'
  brew install exa
}


# Run functions
info 'Installing dotfiles'
install_dotfiles

info 'Installing packets'
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    info 'Linux detected'
    install_packets_linux
elif [[ "$OSTYPE" == "darwin"* ]]; then
    info 'MacOS detected'
    install_packets_mac
fi
