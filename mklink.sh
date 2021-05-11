#!/usr/bin/env bash
# Author: Will Chao <nerdzzh@gmail.com>
# Filename: mklink.sh
# Last Change: 05/11/21 17:43:11 +0800
# Brief: Make symlink for dotfiles.

DOTFILES_PATH=$(dirname $(realpath -s $0))
LINK_CMD="ln -s --force --verbose"

$LINK_CMD $DOTFILES_PATH/.tmux.conf ~/.tmux.conf
$LINK_CMD $DOTFILES_PATH/init.fish $OMF_CONFIG/init.fish
$LINK_CMD $DOTFILES_PATH/.vimrc ~/.vimrc
