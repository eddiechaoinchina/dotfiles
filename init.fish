# Author: Will Chao <nerdzzh@gmail.com>
# Filename: init.fish
# Last Change: 05/09/21 22:18:33 +0800
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

set -xg PATH $PATH /home/zzh/anaconda3/bin /home/zzh/.local/bin # Python

set -xg JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64 # Java

# Make FZF search including hidden files...
set -xg FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'

# Terminal within VIM has a color problem...
if set -q VIM_TERMINAL
  set -x TERM screen-256color
end

# }}}

alias sofish='source $OMF_CONFIG/init.fish'

if type -q exa
  alias ls='exa --icons'
  alias ll='exa --icons --long --group --links'
  alias la='exa --icons --long --group --links --all'
end
