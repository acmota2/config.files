# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

export ZDOTDIR=$HOME/.config/zsh/

bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'
# End of lines added by compinstall

autoload -Uz compinit && compinit
autoload -Uz vcs_info

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats "%B%K{220}%F{17} %b "

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
PROMPT=\$vcs_info_msg_0_'%# '

setopt PROMPT_SUBST
PROMPT=\$vcs_info_msg_0_'%K{128} %k%B%K{128}%F{white}%n%f%k%b%K{128} %k%K{23} %k%K{23}%~%k%K{23} >%k '

zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")'
zstyle ':completion:*' menu select

# my keybinds
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^H' backward-kill-word
bindkey '5~' kill-word
bindkey -M menuselect '^[[Z' reverse-menu-complete

# options
unsetopt BEEP
setopt auto_cd

zmodload  zsh/complist
zmodload zsh/mathfunc

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias schlaf='systemctl suspend'
alias byebye='shutdown -h now'
alias ls='ls --color'
alias als='ls -la'
alias relsh='source $HOME/.zshrc; print Shell reloaded'
function gitc() {
  git clone git@github.com:$1
}

[ -f "/home/acmota2/.ghcup/env" ] && source "/home/acmota2/.ghcup/env" # ghcup-env%

