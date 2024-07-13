#!/bin/bash

###############
## Base tool ##
################################################################################
echo ""
echo "[i] Install basic tools."
sudo apt install -y \
  peco xclip source-highlight docker.io docker-compose \
  gawk tmux unar ripgrep bat wget curl git
  # gawk tmux unar vim-gtk ripgrep bat wget curl git

# Install glow to enable syntax highlighting on markdown files
wget https://github.com/charmbracelet/glow/releases/download/v1.5.1/glow_1.5.1_amd64.deb \
  -O ~/Downloads/glow.deb
sudo dpkg -i ~/Downloads/glow.deb
rm ~/Downloads/glow.deb


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
