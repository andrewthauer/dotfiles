# Capistrano zsh functions & aliases

# deploy a rails app
cap_deploy () {
  if [[ -z "$1" ]]; then
    echo $fg[yellow]"Missing Environnment"
    echo "\te.g. cap-deploy qa"
    return
  fi

  env=$1
  branch=`current_branch` # function from oh-my-zsh git plugin
  BRANCH=$branch bundle exec cap $env ${@:2}
}

# aliases
alias cap="bundle exec cap"
alias capd=cap_deploy
