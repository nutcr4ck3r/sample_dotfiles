#!/bin/bash

###############
## Base tool ##
################################################################################
echo ""
echo "[i] Install basic tools."
sudo apt install -y \
  xclip source-highlight docker.io docker-compose \
  gawk tmux unar ripgrep bat wget curl git unzip ranger \
  python3-pip python3-venv fzf bat

# Create .local/bin directory & batcat link for fzf/rg
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# Install glow to enable syntax highlighting on markdown files
wget https://github.com/charmbracelet/glow/releases/download/v1.5.1/glow_1.5.1_amd64.deb \
  -O ~/Downloads/glow.deb
sudo dpkg -i ~/Downloads/glow.deb
rm ~/Downloads/glow.deb

# Download & install HackGen Console NF
wget https://github.com/yuru7/HackGen/releases/download/v2.9.0/HackGen_NF_v2.9.0.zip \
  -O ~/Downloads/Hack.zip
unzip ~/Downloads/Hack.zip -d ~/Downloads/
mkdir -p ~/.fonts
mv ~/Downloads/HackGen_NF_v2.9.0/Hack* ~/.fonts/
rm ~/Downloads/Hack.zip
rm -r ~/Downloads/HackGen_NF_v2.9.0

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# pyenv
curl https://pyenv.run | bash

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
# git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git
# source zsh-snap/install.zsh


##########
## Done ##
################################################################################
echo "[i] Complete!!"
echo "[i] Please run 'deploy.sh' and re-login to reflect settings"
