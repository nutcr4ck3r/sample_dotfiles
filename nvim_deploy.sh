#!/bin/bash

# set local variables (dotfiles path, name)
path="$(cd $(dirname $0); pwd)/nvim" #create deploy file path

# Create s-links
if [ -e "$HOME/.config/nvim/init.vim" ]; then
  rm $HOME/.config/nvim/init.vim
fi

ln -s $path/init.vim $HOME/.config/nvim/init.vim

echo -e "[finish!!]"
