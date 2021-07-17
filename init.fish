# Author: Will Chao <nerdzzh@gmail.com>
# Filename: init.fish
# Last Change: 07/17/21 13:53:46 +0800
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

# Default Editor
set -g VISUAL vim
set -g EDITOR $VISUAL

if test -d $HOME/anaconda3 # Python
  set -x PATH $PATH $HOME/anaconda3/bin $HOME/.local/bin
end

if type -q java # Java
  set -gx JAVA_HOME (readlink -f (which java) | sed "s:/jre/bin/java::")
end

if test -d /home/linuxbrew # Homebrew
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

if type -q fzf
  # FZF with ag integration
  if type -q ag
    set -U FZF_FIND_FILE_COMMAND 'ag -l --hidden --ignore .git . $dir 2> /dev/null'
  end
  # FZF with exa integration
  if type -q exa
    set -U FZF_PREVIEW_DIR_CMD 'll'
  end
  # FZF with bat integration
  if type -q batcat
    set -U FZF_PREVIEW_FILE_CMD 'bat'
  end
  # Override default options
  set -U FZF_DEFAULT_OPTS '--height 40% --bind=ctrl-h:page-up,ctrl-l:page-down,ctrl-y:preview-up,ctrl-e:preview-down'
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
  alias g='git'
end

if type -q batcat
  alias bat='batcat --color=always --theme=gruvbox --style=plain'
end

# }}}
