#!/bin/bash

###############
## Base tool ##
################################################################################
echo ""
echo "[i] Install basic tools."
sudo apt install -y \
  xclip source-highlight docker.io docker-compose \
  gawk tmux unar ripgrep bat wget curl git unzip ranger \
  python3-pip python3-venv fzf vim-gtk3 xsel

# Create link for batcat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# pyenv
curl https://pyenv.run | bash

# Download & install HackGen Console NF
wget https://github.com/yuru7/HackGen/releases/download/v2.9.0/HackGen_NF_v2.9.0.zip \
  -O ~/Downloads/Hack.zip
unzip ~/Downloads/Hack.zip -d ~/Downloads/
mkdir -p ~/.fonts
mv ~/Downloads/HackGen_NF_v2.9.0/Hack* ~/.fonts/
rm ~/Downloads/Hack.zip
rm -r ~/Downloads/HackGen_NF_v2.9.0

# Localization (Japanese font, Timezone)
sudo apt install -y fonts-ipafont fcitx-mozc
sudo rm -f /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
im-config


#########
## zsh ##
################################################################################
sudo apt install -y zsh
echo ""
echo "[i] Change login shell to zsh."
echo "[i] Enter your login user name."
read -r username
sudo chsh $username -s /usr/bin/zsh


#########
## git ##
################################################################################
echo ""
echo "[i] Set git info."
echo "[i] Enter git email address."
read -r mail
git config --global user.email $mail
echo "[i] Enter git username."
read -r name
git config --global user.email $name
git config --global core.quotepath false


##########
## Done ##
################################################################################
echo "[i] Complete!!"
echo "[i] Please run 'deploy.sh' and re-login to reflect settings"
