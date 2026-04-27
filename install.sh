#!/usr/bin/env bash
echo "Symlinking dotfiles..."

mkdir -p ~/.config
ln -sfn ~/dotfiles/i3 ~/.config/i3
ln -sfn ~/dotfiles/polybar ~/.config/polybar
ln -sfn ~/dotfiles/picom ~/.config/picom
ln -sfn ~/dotfiles/rofi ~/.config/rofi
ln -sfn ~/dotfiles/dunst ~/.config/dunst

echo "Done! Press Super+Shift+R to reload i3."
