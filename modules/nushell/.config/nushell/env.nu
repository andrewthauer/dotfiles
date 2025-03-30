#
# Nushell Environment Config File
#

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

#
# Load environment variables
#

# TODO: Only update if not already set
$env.DOTFILES_HOME = $"($env.HOME)/.dotfiles"

# Load helpers
source ($nu.default-config-dir | path join "scripts/shell.nu")

# Load environment variables from files
glob ~/.config/environment.d/*.conf
    | each {|f| open $f }
    | from env --expand
    | load-env

# Parse alias.d files to nushell files to be loaded
glob ~/.config/alias.d/*
    | each {|f| open $f }
    | from aliases
    | save --force ($env.XDG_DATA_HOME | path join "nushell/vendor/autoload/aliases.nu")

#
# Setup path
#

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
use std "path add"

# Load path helpers
source ($nu.default-config-dir | path join "scripts/path.nu")

# Add non-standard paths to PATH
prepand_path /usr/local/sbin
prepand_path /usr/local/bin

# Homebrew on macOS based on what brew shellenv does (TODO: modularize this to the homebrew module)
prepand_path /opt/homebrew/sbin
prepand_path /opt/homebrew/bin
$env.HOMEBREW_PREFIX = "/opt/homebrew"
$env.HOMEBREW_CELLAR = "/opt/homebrew/Cellar"
$env.HOMEBREW_REPOSITORY = "/opt/homebrew"
$env.MANPATH = ($env.MANPATH? | default ":")
if ($env.MANPATH | is-not-empty) {
    $env.MANPATH = $":($env.MANPATH | str replace -r '^:' '')"
};
$env.INFOPATH = ($env.INFOPATH? | default "")
$env.INFOPATH = $"/opt/homebrew/share/info:($env.INFOPATH | default "")"

# Krew k8s plugin manager (TODO: See if we can modularie this to the kubernetes module)
if ($env.KREW_ROOT? | is-not-empty) {
    prepand_path ($env.KREW_ROOT | path join "bin")
}

# Home and dotfiles paths
prepand_path ($env.HOME | path join ".local" "bin")
prepand_path ($env.DOTFILES_HOME | path join "bin")

# Remove duplicates from PATH
$env.PATH = ($env.PATH | uniq)
