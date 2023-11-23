#!/usr/bin/env bash
## Installation script for dotfiles ##
set -e  # enable the 'errexit' option
cd $HOME


# Set environment variables
DOTFILES_ROOT=$(pwd -P)
DOTFILES_GIT_CMD="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

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
  if [ -d "$HOME/.dotfiles" ]; then
    success 'The .dotfiles exists in the home directory'
  else
    info 'Installing dotfiles'
    mkdir $HOME/.dotfiles
    echo ".dotfiles" >> .gitignore
    git clone --bare --quiet https://github.com/konscodes/dotfiles.git $HOME/.dotfiles > /dev/null
    $DOTFILES_GIT_CMD config --local status.showUntrackedFiles no
    $DOTFILES_GIT_CMD restore --staged .
    $DOTFILES_GIT_CMD restore .
    $DOTFILES_GIT_CMD status  
    success 'Dotfiles installed'
  fi
}

install_packets() {
  info 'Installing Oh My Zsh'
  # Check if Oh My Zsh is already installed
  if [ -d "$HOME/.oh-my-zsh" ]; then
    success 'The .oh-my-zsh exists in the home directory'
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    success 'Oh My Zsh installed'
  fi

  set +e # disable 'errexit' option

  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" > /dev/null 2>&1
  success 'zsh-syntax-highlighting plugin installed'

  git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions" > /dev/null 2>&1
  success 'zsh-autosuggestions plugin installed'
  
  set -e # re-enable 'errexit' option
}

install_packets_linux() {
  info 'Updating package index'
  sudo apt-get update -y > /dev/null
  success 'Package index updated'

  info 'Installing unzip'
  sudo apt-get install unzip -y > /dev/null

  info 'Installing git'
  sudo apt-get install -y git > /dev/null

  info 'Installing zsh'
  sudo apt-get install -y zsh > /dev/null

  info 'Installing neovim'
  sudo apt-get install -y neovim python3-neovim > /dev/null

  info 'Installing exa'
  curl -sLO https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip
  unzip -q exa-linux-x86_64-v0.10.1.zip -d ./exa && sudo mv exa/bin/exa /usr/local/bin/
  rm -rf exa*

  info 'Installing peco'
  sudo apt-get install -y peco > /dev/null

  info 'Installing ghq'
  curl -sLO https://github.com/x-motemen/ghq/releases/download/v1.4.1/ghq_linux_amd64.zip > /dev/null
  unzip -q ghq_linux_amd64.zip && sudo mv ghq_linux_amd64/ghq /usr/local/bin/
  rm -rf ghq*

  info 'Installing glow'
  curl -sLO https://github.com/charmbracelet/glow/releases/download/v1.5.0/glow_1.5.0_Linux_x86_64.tar.gz > /dev/null
  mkdir glow-1.5.0 && tar -zxf ./glow_1.5.0_Linux_x86_64.tar.gz -C glow-1.5.0
  sudo mv glow-1.5.0/glow /usr/local/bin/
  rm -rf glow*
}

install_packets_mac() {
  info 'Installing Homebrew'
  if command -v brew &> /dev/null; then
    success 'Homebrew is already installed'
  else
    NONINTERACTIVE=1 /bin/bash -c \
      "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null
    success 'Homebrew installed'
  fi
  info 'Addign brew to PATH'
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$USER/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
  
  info 'Installing git'
  brew install --quiet git > /dev/null

  info 'Installing neovim'
  brew install --quiet neovim > /dev/null
  
  info 'Installing exa'
  brew install --quiet exa > /dev/null

  info 'Installing peco'
  brew install --quiet peco > /dev/null

  info 'Installing ghq'
  brew install --quiet ghq > /dev/null

  info 'Installing glow'
  brew install --quiet glow > /dev/null
}


# Run functions
info 'Running main functions'
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    info 'Linux detected'
    install_packets_linux
elif [[ "$OSTYPE" == "darwin"* ]]; then
    info 'MacOS detected'
    install_packets_mac
fi

install_dotfiles
install_packets
success 'Completed'
zsh
