# starship prompt - https://starship.rs/#nushell
$env.STARSHIP_SHELL = "nu"
mkdir ~/.cache/starship
^starship init nu | save -f ~/.cache/starship/init.nu
