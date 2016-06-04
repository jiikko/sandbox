alias ls='ls -F --color=auto'
bindkey -e
export PS1="${USER}@${HOST}:%~%# "
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
autoload -U compinit
compinit
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
function history-all { history -E 1 }
setopt share_history
setopt histignorealldups
