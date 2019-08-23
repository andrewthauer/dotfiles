#
# Initialize nodejs module
#

_nodenv_init() {
  # initialize nodenv
  eval "$(nodenv init - --no-rehash)"
  _load_npm_completions
  unset -f "$0"
}

_nodenv_lazy_init() {
  triggers=(nodenv node npm npx yarn)
  for cmd in "${triggers[@]}"; do
    eval "${cmd}() { unset -f ${triggers}; _nodenv_init; ${cmd} \$@; }"
  done

  unset -f "$0"
}

_load_npm_completions() {
  # load better npm completions (assumes zsh)
  npm_completions_dir="${DOTFILES_REPOS_DIR}/lukechilds/zsh-better-npm-completion"
  if [[ "${ZSH_NAME}" == "zsh" && -s "${npm_completions_dir}" ]]; then
    source "${npm_completions_dir}/zsh-better-npm-completion.plugin.zsh"
  fi
}

# initialize nodenv (lazy)
if command_exists "nodenv"; then
  _nodenv_lazy_init
fi

if command_exists "node"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/node/aliases.sh"
fi
