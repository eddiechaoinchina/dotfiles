#!/usr/bin/env bash
# Author: Will Chao <nerdzzh@gmail.com>
# Filename: setup.sh
# Last Change: 07/16/21 19:26:22 +0800
# Brief: Put dotfiles in their places.

# Get the full path of current directory
DOTFILES_PATH=$(dirname $(realpath -s $0))

echo "-------Making symlinks--------------------------"
# Make symlinks
. $DOTFILES_PATH/mklink.sh

echo "-------Copying files----------------------------"
# Make directories if not existent
if [ ! -d "$HOME/.config/peco" ]; then
  mkdir -p $HOME/.config/peco \
    && echo "DIR $HOME/.config/peco created successfully"
fi
if [ ! -d "$HOME/.config/pip" ]; then
  mkdir -p $HOME/.config/pip \
    && echo "DIR $HOME/.config/pip created successfully"
fi

# Copy .clang-format
echo "Copying .clang-format"
CLANG_FORMAT_PATH="$HOME/.clang-format"
if [ -f "$CLANG_FORMAT_PATH" ]; then
  echo "$CLANG_FORMAT_PATH already exists"
else
  cp $DOTFILES_PATH/.clang-format $CLANG_FORMAT_PATH \
    && echo "$CLANG_FORMAT_PATH copied successfully"
fi

# Copy pip.conf
echo "Copying pip.conf"
PIP_CONF_PATH="$HOME/.config/pip/pip.conf"
if [ -f "$PIP_CONF_PATH" ]; then
  echo "$PIP_CONF_PATH already exists"
else
  cp $DOTFILES_PATH/pip.conf $PIP_CONF_PATH \
    && echo "$PIP_CONF_PATH copied successfully"
fi

# Copy peco.config.json
echo "Copying peco.config.json"
PECO_CONF_PATH="$HOME/.config/peco/config.json"
if [ -f "$PECO_CONF_PATH" ]; then
  echo "$PECO_CONF_PATH already exists"
else
  cp $DOTFILES_PATH/peco.config.json $PECO_CONF_PATH \
    && echo "$PECO_CONF_PATH copied successfully"
fi

echo "-------APTs installing--------------------------"
echo "Please use aptinstall.sh in case you have not"

echo "-------Importing BAT theme----------------------"
echo "Please use batthemeimport.sh if you use bat and have not imported yet"

echo "-------Setting up VIM---------------------------"
echo "Please use vimup.sh for setting up vim environment"

echo "-------Updating VIM plugins---------------------"
echo "Please use vimpluginupdate.sh for updateing vim plugins"
