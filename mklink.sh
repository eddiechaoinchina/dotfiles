#!/usr/bin/env bash
# Author: Will Chao <nerdzzh@gmail.com>
# Filename: mklink.sh
# Last Change: 05/11/21 17:19:33 +0800
# Brief: Make symlink for dotfiles.

LINK='ln -s --force --verbose'

$LINK ./.vimrc ~/.vimrc
$LINK ./.tmux.conf ~/.tmux.conf
$LINK ./init.fish $OMF_CONFIG/init.fish
