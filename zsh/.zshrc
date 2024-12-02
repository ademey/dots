# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/anne/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

bindkey '\e[H'  beginning-of-line
bindkey '\e[F'  end-of-line
bindkey '\e[3~' delete-char

alias la='ls -la'
alias code='codium'

# END!
eval "$(starship init zsh)"