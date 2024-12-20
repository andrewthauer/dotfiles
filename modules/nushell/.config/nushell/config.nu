#
# Nushell Config File
#

$env.config = {
    show_banner: false
    table: {
        mode: rounded
    }
}

# Change the shell theme
source ./themes/catppuccin-frappe.nu

# TODO: Figure out how to modularize these
use ~/.cache/starship/init.nu
source ~/.cache/zoxide/init.nu
source ~/.cache/mise/activate.nu

# Source files
source ./init/mod.nu
source ./completions/mod.nu
