# zplug "zplug/zplug", hook-build:'zplug --self-manage'

# Local zsh setup
zplug "${DOTFILES_DIR}/zsh", from:local, use:"<->_*.zsh"

# prezto
# zplug "sorin-ionescu/prezto", from:github

# oh-my-zsh
# zplug "robbyrussell/oh-my-zsh", from:github
# zplug "plugins/aws", from:oh-my-zsh
# zplug "plugins/bundler", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
# zplug "plugins/osx", from:oh-my-zsh

# zsh-nvm plugin
zplug "lukechilds/zsh-nvm"

# zsh-user plugins
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# local plugins
zplug "${DOTFILES_DIR}/plugins/capistrano", from:local
zplug "${DOTFILES_DIR}/plugins/docker", from:local
zplug "${DOTFILES_DIR}/plugins/node", from:local
zplug "${DOTFILES_DIR}/plugins/rails", from:local
zplug "${DOTFILES_DIR}/plugins/ruby", from:local
zplug "${DOTFILES_DIR}/plugins/ssh", from:local
# zplug "${DOTFILES_DIR}/plugins/zsh-functions", from:local, use:"functions/*", lazy:on

# zsh theme (async for zsh used by pure)
zplug "mafredri/zsh-async", from:github, defer:0
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

# Load any local packages
if [[ -f "${ZPLUG_LOCAL_LOADFILE}" ]]; then
  source "${ZPLUG_LOCAL_LOADFILE}"
fi
