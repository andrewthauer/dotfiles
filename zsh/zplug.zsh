# zplug "zplug/zplug", hook-build:'zplug --self-manage'

# zsh-nvm plugin
zplug "lukechilds/zsh-nvm"

# Common aliases
zplug "${DOTPATH}/zsh", from:local, use:"<->_*.zsh"

# zsh-user plugins
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# oh-my-zsh plugins
# zplug "plugins/aws", from:oh-my-zsh
# zplug "plugins/bundler", from:oh-my-zsh
# zplug "plugins/docker", from:oh-my-zsh
# zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
# zplug "plugins/git-extras", from:oh-my-zsh
# zplug "plugins/osx", from:oh-my-zsh

# local plugins
zplug "${DOTPATH}/plugins/capistrano", from:local
zplug "${DOTPATH}/plugins/docker", from:local
zplug "${DOTPATH}/plugins/node", from:local
zplug "${DOTPATH}/plugins/rails", from:local
zplug "${DOTPATH}/plugins/ruby", from:local
zplug "${DOTPATH}/plugins/ssh", from:local
# zplug "${DOTPATH}/plugins/zsh-functions", from:local, use:"functions/*", lazy:on

# Load theme file
zplug "dracula/zsh", as:theme
# zplug "robbyrussell/oh-my-zsh", use:"themes/af-magic.zsh-theme", as:theme

# Load any local packages
if [[ -f "${ZPLUG_LOCAL_LOADFILE}" ]]; then
  source "${ZPLUG_LOCAL_LOADFILE}"
fi
