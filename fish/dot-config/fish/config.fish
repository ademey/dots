
set -gx EDITOR nvim
set -gx VISUAL nvim

if status is-interactive
  alias zgit='lazygit'
  #alias cat='bat'

  alias ls='eza --all --icons --git --group-directories-first'
  alias ll='eza --all --long --icons --git --group-directories-first --show-symlinks'
  alias lt='eza --tree --level=2'
  #alias repos="/home/anne/bin/repos.sh ~/dotfiles/ ~/Notes/ ~/.password-store/ ~/Dev/portal/"

  function fish_greeting
    set_color (random choice yellow red blue green cyan magenta);
    #echo "><_>"
    /bin/cat (random choice ~/dots/ascii/fish/**.ascii)
  end

  function authov
    set CTA_KEY (pass api/cta | head -n 1)
  end

  function authbus
    set BUS_KEY (pass api/bus | head -n 1)
  end
  # Commands to run in interactive sessions can go here
  #starship init fish | source
  #zoxide init fish | source
  cat ~/.cache/wal/sequences
end

# Created by `pipx` on 2025-01-10 17:33:30
set PATH $PATH /home/anne/.local/bin
