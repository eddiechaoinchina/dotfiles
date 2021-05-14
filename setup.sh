#!/usr/bin/env bash
# Author: Will Chao <nerdzzh@gmail.com>
# Filename: setup.sh
# Last Change: 05/14/21 12:08:18 +0800
# Brief: Put dotfiles in their places.

# Get the full path of current directory
DOTFILES_PATH=$(dirname $(realpath -s $0))

# Make symlinks
. $DOTFILES_PATH/mklink.sh

# Make directories if not existent
if [ ! -d "$HOME/.config/peco" ] ; then
  mkdir -p $HOME/.config/peco
fi
if [ ! -d "$HOME/.config/pip" ] ; then
  mkdir -p $HOME/.config/pip
fi

# Copy .clang-format
CLANG_FORMAT_PATH="$HOME/.clang-format"
if [ -f "$CLANG_FORMAT_PATH" ] ; then
  echo "$CLANG_FORMAT_PATH already exists"
else
  cp $DOTFILES_PATH/.clang-format $CLANG_FORMAT_PATH \
    && echo "$CLANG_FORMAT_PATH copied successfully"
fi

# Copy pip.conf
PIP_CONF_PATH="$HOME/.config/pip/pip.conf"
if [ -f "$PIP_CONF_PATH" ] ; then
  echo "$PIP_CONF_PATH already exists"
else
  cp $DOTFILES_PATH/pip.conf $PIP_CONF_PATH \
    && echo "$PIP_CONF_PATH copied successfully"
fi

# Copy peco.config.json
PECO_CONF_PATH="$HOME/.config/peco/config.json"
if [ -f "$PECO_CONF_PATH" ] ; then
  echo "$PECO_CONF_PATH already exists"
else
  cp $DOTFILES_PATH/peco.config.json $PECO_CONF_PATH \
    && echo "$PECO_CONF_PATH copied successfully"
fi
