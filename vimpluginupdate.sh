#!/usr/bin/env bash
# Author: Will Chao <nerdzzh@gmail.com>
# Filename: vimpluginupdate.sh
# Last Change: 05/27/21 14:00:38 +0800
# Brief: Update vim bundles with git pull.

cd ~/.vim/bundle
for i in $(ls); do
  cd "$i"
  git pull
  cd ..
done
