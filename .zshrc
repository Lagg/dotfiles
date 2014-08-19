# The following lines were added by compinstall
zstyle :compinstall filename '/home/anthony/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=10000
unsetopt beep
setopt hist_ignore_space
bindkey -e
# End of lines configured by zsh-newuser-install

autoload -U promptinit
promptinit

alias ls="ls --all --color=always"
alias pstree="pstree -p -l"
alias less="less -R"
alias htop="env TERM=xterm htop"

export PAGER="less"
export PATH="$PATH:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/games:/usr/games"
export MANPATH="$MANPATH:/usr/local/man:/usr/local/share/man"
export EDITOR="vim"
export VISUAL="$EDITOR"
export BROWSER="w3m"
export GPG_TTY=$(tty)

# Don't set TERM if it's a screen forked shell (term is already specified in screenrc)
if test -z "$STY"; then
    export TERM=xterm-256color
fi
