# Carapace shell setup for zsh
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'

# Completion options
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'

# shellcheck disable=SC1090
source <(carapace _carapace)
