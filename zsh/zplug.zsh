#
# Zplug plugins
#

# zplug "zplug/zplug", hook-build:'zplug --self-manage'

# Local zsh setup
zplug "${DOTFILES_DIR}/zsh", from:local, use:"_init.zsh": defer:2

# prezto
zplug "sorin-ionescu/prezto", use:"init.zsh": defer:0
zplug "modules/environment", from:prezto
zplug "modules/terminal", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/history", from:prezto
zplug "modules/spectrum", from:prezto
zplug "modules/utility", from:prezto
zplug "modules/completion", from:prezto
zplug "modules/history-substring-search", from:prezto, defer:2

# oh-my-zsh
zplug "plugins/z", from:oh-my-zsh

# zsh-user plugins
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# git
zplug "${DOTFILES_DIR}/git", from:local

# node
zplug "lukechilds/zsh-nvm"
zplug "${DOTFILES_DIR}/node", from:local

# docker
zplug "docker/cli", use:contrib/completion/zsh
zplug "docker/compose", use:contrib/completion/zsh
zplug "${DOTFILES_DIR}/docker", from:local

# local zsh functiosn
zplug "${DOTFILES_DIR}/functions", from:local, use:"*", lazy:on

# local modules
zplug "${DOTFILES_DIR}/brew", from:local
zplug "${DOTFILES_DIR}/dotenv", from:local
zplug "${DOTFILES_DIR}/python", from:local
zplug "${DOTFILES_DIR}/ruby", from:local
zplug "${DOTFILES_DIR}/rust", from:local
zplug "${DOTFILES_DIR}/ssh", from:local

# zsh theme (async for zsh used by pure)
zplug "mafredri/zsh-async", from:github, defer:0
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme, defer:3

# Load any local packages
if [[ -f "${ZPLUG_LOCAL_LOADFILE}" ]]; then
  source "${ZPLUG_LOCAL_LOADFILE}"
fi
