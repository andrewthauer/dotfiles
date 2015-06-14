export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

if [ -z "${NVM_VER}" ]; then
  echo ${fg[yellow]}"Warning - 'NVM_VER' not set"${reset_color}
else
  nvm use $NVM_VER > /dev/null
fi
