#
# Nushell Config File
#

$env.config = {
    show_banner: false
    table: {
        mode: rounded
    }
}

# Editor
$env.config.buffer_editor = "vi"
$env.EDITOR = "nvim"
$env.VISUAL = "nvim -b"

# Source files
source ./init/mod.nu
source ./completions/mod.nu

#
# Load modules
# TODO: Figure out how to modularize these
#

use ~/.cache/starship/init.nu
source ~/.cache/zoxide/init.nu
source ~/.cache/mise/activate.nu
