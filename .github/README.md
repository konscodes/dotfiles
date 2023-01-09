# Install Oh my zsh! and sync the settings with GitHub

> Get Oh My Zsh 👉 https://ohmyz.sh/

## Creating a new repo and pushing files
The repo will be initialized in the $HOME/.dotfiles/ folder with its working path for scanning being $HOME/ directory. We are going to use an alias dot for running git from this repo.
```bash
#!/usr/bin/env bash

# Let's create a new directory to store Git files 
mkdir $HOME/.dotfiles

# Initialize a new Git repository
git init --bare $HOME/.dotfiles

# Create an alias called 'dot' for running Git commands in the '$HOME/.dotfiles' repository
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/.git/ --work-tree=$HOME'" >> $HOME/.zshrc

# Run 'source' command to update the config
source $HOME/.zshrc

# Untracked files will not be shown when you run ‘dot status’
dotfiles config --local status.showUntrackedFiles no

# Set up a remote repository on GitHub or your Git server of choice
dotfiles remote add origin 'https://github.com/<user>/<repo>.git'
dotfiles branch -M main

# Add/Commit/Push changes as usual with ‘dotfiles’ command
dot add .zshrc
dot commit -m "add .zshrc"
dot push -u origin main
```

## Clone and setup existing repo for the new installation
```bash
#!/usr/bin/env bash

# Let's create a new directory to store Git files 
mkdir $HOME/.dotfiles

# Create global .gitignore file
echo ".dotfiles" >> .gitignore

# Clone Git repository
git clone --bare <remote-git-repo-url> $HOME

# Create an alias called 'dot' for running Git commands in the '$HOME/.dotfiles' repository
echo "alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/.git/ --work-tree=$HOME'" >> $HOME/.zshrc

# Run 'source' command to update the config
source $HOME/.zshrc

# Untracked files will not be shown when you run ‘dot status’
dotfiles config --local status.showUntrackedFiles no

# Updating the files in your working directory '$HOME' to match the version of the files in the branch
dotfiles checkout
dotfiles status

# Files with same names may already exist localy and Git wont overwrite them
# In this case you may need to run additional commands to restore the remote vertion
# Ignore local version of '.zshrc' and use the remote instead
dotfiles restore .zshrc
source $HOME/.zshrc
```
Instructions based on [this post](https://fwuensche.medium.com/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b)
