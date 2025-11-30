# Check for custom dotfiles home
if test -f "$XDG_CONFIG_HOME/dotfiles-home"
    set -gx DOTFILES_HOME $(cat "$XDG_CONFIG_HOME/dotfiles-home")
end

# Setup default dotfiles env vars
if not set -q DOTFILES_HOME
    set -gx DOTFILES_HOME $HOME/.dotfiles
end

# Export all variables from nvironment.d
if test -d "$XDG_CONFIG_HOME/environment.d"
    for file in $XDG_CONFIG_HOME/environment.d/*.conf
        if test -r "$file"
            cat "$file" | while read -l line
                if test -n "$line"; and not string match -qr '^#' -- "$line"
                    set -l parts (string split -m 1 '=' -- "$line")
                    if test (count $parts) -eq 2
                        set -gx $parts[1] $parts[2]
                    end
                end
            end
        end
    end
end

# Source all module aliases
if test -d "$XDG_CONFIG_HOME/alias.d"
    for script in "$XDG_CONFIG_HOME/alias.d"/*.{sh,fish}
        source $script
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting
end
