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
