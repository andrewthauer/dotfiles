#
# Nushell Config File
#

$env.config = {
    show_banner: false # true or false to enable or disable the welcome banner at startup
    table: {
        mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
    }
}

# TODO: Figure out how to modularize these
use ~/.cache/starship/init.nu
source ~/.cache/zoxide/init.nu
source ~/.cache/mise/activate.nu

# Load dotfiles config
use config *
