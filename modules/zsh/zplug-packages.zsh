#
# Zplug plugins
#

# zsh-user plugins
zplug "zsh-users/zsh-history-substring-search", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions", defer:0

# completions
# zplug "lukechilds/zsh-better-npm-completion", defer:2
# zplug "docker/cli", use:contrib/completion/zsh, defer:2
# zplug "docker/compose", use:contrib/completion/zsh, defer:2

# zsh theme (async for zsh used by pure)
zplug "mafredri/zsh-async", defer:0
zplug "sindresorhus/pure", use:pure.zsh, as:theme, defer:3

# Load local plugins
if [[ -f "${ZPLUG_LOADFILE_LOCAL}" ]]; then
  source "${ZPLUG_LOADFILE_LOCAL}"
fi
