set fish_greeting
# Check if the shell is interactive
if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Initialize Homebrew (if installed)
if test -f /home/linuxbrew/.linuxbrew/bin/brew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# oh-my-posh init fish --config $HOME/.poshthemes/kushal.omp.json | source
# oh-my-posh init fish --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/tiwahu.omp.json' | source
oh-my-posh init fish --config ~/.config/oh-my-posh/themes/custom.omp.json | source

function ls
    eza --icons --group-directories-first --oneline $argv
end

alias ll='eza --icons --group-directories-first --oneline'

# pnpm
set -gx PNPM_HOME "/home/rainz/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# #fzf
# set -Ux fish_user_paths $HOME/.fzf/bin $fish_user_paths
# source ~/.fzf/shell/key-bindings.fish
# function ff
#     nvim (fzf -m --preview="bat --color=always{}")
# end

set -U fish_user_paths /home/rainz/.local/bin $fish_user_paths
#yazi function 
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

fastfetch
set -Ux XCURSOR_SIZE 16
