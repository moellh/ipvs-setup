#!/bin/bash

################################################################################
# installs config files and default programs
################################################################################

# prints each command, exits on error
set -ex

# check current directory
MAIN_DIR=$(pwd)
if [[ $(basename $MAIN_DIR) != "ipvs-setup" ]]; then
    echo "Run this script from ipvs-setup directory"
    exit 1
fi

# check current shell
read -p "Already linked a .bashrc.my file? (Y/n): " linked
if [[ $linked == "n" ]]; then
    echo 'source ~/.bashrc.my' >> $HOME/.bashrc
fi

# Directory for installed programs
INSTALL_DIR=$HOME/local
mkdir -p $INSTALL_DIR

# STOW -------------------------------------------------------------------------

STOW_VERSION=2.4.1

cd archives
tar -xzf stow-$STOW_VERSION.tar.gz
cd stow-$STOW_VERSION

./configure --prefix=$INSTALL_DIR
make
make install

cd ..
rm -rf stow-$STOW_VERSION

cd $MAIN_DIR

# ------------------------------------------------------------------------------

# put config in home directory
$HOME/local/bin/stow config-stow -t ~

# Neovim -----------------------------------------------------------------------

NEOVIM_VERSION=0.10.2
tar xvzf archives/nvim-linux64.tar.gz -C $INSTALL_DIR --strip-components 1

# ------------------------------------------------------------------------------

# Git --------------------------------------------------------------------------

# puts .gitconfig into home directory
# done separately because of input of user.name and user.email
cp config/.gitconfig ~/.gitconfig
read -p "Name for .gitconfig: " git_name
git config --global user.name "$git_name"
read -p "E-Mail for .gitconfig: " git_email
git config --global user.email "$git_email"

# ------------------------------------------------------------------------------

# installs zsh plugins
mkdir -p ~/.zsh
git clone https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

# installs tmux plugins
mkdir -p ~/.config/tmux/plugins
git clone https://github.com/dreamsofcode-io/catppuccin-tmux.git ~/.tmux/plugins/catppuccin-tmux
git clone https://github.com/tmux-plugins/tmux-sensible.git ~/.tmux/plugins/tmux-sensible
git clone https://github.com/tmux-plugins/tmux-yank.git ~/.tmux/plugins/tmux-yank
git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
git clone https://github.com/christoomey/vim-tmux-navigator.git ~/.tmux/plugins/vim-tmux-navigator

# nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install 20
npm install -g tree-sitter-cli
