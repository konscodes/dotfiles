#!/usr/bin/env bash
## Installation script for dotfiles ##
set -e  # enable the 'errexit' option
cd $HOME


# Set environment variables
DOTFILES_ROOT=$(pwd -P)
DOTFILES_GIT_CMD="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"


# Create information output functions
info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
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
install_zsh() {
  info 'installing zsh'
  # Install zsh on Ubuntu
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
      sudo apt-get update
      sudo apt-get install -y zsh
  # Install zsh on macOS using Homebrew
  elif [[ "$OSTYPE" == "darwin"* ]]; then
      brew install zsh
  fi
}

install_dotfiles () {
  info 'installing dotfiles'
  mkdir $HOME/.dotfiles
  echo ".dotfiles" >> .gitignore
  git clone --bare https://github.com/konscodes/dotfiles.git $HOME/.dotfiles
  $DOTFILES_GIT_CMD config --local status.showUntrackedFiles no
  $DOTFILES_GIT_CMD restore --staged .
  $DOTFILES_GIT_CMD restore .
  $DOTFILES_GIT_CMD status
}


# Run functions
info 'runnning the script'
