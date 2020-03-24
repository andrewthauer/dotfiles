#!/usr/bin/env bash
#
# Gnome settings
#

#
# Terminal Settings
#

# This should be "Default"
profile_id=b1dcc9dd-5262-4d8d-a863-c897e6d979b9

# Text & Background
foreground_color="#DEDEDE"
background_color="#191919"
bold_color="#000000"
cursor_foreground_color="#848484"
cursor_background_color="#191919"
highlight_foreground_color="#DEDEDE"
highlight_background_color="#AB937D"

# Palette
ansi_black="#303030"
ansi_red="#FF8080"
ansi_green="#87AE86"
ansi_yellow="#FFFB9D"
ansi_blue="#4080A0"
ansi_magenta="#D68686"
ansi_cyan="#60B38A"
ansi_white="#D6D6D6"
ansi_bright_black="#414141"
ansi_bright_red="#FF5274"
ansi_bright_green="#A0CFA1"
ansi_bright_yellow="#FFFD87"
ansi_bright_blue="#95BFF3"
ansi_bright_magenta="#CC9495"
ansi_bright_cyan="#8CD0D3"
ansi_bright_white="#FFFFFF"
palette="['$ansi_black', '$ansi_red', '$ansi_green', '$ansi_yellow', '$ansi_blue', '$ansi_magenta', '$ansi_cyan', '$ansi_white', '$ansi_bright_black', '$ansi_bright_red', '$ansi_bright_green', '$ansi_bright_yellow', '$ansi_bright_blue', '$ansi_bright_magenta', '$ansi_bright_cyan', '$ansi_bright_white']"

# Write settings
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/audible-bell "false"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/background-color "'$background_color'"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/background-transparency-percent "0"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/bold-color="'$bold_color'"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/bold-color-same-as-fg "false"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/bold-is-bright "false"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/cursor-background-color "'$cursor_background_color'"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/cursor-blink-mode "off"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/cursor-colors-set "false"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/cursor-foreground-color "'$cursor_foreground_color'"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/cursor-shape "'ibeam'"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/font "'Fira Code 11'"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/foreground-color "'$foreground_color'"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/highlight-background-color "'$highlight_background_color'"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/highlight-colors-set "false"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/highlight-foreground-color "'$highlight_foreground_color'"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/palette "$palette"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/scroll-on-output "false"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/use-system-font "false"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/use-theme-colors "false"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/use-transparent-background "false"
dconf write /org/gnome/terminal/legacy/profiles:/:$profile_id/visible-name "'Zenburn'"
