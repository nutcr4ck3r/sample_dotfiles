#!/bin/bash

###############
## Base tool ##
################################################################################
echo ""
echo "[i] Install basic tools."
sudo apt install -y \
  peco xclip source-highlight docker.io docker-compose \
  gawk tmux unar vim-gtk ripgrep bat wget curl


############
## neovim ##
################################################################################
# Download and install neovim
wget https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.deb \
  -O ~/Downloads
sudo dpkg -i ~/Downloads/nvim-linux64.deb

# Install packages
sudo apt install -y gcc g++ npm python3-pip python3-venv exuberant-ctags
sudo npm install -g yarn nodejs n
n latest

# Deploy vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Create a s-link
path="$(cd $(dirname $0); pwd)/nvim" #create deploy file path
mkdir $path
if [ -e "$HOME/.config/nvim/init.vim" ]; then
  rm $HOME/.config/nvim/init.vim
fi
ln -s $path/init.vim $HOME/.config/nvim/init.vim

#########
## vim ##
################################################################################
# sudo apt install -y nodejs exuberant-ctags
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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
