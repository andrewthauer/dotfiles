# setup nvm (node version manager)
if [[ -d "${HOME}/.nvm" ]]; then
  # source nvm
  export NVM_DIR=~/.nvm
  source $(brew --prefix nvm)/nvm.sh

  # Default NVM Version
  # export NVM_VER="4.2"

  # use the default version
  # if [ -z "${NVM_VER}" ]; then
  #   echo ${fg[yellow]}"Warning - 'NVM_VER' not set -- using 'system'"${reset_color}
  # else
  #   nvm use $NVM_VER > /dev/null
  # fi

  # update nvm current node version automatically
  function chpwd() {
    if [ -r $PWD/.nvmrc ]; then
      nvm use `cat $PWD/.nvmrc`
    fi
  }
fi
