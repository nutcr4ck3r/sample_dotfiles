#!/bin/bash

# Set file path.
path="$(cd $(dirname $0); pwd)/files"
bpath="$(cd $(dirname $0); pwd)/bin"
dots=($(ls -a $path))

# Rename files if file exists, and deploy links.
for var in "${dots[@]}"; do
  if [ "$var" != "." ] && [ "$var" != ".." ]; then
    if [ -L "$HOME/$var" ]; then
      echo "[exists link] $HOME/$var >> $var.org"
      mv "$HOME/$var" "$HOME/$var.org"
    elif [ -e "$HOME/$var" ]; then
      echo "[exists file] $HOME/$var >> $var.org"
      mv "$HOME/$var" "$HOME/$var.org"
    fi
    ln -s "$path/$var" "$HOME/$var"
    echo "[create link] $path/$var to $HOME/$var"
  fi
done

# Delete old files.
printf "Delete orginal files? [y/n:default (n)] : "
read -r res
if [ "$res" = "y" ] || [ "$res" = "Y" ] || \
   [ "$res" = "yes" ] || [ "$res" = "YES" ]; then
  for var in "${dots[@]}"; do
    if [ "$var" != "." ] && [ "$var" != ".." ]; then
      rm -r "$HOME/$var.org"
      echo "[delete original] $HOME/$var.org"
    fi
  done
fi

echo -e "[finish!!]"
