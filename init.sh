#!/bin/bash

###############
## Base tool ##
################################################################################
echo ""
echo "[i] Install basic tools."
sudo apt install -y \
  xclip source-highlight docker.io docker-compose \
  gawk tmux unar ripgrep bat wget curl git
  # gawk tmux unar vim-gtk ripgrep bat wget curl git

# Install glow to enable syntax highlighting on markdown files
wget https://github.com/charmbracelet/glow/releases/download/v1.5.1/glow_1.5.1_amd64.deb \
  -O ~/Downloads/glow.deb
sudo dpkg -i ~/Downloads/glow.deb
rm ~/Downloads/glow.deb

# Install peco to search command histories
wget https://github.com/peco/peco/releases/download/v0.5.11/peco_linux_amd64.tar.gz \
  -O ~/Downloads/peco.tar.gz
tar -zxvf ~/Downloads/peco.tar.gz -C ~/Downloads/
mkdir -p ~/.local/bin
move ~/Downloads/peco_linux_amd64/peco ~/.local/bin/
rm ~/Downloads/peco.tar.gz
rm -r ~/Downloads/peco_linux_amd64


#########
## zsh ##
################################################################################
sudo apt install -y zsh
echo ""
echo "[i] Change login shell to zsh."
echo "[i] Enter your login user name."
read -r username
sudo chsh $username -s /usr/bin/zsh
# git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git
# source zsh-snap/install.zsh


##########
## Done ##
################################################################################
echo "[i] Complete!!"
echo "[i] Please run 'deploy.sh' and re-login to reflect settings"
