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
  if [ -d "$HOME/.dotfiles" ]; then
    info 'The .dotfiles directory exists in the home directory'
  else
    info 'Installing dotfiles'
    mkdir $HOME/.dotfiles
    echo ".dotfiles" >> .gitignore
    git clone --bare https://github.com/konscodes/dotfiles.git $HOME/.dotfiles
    $DOTFILES_GIT_CMD config --local status.showUntrackedFiles no
    $DOTFILES_GIT_CMD restore --staged .
    $DOTFILES_GIT_CMD restore .
    $DOTFILES_GIT_CMD status
    success
}

install_packets() {
  info 'Installing Oh My Zsh'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  info 'Installing zsh plugins'
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    $ZSH_CUSTOM/plugins/zsh-autosuggestions
  
}
install_packets_linux() {
  info 'Uptating sources'
  sudo apt update

  info 'Installing Neovim'
  sudo apt install neovim python3-neovim

  info 'Installing exa'
  curl http://ftp.jp.debian.org/debian/pool/main/r/rust-exa/exa_0.9.0-5+b1_amd64.deb | sudo dpkg -i -

  info 'Installing peco'
  sudo apt install peco

  info 'Installing ghq'
  curl -LO https://github.com/x-motemen/ghq/releases/download/v1.4.1/ghq_linux_amd64.zip
  unzip ghq_linux_amd64.zip && mv ghq_linux_amd64/ghq /usr/local/bin/
  rm -rf ghq*

  info 'Installing glow'
  curl -LO https://github.com/charmbracelet/glow/releases/download/v1.5.0/glow_1.5.0_Linux_x86_64.tar.gz
  mkdir glow-1.5.0 && tar -zxf ./glow_1.5.0_Linux_x86_64.tar.gz -C glow-1.5.0
  mv glow-1.5.0/glow /usr/local/bin/
  rm -rf glow*
}

install_packets_mac() {
  info 'Installing Homebrew'
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if command -v brew &> /dev/null; then
    success
  fi
    fail 'Homebrew installation failed'
  
  info 'Installing neovim'
  brew install neovim
  
  info 'Installing exa'
  brew install exa

  info 'Installing peco'
  brew install peco

  info 'Installing ghq'
  brew install ghq

  info 'Installing glow'
  brew install glow
}


# Run functions
info 'Installing dotfiles'
install_dotfiles

info 'Installing packets'
install_packets

info 'Installing OS specific packets'
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    info 'Linux detected'
    info 'Installing zsh'
    sudo apt install zsh
    install_packets_linux
elif [[ "$OSTYPE" == "darwin"* ]]; then
    info 'MacOS detected'
    install_packets_mac
fi
