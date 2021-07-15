#!/usr/bin/env bash
# Author: Will Chao <nerdzzh@gmail.com>
# Filename: batthemeimport.sh
# Last Change: 07/15/21 18:18:12 +0800
# Brief: Import gruvbox theme for bat

DOTFILES_PATH=$(dirname $(realpath -s $0))

# HUGE THANKS to @peaceant
if which batcat > /dev/null 2>&1; then
  mkdir -p "$(batcat --config-dir)/themes"
  cp $DOTFILES_PATH/gruvbox.tmTheme "$(batcat --config-dir)/themes"
  batcat cache --build
fi
