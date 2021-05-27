#!/usr/bin/env bash
# Author: Will Chao <nerdzzh@gmail.com>
# Filename: vimup.sh
# Last Change: 05/27/2021 06:37:53 PM +0800
# Brief: Set up vim dirs and files.

# step one: make directory
if [ ! -d "$HOME/.vim/autoload" ]; then
  mkdir -p $HOME/.vim/autoload
fi
if [ ! -d "$HOME/.vim/bundle" ]; then
  mkdir -p $HOME/.vim/bundle
fi

# step two: copy pathogen.vim
DOTFILES_PATH=$(dirname $(realpath -s $0))
if [ ! -f "$HOME/.vim/autoload/pathogen.vim" ]; then
  cp $DOTFILES_PATH/pathogen.vim $HOME/.vim/autoload/pathogen.vim \
    && echo "$HOME/.vim/autoload/pathogen.vim copied successfully"
fi

# step three: clone plugins

# ack.vim
if [ ! -d "$HOME/.vim/bundle/ack.vim" ]; then
  git clone https://github.com/mileszs/ack.vim $HOME/.vim/bundle/ack.vim
fi
# coc.nvim
if [ ! -d "$HOME/.vim/bundle/coc.nvim" ]; then
  git clone https://github.com/neoclide/coc.nvim $HOME/.vim/bundle/coc.nvim
fi
# ctrlp.vim
if [ ! -d "$HOME/.vim/bundle/ctrlp.vim" ]; then
  git clone https://github.com/ctrlpvim/ctrlp.vim $HOME/.vim/bundle/ctrlp.vim
fi
# emmet-vim
if [ ! -d "$HOME/.vim/bundle/emmet-vim" ]; then
  git clone https://github.com/mattn/emmet-vim $HOME/.vim/bundle/emmet-vim
fi
# gundo.vim
if [ ! -d "$HOME/.vim/bundle/gundo.vim" ]; then
  git clone https://github.com/sjl/gundo.vim $HOME/.vim/bundle/gundo.vim
fi
# nerdtree
if [ ! -d "$HOME/.vim/bundle/nerdtree" ]; then
  git clone https://github.com/scrooloose/nerdtree $HOME/.vim/bundle/nerdtree
fi
# nerdtree-git-plugin
if [ ! -d "$HOME/.vim/bundle/nerdtree-git-plugin" ]; then
  git clone https://github.com/xuyuanp/nerdtree-git-plugin $HOME/.vim/bundle/nerdtree-git-plugin
fi
# rainbow_parentheses.vim
if [ ! -d "$HOME/.vim/bundle/rainbow_parentheses.vim" ]; then
  git clone https://github.com/junegunn/rainbow_parentheses.vim $HOME/.vim/bundle/rainbow_parentheses.vim
fi
# supertab
if [ ! -d "$HOME/.vim/bundle/supertab" ]; then
  git clone https://github.com/ervandew/supertab $HOME/.vim/bundle/supertab
fi
# tabular
if [ ! -d "$HOME/.vim/bundle/tabular" ]; then
  git clone https://github.com/godlygeek/tabular $HOME/.vim/bundle/tabular
fi
# vim-autoformat
if [ ! -d "$HOME/.vim/bundle/vim-autoformat" ]; then
  git clone https://github.com/chiel92/vim-autoformat $HOME/.vim/bundle/vim-autoformat
fi
# vim-commentary
if [ ! -d "$HOME/.vim/bundle/vim-commentary" ]; then
  git clone https://github.com/tpope/vim-commentary $HOME/.vim/bundle/vim-commentary
fi
# vim-devicons
if [ ! -d "$HOME/.vim/bundle/vim-devicons" ]; then
  git clone https://github.com/ryanoasis/vim-devicons $HOME/.vim/bundle/vim-devicons
fi
# vim-fugitive
if [ ! -d "$HOME/.vim/bundle/vim-fugitive" ]; then
  git clone https://github.com/tpope/vim-fugitive $HOME/.vim/bundle/vim-fugitive
fi
# vim-gitgutter
if [ ! -d "$HOME/.vim/bundle/vim-gitgutter" ]; then
  git clone https://github.com/airblade/vim-gitgutter $HOME/.vim/bundle/vim-gitgutter
fi
# vim-nerdtree-syntax-highlight
if [ ! -d "$HOME/.vim/bundle/vim-nerdtree-syntax-highlight" ]; then
  git clone https://github.com/tiagofumo/vim-nerdtree-syntax-highlight $HOME/.vim/bundle/vim-nerdtree-syntax-highlight
fi
# vim-polyglot
if [ ! -d "$HOME/.vim/bundle/vim-polyglot" ]; then
  git clone https://github.com/sheerun/vim-polyglot $HOME/.vim/bundle/vim-polyglot
fi
