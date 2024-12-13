#
# Setup misc xdg specifications not in other modules
#   https://wiki.archlinux.org/title/XDG_Base_Directory
#

# ansible
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible/ansible.cfg"

# aws cli
# export AWS_CLI_HISTORY_FILE="$XDG_DATA_HOME/aws/history"
# export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
# export AWS_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
# export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
# export AWS_WEB_IDENTITY_TOKEN_FILE="${XDG_CONFIG_HOME}/aws/token"

# CocoaPods
export CP_HOME_DIR="${XDG_DATA_HOME}/cocoapods"

# Confluent CLI
export HOME_CONFLUENT_PATH="${XDG_CONFIG_HOME}/confluent"

# deno
# export DENO_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/deno"
export DENO_INSTALL_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/deno"

# docker
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

# Gradle
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"

# Go
export GOPATH="${XDG_DATA_HOME}/go"
export GOMODCACHE="${XDG_CACHE_HOME}/go/mod"

# gnupg
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# helm (supported since v3.0)
# export HELM_HOME="${XDG_DATA_HOME}/helm"

# homebrew
export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/homebrew/Brewfile"

# kubernetes
export KUBECONFIG="${XDG_CONFIG_HOME}/kube/config"
export KUBECACHEDIR="${XDG_CACHE_HOME}/kube"

# krew
export KREW_ROOT="${XDG_CONFIG_HOME}/krew"

# less (not required after v590)
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"
export LESSKEY="${XDG_CONFIG_HOME}/less/keys"

# maven
export MAVEN_OPTS=-Dmaven.repo.local="${XDG_DATA_HOME}"/maven/repository
alias mvn='mvn -gs "${XDG_CONFIG_HOME}/maven/settings.xml"'

# nodejs
export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"

# npm
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/config"
# in ~/.config/npm/config
#   prefix=${XDG_DATA_HOME}/npm
#   cache=${XDG_CACHE_HOME}/npm
#   init-module=${XDG_CONFIG_HOME}/npm/config/npm-init.js
#   logs-dir=${XDG_STATE_HOME}/npm/logs
# export NPM_CONFIG_DEVDIR="${XDG_CACHE_HOME}/node-gyp"
# export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"

# postgres
# [ ! -d "${XDG_CONFIG_HOME}/pg" ] && mkdir -p "${XDG_CONFIG_HOME}/pg"
# [ ! -d "${XDG_CACHE_HOME}/pg" ] && mkdir "${XDG_CACHE_HOME}/pg"
# export PSQLRC="${XDG_CONFIG_HOME}/pg/psqlrc"
# export PSQL_HISTORY="${XDG_CACHE_HOME}/pg/psql_history"
# export PGPASSFILE="${XDG_CONFIG_HOME}/pg/pgpass"
# if [ -f "${XDG_CONFIG_HOME}/pg/pg_service.conf" ]; then
#   export PGSERVICEFILE="${XDG_CONFIG_HOME}/pg/pg_service.conf"
# fi

# python
# export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc.py"
# export PYTHON_HISTORY="${XDG_STATE_HOME}/python/history"
# export PYTHONUSERBASE="${XDG_DATA_HOME}/python"
# export PYTHONPYCACHEPREFIX="${XDG_CACHE_HOME}/python"

# Poetry
# export POETRY_CONFIG_DIR="${XDG_CONFIG_HOME}/pypoetry"
# export POETRY_DATA_DIR="${XDG_DATA_HOME}/pypoetry"
# export POETRY_CACHE_DIR="${XDG_CACHE_HOME}/pypoetry"

# ruby (supported since v3)
# export IRBRC="${XDG_CONFIG_HOME}/irb/irbrc"
# export GEMRC="${XDG_CONFIG_HOME}/gem/gemrc"
# export GEM_SPEC_CACHE="${XDG_CACHE_HOME}/gem/specs"

# ruby-bundler (supported since ~v2.2.0)
# export BUNDLE_USER_HOME="${XDG_CACHE_HOME}/bundle"
# export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME}/bundle/config"
# export BUNDLE_USER_CACHE="${XDG_CACHE_HOME}/bundle/cache"
# export BUNDLE_USER_PLUGIN="${XDG_DATA_HOME}/bundle/plugin"

# rust
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

# Subversion
alias svn='svn --config-dir ${XDG_CONFIG_HOME}/subversion'

# tmux
alias tmux='tmux -f ${XDG_CONFIG_HOME}/tmux/tmux.conf'

# Wget
export WGETRC="${XDG_CONFIG_HOME}/wgetrc"
alias wget='wget --hsts-file="${XDG_CACHE_HOME}/wget-hsts"'
