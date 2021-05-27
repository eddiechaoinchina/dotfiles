#!/usr/bin/env bash
# Author: Will Chao <nerdzzh@gmail.com>
# Filename: vimup.sh
# Last Change: 05/27/21 17:19:01 +0800
# Brief: Set up vim dirs and files.

# step one: make directory
if [ ! -d "~/.vim/autoload" ]; then
  mkdir -p ~/.vim/autoload
fi
if [ ! -d "~/.vim/bundle" ]; then
  mkdir -p ~/.vim/bundle
fi

# step two: clone plugins

# ack.vim
if [ ! -d "~/.vim/bundle/ack.vim" ]; then
  git clone https://github.com/mileszs/ack.vim ~/.vim/bundle/ack.vim
fi
# coc.nvim
if [ ! -d "~/.vim/bundle/coc.nvim" ]; then
  git clone https://github.com/neoclide/coc.nvim ~/.vim/bundle/coc.nvim
fi
# ctrlp.vim
if [ ! -d "~/.vim/bundle/ctrlp.vim" ]; then
  git clone https://github.com/ctrlpvim/ctrlp.vim ~/.vim/bundle/ctrlp.vim
fi
# emmet-vim
if [ ! -d "~/.vim/bundle/emmet-vim" ]; then
  git clone https://github.com/mattn/emmet-vim ~/.vim/bundle/emmet-vim
fi
# gundo.vim
if [ ! -d "~/.vim/bundle/gundo.vim" ]; then
  git clone https://github.com/sjl/gundo.vim ~/.vim/bundle/gundo.vim
fi
# nerdtree
if [ ! -d "~/.vim/bundle/nerdtree" ]; then
  git clone https://github.com/scrooloose/nerdtree ~/.vim/bundle/nerdtree
fi
# nerdtree-git-plugin
if [ ! -d "~/.vim/bundle/nerdtree-git-plugin" ]; then
  git clone https://github.com/xuyuanp/nerdtree-git-plugin ~/.vim/bundle/nerdtree-git-plugin
fi
# rainbow_parentheses.vim
if [ ! -d "~/.vim/bundle/rainbow_parentheses.vim" ]; then
  git clone https://github.com/junegunn/rainbow_parentheses.vim ~/.vim/bundle/rainbow_parentheses.vim
fi
# supertab
if [ ! -d "~/.vim/bundle/supertab" ]; then
  git clone https://github.com/ervandew/supertab ~/.vim/bundle/supertab
fi
# tabular
if [ ! -d "~/.vim/bundle/tabular" ]; then
  git clone https://github.com/godlygeek/tabular ~/.vim/bundle/tabular
fi
# vim-autoformat
if [ ! -d "~/.vim/bundle/vim-autoformat" ]; then
  git clone https://github.com/chiel92/vim-autoformat ~/.vim/bundle/vim-autoformat
fi
# vim-commentary
if [ ! -d "~/.vim/bundle/vim-commentary" ]; then
  git clone https://github.com/tpope/vim-commentary ~/.vim/bundle/vim-commentary
fi
# vim-devicons
if [ ! -d "~/.vim/bundle/vim-devicons" ]; then
  git clone https://github.com/ryanoasis/vim-devicons ~/.vim/bundle/vim-devicons
fi
# vim-fugitive
if [ ! -d "~/.vim/bundle/vim-fugitive" ]; then
  git clone https://github.com/tpope/vim-fugitive ~/.vim/bundle/vim-fugitive
fi
# vim-gitgutter
if [ ! -d "~/.vim/bundle/vim-gitgutter" ]; then
  git clone https://github.com/airblade/vim-gitgutter ~/.vim/bundle/vim-gitgutter
fi
# vim-nerdtree-syntax-highlight
if [ ! -d "~/.vim/bundle/vim-nerdtree-syntax-highlight" ]; then
  git clone https://github.com/tiagofumo/vim-nerdtree-syntax-highlight ~/.vim/bundle/vim-nerdtree-syntax-highlight
fi
# vim-polyglot
if [ ! -d "~/.vim/bundle/vim-polyglot" ]; then
  git clone https://github.com/sheerun/vim-polyglot ~/.vim/bundle/vim-polyglot
fi
