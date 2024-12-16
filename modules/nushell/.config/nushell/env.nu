#
# Nushell Environment Config File
#

# Use nushell functions to define your right and left prompt
# Use starship prompt instead
# $env.PROMPT_COMMAND = { || create_left_prompt }
# $env.PROMPT_COMMAND_RIGHT = { || create_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
# $env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.data-dir | path join 'completions') # default home for nushell completions
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
use std "path add"
path add /usr/local/sbin
path add /usr/local/bin
path add /opt/homebrew/bin
path add ($env.HOME | path join ".local" "bin")
path add ($env.HOME | path join ".dotfiles" "bin")
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')
$env.PATH = ($env.PATH | uniq)

# TODO: Only update if not already set
$env.DOTFILES_DIR = $"($env.HOME)/.dotfiles"

# Editor
$env.EDITOR = "nvim"
$env.VISUAL = "nvim -b"

# Load helpers
source scripts/env.nu

# Load environment variables from files
glob ~/.config/environment.d/*.conf
    | each { |f| open $f }
    | from-env
    | each { |i| { key: $i.key, value: (expand-var $i.value) } }
    | reduce -f {} { |row, acc| $acc | upsert $row.key $row.value }
    | load-env

# starship prompt - https://starship.rs/#nushell
$env.STARSHIP_SHELL = "nu"
mkdir ~/.cache/starship
^starship init nu | save -f ~/.cache/starship/init.nu

# zoxide https://github.com/ajeetdsouza/zoxide
mkdir ~/.cache/zoxide
^zoxide init nushell | save -f ~/.cache/zoxide/init.nu

# mise - https://mise.jdx.dev/installing-mise.html#nushell
^mise activate nu | save -f ~/.cache/mise/activate.nu

# To load from a custom file you can use:
# source ($nu.default-config-dir | path join 'custom.nu')
