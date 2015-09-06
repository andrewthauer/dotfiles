# setup nvm (node version manager)
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

if [ -z "${NVM_VER}" ]; then
  echo ${fg[yellow]}"Warning - 'NVM_VER' not set -- using 'system'"${reset_color}
else
  nvm use $NVM_VER > /dev/null
fi

# update nvm current node version automatically
function chpwd() {
  if [ -r $PWD/.nvmrc ]; then
    nvm use `cat $PWD/.nvmrc`
  fi
}

# aliases
alias npm-outdated="npm outdated --depth 0 -q"
alias npm-outdated-g="npm outdated -g --depth 0 -q"
