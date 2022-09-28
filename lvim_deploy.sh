#!/bin/bash

# set local variables (dotfiles path, name)
path="$(cd $(dirname $0); pwd)/lvim" #create deploy file path

# Create s-links
if [ -e "$HOME/.config/lvim/config.lua" ]; then
  rm $HOME/.config/lvim/config.lua
fi
if [ -e "$HOME/.local/share/lunarvim/lvim/lua/lvim/lsp/config.lua" ]; then
  rm $HOME/.local/share/lunarvim/lvim/lua/lvim/lsp/config.lua
fi
if [ -e "$HOME/.local/share/lunarvim/lvim/lua/lvim/core/which-key.lua" ]; then
  rm $HOME/.local/share/lunarvim/lvim/lua/lvim/core/which-key.lua
fi
if [ -e "$HOME/.local/share/lunarvim/lvim/lua/lvim/core/nvimtree.lua" ]; then
  rm $HOME/.local/share/lunarvim/lvim/lua/lvim/core/nvimtree.lua
fi
ln -s $path/general_config.lua $HOME/.config/lvim/config.lua
ln -s $path/lsp_config.lua $HOME/.local/share/lunarvim/lvim/lua/lvim/lsp/config.lua
ln -s $path/which-key.lua $HOME/.local/share/lunarvim/lvim/lua/lvim/core/which-key.lua
ln -s $path/nvimtree.lua $HOME/.local/share/lunarvim/lvim/lua/lvim/core/nvimtree.lua

echo -e "[finish!!]"
