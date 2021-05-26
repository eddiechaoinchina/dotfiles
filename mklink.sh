#!/usr/bin/env bash
# Author: Will Chao <nerdzzh@gmail.com>
# Filename: mklink.sh
# Last Change: 05/26/21 20:44:55 +0800
# Brief: Make symlink for dotfiles.

DOTFILES_PATH=$(dirname $(realpath -s $0))
LINK_CMD="ln -s --force --verbose"

if [ ! -d "$HOME/.vim" ] ; then
  mkdir -p $HOME/.vim
fi

$LINK_CMD $DOTFILES_PATH/.gitconfig ~/.gitconfig
$LINK_CMD $DOTFILES_PATH/.tmux.conf ~/.tmux.conf
$LINK_CMD $DOTFILES_PATH/.vimrc ~/.vimrc
$LINK_CMD $DOTFILES_PATH/custom-dictionary.utf-8.add ~/.vim/custom-dictionary.utf-8.add
$LINK_CMD $DOTFILES_PATH/init.fish $OMF_CONFIG/init.fish
