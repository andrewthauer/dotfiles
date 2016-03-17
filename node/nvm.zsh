# setup nvm (node version manager)
if [[ -d "${HOME}/.nvm" ]]; then
  # source nvm
  export NVM_DIR=~/.nvm
  source $(brew --prefix nvm)/nvm.sh

  # Autoload node version when changing directories
  autoload -U add-zsh-hook
  load-nvmrc() {
    if [[ -f .nvmrc && -r .nvmrc ]]; then
      nvm use
    fi
  }
  add-zsh-hook chpwd load-nvmrc
fi
