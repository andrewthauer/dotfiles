#
# Nushell Environment Config File
#

# TODO: Only update if not already set
$env.DOTFILES_DIR = $"($env.HOME)/.dotfiles"

# Editor
$env.EDITOR = "nvim"
$env.VISUAL = "nvim -b"

# Use nushell functions to define your right and left prompt
# Use starship prompt instead
# $env.PROMPT_COMMAND = { || create_left_prompt }
# $env.PROMPT_COMMAND_RIGHT = { || create_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
# $env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.data-dir | path join 'completions') # default home for nushell completions
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
use std "path add"
path add /usr/local/sbin
path add /usr/local/bin
path add /opt/homebrew/bin
path add ($env.HOME | path join ".local" "bin")
path add ($env.HOME | path join ".dotfiles" "bin")
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')
$env.PATH = ($env.PATH | uniq)

# To load from a custom file you can use:
# source ($nu.default-config-dir | path join 'custom.nu')

#
# Other
#

load-env {
    # 1password
    SSH_AUTH_SOCK: $"($env.HOME)/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    # homebrew
    HOMEBREW_BUNDLE_NO_LOCK: ""
    HOMEBREW_NO_ENV_HINTS: ""
}

# XDG Base Directory Specifications
# TODO: Figure out how to modularize these better
load-env {
    # ansible
    ANSIBLE_CONFIG: $"($env.XDG_CONFIG_HOME)/ansible/ansible.cfg"
    # aws cli
    AWS_SHARED_CREDENTIALS_FILE: $"($env.XDG_CONFIG_HOME)/aws/credentials"
    AWS_CONFIG_FILE: $"($env.XDG_CONFIG_HOME)/aws/config"
    AWS_CLI_HISTORY_FILE: $"($env.XDG_DATA_HOME)/aws/history"
    AWS_CREDENTIALS_FILE: $"($env.XDG_CONFIG_HOME)/aws/credentials"
    AWS_WEB_IDENTITY_TOKEN_FILE: $"($env.XDG_CONFIG_HOME)/aws/token"
    # CocoaPods
    CP_HOME_DIR: $"($env.XDG_DATA_HOME)/cocoapods"
    # Confluent CLI
    HOME_CONFLUENT_PATH: $"($env.XDG_CONFIG_HOME)/confluent"
    # deno
    # export DENO_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/deno"
    DENO_INSTALL_ROOT: $"($env.XDG_DATA_HOME)/deno"
    # docker
    DOCKER_CONFIG: $"($env.XDG_CONFIG_HOME)/docker"
    # Gradle
    GRADLE_USER_HOME: $"($env.XDG_DATA_HOME)/gradle"
    # Go
    # export GOPATH="${XDG_DATA_HOME}/go"
    # export GOMODCACHE="${XDG_CACHE_HOME}/go/mod"
    # helm
    # export HELM_HOME="${XDG_DATA_HOME}/helm"
    # homebrew
    HOMEBREW_BUNDLE_FILE: $"($env.XDG_CONFIG_HOME)/homebrew/Brewfile"
    # kubernetes
    KUBECONFIG: $"($env.XDG_CONFIG_HOME)/kube/config"
    KUBECACHEDIR: $"($env.XDG_CACHE_HOME)/kube"
    # krew
    KREW_ROOT: $"($env.XDG_CONFIG_HOME)/krew"
    # maven
    MAVEN_OPTS: $"-Dmaven.repo.local=\"($env.XDG_DATA_HOME)\"/maven/repository"
    # alias mvn $"mvn -gs \"($env.XDG_CONFIG_HOME)/maven/settings.xml\""
    # nodejs
    NODE_REPL_HISTORY: $"($.env.XDG_DATA_HOME)/node_repl_history"
    NPM_CONFIG_USERCONFIG: $"($env.XDG_CONFIG_HOME)/npm/config"
    # postgres
    # PSQLRC: $"${XDG_CONFIG_HOME}/pg/psqlrc"
    # PSQL_HISTORY: $"($env.XDG_CACHE_HOME)/pg/psql_history"
    # PGPASSFILE: $"($env.XDG_CONFIG_HOME)/pg/pgpass"
    # $"($env.XDG_CONFIG_HOME)/pg/pg_service.conf" | path exists { PGSERVICEFILE: $"($env.XDG_CONFIG_HOME)/pg/pg_service.conf" }
    # python
    # PYTHONSTARTUP: $"($env.XDG_CONFIG_HOME)/python/pythonrc.py"
    # rust
    CARGO_HOME: $"($env.XDG_DATA_HOME)/cargo"
    RUSTUP_HOME: $"($env.XDG_DATA_HOME)/rustup"
    # svn
    # alias svn='svn --config-dir ${XDG_CONFIG_HOME}/subversion'
}

#
# Initialize certain modules
# TODO: Figure out how to modularize these better
#

# starship prompt - https://starship.rs/#nushell
$env.STARSHIP_SHELL = "nu"
mkdir ~/.cache/starship
^starship init nu | save -f ~/.cache/starship/init.nu

# zoxide https://github.com/ajeetdsouza/zoxide
mkdir ~/.cache/zoxide
^zoxide init nushell | save -f ~/.cache/zoxide/init.nu

# mise - https://mise.jdx.dev/installing-mise.html#nushell
^mise activate nu | save -f ~/.cache/mise/activate.nu
