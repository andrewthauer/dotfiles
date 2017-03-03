# Now using zsh-nvm (https://github.com/lukechilds/zsh-nvm)
#
# if [[ -d "${HOME}/.nvm" ]]; then
#   # Load nvm
#   export NVM_DIR="$HOME/.nvm"
#   [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
#
#   # place this after nvm initialization!
#   autoload -U add-zsh-hook
#   load-nvmrc() {
#     local node_version="$(nvm version)"
#     local nvmrc_path="$(nvm_find_nvmrc)"
#
#     if [ -n "$nvmrc_path" ]; then
#       local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
#
#       if [ "$nvmrc_node_version" = "N/A" ]; then
#         nvm install
#       elif [ "$nvmrc_node_version" != "$node_version" ]; then
#         nvm use
#       fi
#     elif [ "$node_version" != "$(nvm version default)" ]; then
#       echo "Reverting to nvm default version"
#       nvm use default
#     fi
#   }
#   add-zsh-hook chpwd load-nvmrc
#   load-nvmrc
#
#   # script to update nvm manual
#   update-nvm() {
#     (
#       cd "$NVM_DIR"
#       git fetch origin
#       git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
#     ) && . "$NVM_DIR/nvm.sh"
#   }
# fi
