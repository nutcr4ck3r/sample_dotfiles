#!/bin/bash

###############
## Base tool ##
################################################################################
echo ""
echo "[i] Install basic tools."
sudo apt install -y \
  peco xclip source-highlight docker.io docker-compose \
  gawk tmux unar vim-gtk ripgrep bat wget curl git


############
## neovim ##
################################################################################
# Download and install neovim
mkdir -p ~/Downloads
wget https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.deb \
  -O ~/Downloads/nvim-linux64.deb
sudo dpkg -i ~/Downloads/nvim-linux64.deb

# Install packages
sudo apt install -y gcc g++ npm python3-pip python3-venv exuberant-ctags
sudo npm install -g yarn nodejs n
sudo n latest

# Deploy packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install code-minimap
wget https://github.com/wfxr/code-minimap/releases/download/v0.6.4/code-minimap-musl_0.6.4_amd64.deb \
  -O ~/Downloads/code-minimap-musl_0.6.4_amd64.deb
sudo dpkg -i ~/Downloads/code-minimap-musl_0.6.4_amd64.deb

# Create a s-link
path="$(cd $(dirname $0); pwd)/nvim" #create deploy file path
mkdir $path
if [ -e "$HOME/.config/nvim/init.vim" ]; then
  rm $HOME/.config/nvim/init.lua
fi
ln -s $path/init.lua $HOME/.config/nvim/init.lua

#########
## zsh ##
################################################################################
sudo apt install -y zsh
sudo chsh -s /usr/bin/zsh
git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git
source zsh-snap/install.zsh

#########
## git ##
################################################################################
echo ""
echo "[i] Set git info."
echo "[i] Enter git email address."
read -r mail
git config --global user.email "$mail"
echo "[i] Enter git username."
read -r name
git config --global user.email "$name"

##########
## Done ##
################################################################################
echo "[i] Complete!!"
echo "[i] Please run 'deploy.sh' and re-login to reflect settings"
