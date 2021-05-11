# Author: Will Chao <nerdzzh@gmail.com>
# Filename: init.fish
# Last Change: 05/11/21 16:26:26 +0800
# Brief: My init.fish File

# Preamble -------------------------------------- {{{

# Fish - The Friendly Interactive Shell
#
# The reason why I switched from bash and zsh to fish is mainly because of its
# easy scripting and good portability, as well as its fantastic oh-my-fish
# framework for plugin and theme management. Though I have to learn fish
# scripting in addition to bash, it is quite easy to pick up.
#
# The oh-my-fish framework has provided plenty of useful plugins and themes with
# easy installation. The theme I am currently using is the classic robbyrussell,
# which is simple, clean and at the same time pretty clear.
#
# Here are the fish plugins I cannot live without:
# --------------------------------------------
# fzf          | fuzzy finder          | <c-t>
# z            | jump between folders  |
# --------------------------------------------
#
# The fzf plugin needs prerequisite of the fzf package.

# }}}

# Variables ------------------------------------- {{{

if test -d $HOME/anaconda3 # Python
  set -x PATH $PATH $HOME/anaconda3/bin $HOME/.local/bin
end

if type -q java # Java
  set -x JAVA_HOME (readlink -f (which java))
end

# Make FZF search including hidden files...
if type -q fzf
  set -x FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'
end

# Terminal within VIM has a color problem...
if set -q VIM_TERMINAL
  set -x TERM screen-256color
end

# }}}

# Aliases --------------------------------------- {{{

if test -e $OMF_CONFIG/init.fish
  alias sofish='source $OMF_CONFIG/init.fish'
end

if type -q exa
  alias ls='exa --icons'
  alias ll='exa --icons --long --group --links'
  alias la='exa --icons --long --group --links --all'
end

if type -q git
  alias gs='git status'
  alias ga='git add'
  alias gci='git commit -m'
  alias gp='git push'
end

# }}}
