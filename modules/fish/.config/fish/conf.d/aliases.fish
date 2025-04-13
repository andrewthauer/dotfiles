# Directory listing
alias l="ls -a"
alias ll="ls -la"

# Source all module aliases
for script in "$XDG_CONFIG_HOME/alias.d"/*.{sh,fish}
  source $script
end
