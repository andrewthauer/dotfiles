#
# Zplug plugins
#

# zsh-user plugins
zplug "zsh-users/zsh-history-substring-search", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions", defer:0

# local modules
zplug "${DOTFILES_DIR}/modules/dotenv", from:local, use:"*.sh"
zplug "${DOTFILES_DIR}/modules/dotfiles", from:local, use:"init.zsh", defer:1
zplug "${DOTFILES_DIR}/modules/fasd", from:local, use:"init.sh"
zplug "${DOTFILES_DIR}/modules/git", from:local, use:"*.sh"
zplug "${DOTFILES_DIR}/modules/ssh", from:local, use:"init.sh"
zplug "${DOTFILES_DIR}/modules/utility", from:local, use:"init.sh"
zplug "${DOTFILES_DIR}/modules/utility", from:local, use:"bin/*", lazy:true

# language support
zplug "${DOTFILES_DIR}/modules/asdf", from:local, use:"init.sh", defer:0
zplug "${DOTFILES_DIR}/modules/node", from:local, use:"init.sh", defer:1
zplug "${DOTFILES_DIR}/modules/python", from:local, use:"init.sh", defer:1
zplug "${DOTFILES_DIR}/modules/ruby", from:local, use:"init.sh", defer:1

# completions
zplug "lukechilds/zsh-better-npm-completion", defer:2

# docker
zplug "${DOTFILES_DIR}/modules/docker", from:local, use:"*.sh"
zplug "docker/cli", use:contrib/completion/zsh, defer:2
zplug "docker/compose", use:contrib/completion/zsh, defer:2

# macos modules
zplug "${DOTFILES_DIR}/modules/brew", from:local, if:"[[ $OSTYPE == *darwin* ]]", use:"init.sh"
zplug "${DOTFILES_DIR}/modules/macos", from:local, if:"[[ $OSTYPE == *darwin* ]]", use:"init.sh"

# zsh theme (async for zsh used by pure)
zplug "mafredri/zsh-async", defer:0
zplug "sindresorhus/pure", use:pure.zsh, as:theme, defer:3

# Load local plugins
if [[ -f "${ZPLUG_LOADFILE_LOCAL}" ]]; then
  source "${ZPLUG_LOADFILE_LOCAL}"
fi
