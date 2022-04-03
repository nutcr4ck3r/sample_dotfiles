#!/bin/bash

###############
## Base tool ##
################################################################################
echo ""
echo "[MSG] Install basic tools."
sudo apt install -y peco xclip source-highlight docker.io docker-compose gawk tmux unar vim-gtk ripgrep bat


#########
## vim ##
################################################################################
sudo apt install -y nodejs


#########
## zsh ##
################################################################################
sudo apt install -y zsh
sudo chsh -s /usr/bin/zsh


#########
## git ##
################################################################################
echo ""
echo "[MSG[ Set git info."
echo "[MSG] Enter git email address."
read -r mail
git config --global user.email "$mail"
echo "[MSG] Enter git username."
read -r name
git config --global user.email "$name"


##########
## Done ##
################################################################################
echo "[MSG] Complete!!"
