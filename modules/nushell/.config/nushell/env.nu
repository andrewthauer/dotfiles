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
source ($nu.default-config-dir | path join 'scripts/dotenv.nu')

# Load environment variables from files
glob ~/.config/environment.d/*.conf
    | each { |f| open $f }
    | from env --expand
    | load-env

#
# Setup path
#

source ($nu.default-config-dir | path join 'scripts/path.nu')

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
use std "path add"
prepand_path /usr/local/sbin
prepand_path /usr/local/bin
prepand_path /opt/homebrew/bin
if ($env.KREW_ROOT? | is-not-empty) {
    prepand_path ($env.KREW_ROOT | path join "bin")
}
prepand_path ($env.HOME | path join ".local" "bin")
prepand_path ($env.DOTFILES_HOME | path join "bin")
$env.PATH = ($env.PATH | uniq)
