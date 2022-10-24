#!/bin/bash

# Download and install neovim
wget https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.deb \
  -O ~/Downloads/nvim-linux64.deb
sudo dpkg -i ~/Downloads/nvim-linux64.deb

# Install packages
echo -e ""
echo -e "[+] Install packages."
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
echo -e ""
echo -e "[+] Create a symbol link"
mkdir -p ~/.config/nvim
path="$(cd $(dirname $0); pwd)/nvim" #create deploy file path
if [ -e "$HOME/.config/nvim/init.vim" ]; then
  rm $HOME/.config/nvim/init.lua
fi
ln -s $path/init.lua $HOME/.config/nvim/init.lua

echo -e ""
echo -e "[i] Finish!!"
