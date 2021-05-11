#!/usr/bin/env bash
# Author: Will Chao <nerdzzh@gmail.com>
# Filename: setup.sh
# Last Change: 05/11/21 18:37:54 +0800
# Brief: Put dotfiles in their places.

DOTFILES_PATH=$(dirname $(realpath -s $0))

. $DOTFILES_PATH/mklink.sh

CLANG_FORMAT_PATH="$HOME/.clang-format"
if [ -f "$CLANG_FORMAT_PATH" ] ; then
  echo "$CLANG_FORMAT_PATH already exists"
else
  cp $DOTFILES_PATH/.clang-format $CLANG_FORMAT_PATH \
    && echo "$CLANG_FORMAT_PATH copied successfully"
fi

PIP_CONF_PATH="$HOME/.config/pip/pip.conf"
if [ -f "$PIP_CONF_PATH" ] ; then
  echo "$PIP_CONF_PATH already exists"
else
  cp $DOTFILES_PATH/pip.conf $PIP_CONF_PATH \
    && echo "$PIP_CONF_PATH copied successfully"
fi
