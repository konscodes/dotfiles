# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Created by `pipx` on 2023-02-13 11:05:53
export PATH="$PATH:$HOME/.local/bin"

# For apps build with Go
export PATH="$PATH:$HOME/go/bin"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Disable autocorrect
unsetopt correct_all

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vscode python z zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Set personal aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' # Git alias for config repo
alias py='python3' # Windows python instance for WSL
alias winpy='python.exe' # Local python instance
alias ll='exa -lah --icons' # Modern replacement for ls 
alias excel='/mnt/c/Program\ Files/Microsoft\ Office/Office15/EXCEL.EXE' # Excel alias for WSL
alias vim='nvim' # Replace vim with nvim

# Integration ghq + peco search and move to repo
function peco-projects () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-projects

# Integration history + peco search and execute
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history

# Key bindings
bindkey '^a' autosuggest-accept # ctrl + a
bindkey '^]' peco-projects # ctrl + ]
bindkey '^[' peco-select-history # ctrl + [

# Run the note with glow on terminal start
#glow $HOME/notes/modt.md
