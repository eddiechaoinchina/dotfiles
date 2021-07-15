#!/usr/bin/env bash
# Author: Will Chao <nerdzzh@gmail.com>
# Filename: aptinstall.sh
# Last Change: 07/15/21 21:39:40 +0800
# Brief: SUDO apt install PACKAGES

if [ $(id -u) -ne 0 ]; then
  echo "NOT running as ROOT"
  exit 1
else
  apt install git curl gcc net-tools ack-grep silversearcher-ag nodejs npm fzf fish tmux vim-gtk openjdk-8-jdk peco wamerican bat
fi
