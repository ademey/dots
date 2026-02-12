
set -gx EDITOR nvim
set -gx VISUAL nvim

if status is-interactive
  alias zgit='lazygit'
  alias cat='bat'

  alias ls='eza --all --icons --git --group-directories-first'
  alias ll='eza --all --long --icons --git --group-directories-first --show-symlinks'
  alias lt='eza --tree --level=2'
  alias repos="/home/anne/bin/repos.sh ~/dotfiles/ ~/Notes/ ~/.password-store/ ~/Dev/portal/"

  function killport
    fuser -k $argv[1]/tcp
  end

  function fish_greeting
    set_color (random choice yellow red blue green cyan magenta);
    #echo "><_>"
    /bin/cat (random choice ~/dotfiles/ascii/fish/**.ascii)
  end

  function authov
    set -gx CTA_KEY (pass api/cta | head -n 1)
  end

  function reactov
    set -gx REACT_APP_CTA_KEY (pass api/cta | head -n 1)
  end

  function authbus
    set -gx BUS_KEY (pass api/bus | head -n 1)
  end
  # Commands to run in interactive sessions can go here
  starship init fish | source
  zoxide init fish | source
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set -gx PATH $HOME/.local/bin $PATH
function fix-wifi
    nmcli connection down REGUS 2>/dev/null; nmcli connection up REGUS
end
