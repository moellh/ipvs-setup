################################################################################
# ZSH configuration file
# 
# - supposed to work on any system, where .dotfiles repo has been installed
# - for system specific configuration, use .zshrc.local
################################################################################

# powerlevel10k instant prompt
# must be at top of .zshrc
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zsh completion system
autoload -Uz compinit
compinit

# keybindngs

# home key moves cursor to beginning of line
bindkey "^[[H" beginning-of-line
# end key moves cursor to end of line
bindkey "^[[F" end-of-line

# <C-Left> moves cursor one word to left
bindkey "^[[1;5D" backward-word
# <C-Right> moves cursor one word to right
bindkey "^[[1;5C" forward-word

# <C-Backspace> deletes one word
bindkey "^[[3~" delete-char

# Up and Down arrow keys to scroll search history
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# load powerlevel10k
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# word selection like bash
autoload -U select-word-style
select-word-style bash


## zsh history
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory

# zsh plugins
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ls aliases
alias ls="/bin/ls --hyperlink=auto --color=auto -hF $@"
alias ll="ls -al"

# color directories
eval "$(dircolors -b ~/.dircolors)"

# custom scripts
export PATH="${PATH}:$HOME/.scripts" # user binaries

# default editor
EDITOR="nvim"
alias nvim=$HOME/local/bin/nvim

export PATH=$PATH:$HOME/local/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/local/lib
export MANPATH=$MANPATH:$HOME/local/share/man

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

[ -r /usr/local.nfs/rc/bashrc ] && . /usr/local.nfs/rc/bashrc > /dev/null 2>&1
module load python/3.10.4

source $HOME/spack/share/spack/setup-env.sh
