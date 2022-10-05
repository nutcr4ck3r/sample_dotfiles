#!/bin/bash

# Download and install neovim
wget https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.deb \
  -O ~/Downloads
sudo dpkg -i ~/Downloads/nvim-linux64.deb

# Install packages
echo -e "[+] Install packages."
sudo apt install -y gcc g++ npm python3-pip python3-venv exuberant-ctags
sudo npm install -g yarn nodejs n
n latest

# Deploy vim-plug
echo -e "[+] Deploy vim-plug."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Create a s-link
echo -e "[+] Create a symbol link"
path="$(cd $(dirname $0); pwd)/nvim" #create deploy file path
if [ -e "$HOME/.config/nvim/init.vim" ]; then
  rm $HOME/.config/nvim/init.vim
fi
ln -s $path/init.vim $HOME/.config/nvim/init.vim

echo -e "[i] Finish!!"
