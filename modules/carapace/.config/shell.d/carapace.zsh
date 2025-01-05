#
# Carapace shell setup for zsh
#
# https://carapace-sh.github.io/carapace-bin/setup.html#zsh
#

zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'

# shellcheck disable=SC1090
source <(carapace _carapace)

