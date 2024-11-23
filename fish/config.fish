if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -g fish_greeting
alias xwall="bash ~/newall.sh ~/walls-catppuccin-mocha"
poetry completions fish > ~/.config/fish/completions/poetry.fish
alias reloadnix="sudo nixos-rebuild switch"
alias catnap="/usr/local/bin/catnap"
alias wall="bash ~/wnewall.sh"
alias free="free -m"
alias catp="bat -p"
alias ls="exa --icons"
cat ~/.cache/wal/sequences
cat ~/.cache/wal/sequences yazi
clear
starship init fish | source

# Created by `pipx` on 2024-11-22 16:01:52
set PATH $PATH /home/evilae/.local/bin
