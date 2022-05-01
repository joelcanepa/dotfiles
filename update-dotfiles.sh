#!/usr/bin/env bash

rm ~/dotfiles/update-dotfiles.sh
cp ~/update-dotfiles.sh ~/dotfiles/

rm -rf ~/dotfiles/.config/i3
cp -r ~/.config/i3 ~/dotfiles/.config