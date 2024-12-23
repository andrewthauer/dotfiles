#
# Nushell Environment Config File
#

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# Load helpers
source ($nu.default-config-dir | path join 'scripts/dotenv.nu')
source ($nu.default-config-dir | path join 'scripts/path.nu')

# Load environment variables from files
glob ~/.config/environment.d/*.conf
    | each { |f| open $f }
    | from env --expand
    | load-env

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
use std "path add"
prepand_path /usr/local/sbin
prepand_path /usr/local/bin
prepand_path /opt/homebrew/bin
prepand_path ($env.KREW_ROOT | path join "bin")
prepand_path ($env.HOME | path join ".local" "bin")
prepand_path ($env.HOME | path join ".dotfiles" "bin")
$env.PATH = ($env.PATH | uniq)

# TODO: Only update if not already set
$env.DOTFILES_DIR = $"($env.HOME)/.dotfiles"
$env.DOTFILES_BIN = $"($env.HOME)/.dotfiles/bin"

# Editor
$env.config.buffer_editor = "vi"
$env.EDITOR = "nvim"
$env.VISUAL = "nvim -b"

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
