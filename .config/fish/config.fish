set fish_greeting
set -gx EDITOR nvim
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
# oh-my-posh init fish --config ~/.config/oh-my-posh/themes/custom.omp.json | source

starship init fish | source

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

# fastfetch
kotofetch --border false
set -Ux XCURSOR_SIZE 16

# ========== FILE FINDER (FZF) ==========
# Fuzzy finder function
function ff
    set search_dir (test -n "$argv[1]"; and echo "$argv[1]"; or echo ".")

    # File extensions that should open in Neovim
    set code_extensions txt md markdown rst c cpp cc cxx h hpp hxx js jsx ts tsx json jsonc py pyx pyi rb go rs java php html htm css scss sass less xml yaml yml toml ini conf config sh bash zsh fish vim lua sql r R pl pm swift kt scala clj hs elm ex exs erl f90 f95 f03 tex bib org dockerfile makefile log csv tsv proto graphql svelte vue dart nim zig crystal jl

    # Use fzf to select file/directory
    set selected (find $search_dir -type f -o -type d 2>/dev/null | \
        fzf --height=40% \
            --layout=reverse \
            --border \
            --preview='if test -d {}; ls -la {}; else if test -f {}; head -50 {}; end; end' \
            --preview-window=right:50%:wrap \
            --header="Enter: open, Tab: toggle preview" \
            --bind="tab:toggle-preview")

    # Exit if nothing selected
    if test -z "$selected"
        return 0
    end

    # Handle the selection
    if test -d "$selected"
        # It's a directory - navigate to it
        cd "$selected" && pwd
    else if test -f "$selected"
        # It's a file - check if it should open in Neovim
        set ext (string split -r -m1 . "$selected")[2]
        set basename_file (basename "$selected")

        # Check if extension is in code_extensions or it's a common text file without extension
        if contains (string lower "$ext") $code_extensions; or test -z "$ext" -a (echo "Makefile Dockerfile Rakefile Gemfile Procfile LICENSE README CHANGELOG TODO INSTALL" | grep -q "$basename_file")
            nvim "$selected"
        else if test -z "$ext"
            # Files without extension - check if they're text files
            if file "$selected" 2>/dev/null | grep -q text
                nvim "$selected"
            else
                xdg-open "$selected" 2>/dev/null &
            end
        else
            # Use xdg-open for other files (images, PDFs, etc.)
            xdg-open "$selected" 2>/dev/null &
        end
    else
        echo "Error: Selected item doesn't exist or is not a regular file/directory"
        return 1
    end
end

# File finder aliases
alias f='ff'
alias finder='ff'

# Bind to Ctrl+T for quick access
bind \cf 'ff; commandline -f repaint'

# ========== DIRECTORY NAVIGATION (ZOXIDE) ==========
# Initialize zoxide but don't let it override cd
zoxide init --cmd j fish | source

# Override cd with smart zoxide integration
function cd
    set argc (count $argv)

    # Handle no arguments - go to home
    if test $argc -eq 0
        builtin cd ~
        zoxide add (pwd)
        return
    end

    # Handle special cases
    switch $argv[1]
        case - "~" "." ".."
            builtin cd $argv
            and zoxide add (pwd)
            return
        case "/*"
            # Absolute path - use normal cd
            builtin cd $argv
            and zoxide add (pwd)
            return
    end

    # Check if it's a relative path that exists
    if test -d "$argv[1]"
        builtin cd $argv
        and zoxide add (pwd)
        return
    end

    # Not a valid directory - try zoxide
    set matches (zoxide query -l -- $argv 2>/dev/null)

    if test (count $matches) -eq 0
        # No zoxide matches - try normal cd (will show error if invalid)
        builtin cd $argv
        and zoxide add (pwd)
    else if test (count $matches) -eq 1
        # Single match - go there
        builtin cd "$matches[1]"
        and zoxide add (pwd)
    else
        # Multiple matches - show picker
        echo "Multiple directories found:"
        set selected (printf '%s\n' $matches | fzf \
            --height=40% \
            --layout=reverse \
            --border \
            --header="Multiple matches for '$argv' - select one:" \
            --preview='ls -la {}' \
            --preview-window=right:50%:wrap)

        if test -n "$selected"
            builtin cd "$selected"
            and zoxide add (pwd)
        else
            echo "No directory selected"
            return 1
        end
    end
end

# Enhanced zi function (interactive zoxide)
function zi
    set selected (zoxide query -l | fzf \
        --height=40% \
        --layout=reverse \
        --border \
        --header="Select directory:" \
        --preview='ls -la {}' \
        --preview-window=right:50%:wrap \
        --query="$argv")

    if test -n "$selected"
        cd "$selected"
    end
end

# Function to add current directory to zoxide and show confirmation
function za
    zoxide add (pwd)
    echo "Added (pwd) to zoxide database"
end

# Function to remove directory from zoxide
function zr
    if test (count $argv) -eq 0
        # Remove current directory
        zoxide remove (pwd)
        echo "Removed (pwd) from zoxide database"
    else
        # Remove specified directory
        set matches (zoxide query -l -- $argv)
        if test (count $matches) -eq 1
            zoxide remove "$matches[1]"
            echo "Removed $matches[1] from zoxide database"
        else if test (count $matches) -gt 1
            set selected (printf '%s\n' $matches | fzf \
                --height=40% \
                --layout=reverse \
                --border \
                --header="Select directory to remove:")
            if test -n "$selected"
                zoxide remove "$selected"
                echo "Removed $selected from zoxide database"
            end
        else
            echo "zoxide: no match found"
        end
    end
end

# Function to edit zoxide database (show all entries with scores)
function ze
    zoxide query -l -s | fzf \
        --height=60% \
        --layout=reverse \
        --border \
        --header="Zoxide database (score | path) - Enter to jump, Ctrl-D to delete" \
        --preview='ls -la {2}' \
        --preview-window=right:50%:wrap \
        --bind="ctrl-d:execute(zoxide remove {2})+reload(zoxide query -l -s)" \
        --with-nth=2.. \
        --delimiter=' ' | read -l selected_line

    if test -n "$selected_line"
        set path (echo "$selected_line" | awk '{print $2}')
        cd "$path"
    end
end

# Original cd behavior (bypass zoxide)
function ocd
    builtin cd $argv
end

# Force zoxide search (even if local directory exists)
function zcd
    set matches (zoxide query -l -- $argv 2>/dev/null)

    if test (count $matches) -eq 0
        echo "No matches found in zoxide database"
        return 1
    else if test (count $matches) -eq 1
        builtin cd "$matches[1]"
        and zoxide add (pwd)
    else
        set selected (printf '%s\n' $matches | fzf \
            --height=40% \
            --layout=reverse \
            --border \
            --header="Zoxide matches for '$argv':" \
            --preview='ls -la {}' \
            --preview-window=right:50%:wrap)

        if test -n "$selected"
            builtin cd "$selected"
            and zoxide add (pwd)
        end
    end
end

# Zoxide aliases  
alias z='cd' # If you want z to behave like cd
alias jump='zi' # Interactive jump
alias zls='zoxide query -l' # List all directories in zoxide

#fish default cursor 
set fish_cursor_default beam
starship init fish | source

#cursor alias 
alias cursor="/home/rainz/Applications/Cursor.AppImage"
