if status is-interactive
  alias zgit='lazygit'
  alias cat='bat'

  alias ls='eza --all --icons --git --group-directories-first'
  alias ll='eza --all --long --icons --git --group-directories-first --show-symlinks'
  alias lt='eza --tree --level=2'

  function fish_greeting
    set_color yellow;
    echo "><_>"
  end

  # Commands to run in interactive sessions can go here
  starship init fish | source
  zoxide init fish | source
end
