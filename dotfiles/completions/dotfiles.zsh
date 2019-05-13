#compdef dotfiles

if [[ ! -o interactive ]]; then
  return
fi

_dotfiles() {
  local curcontext=$curcontext state

  if [ "${#words}" -eq 2 ]; then
    local -a commands=($(dotfiles commands))
    _describe 'command' commands
  else
    local -a completions=($(dotfiles completions ${words[2,-2]}))
    _describe 'command' completions
  fi
}

compdef _dotfiles dotfiles
