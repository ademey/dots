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
alias ll='ls -la'
alias cat='bat'
alias code='codium'
alias vim='nvim'
alias vi='nvim'

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_CTRL_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
eval "$(fzf --zsh)"

eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"


# END!
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
