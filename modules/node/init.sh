#
# Initialize nodejs module
#

NODE_LAZY_TRIGGERS=(nodenv node npm npx yarn)

_nodenv_init() {
  # cleanup
  unset -f $0
  unset -f ${NODE_LAZY_TRIGGERS[@]}
  unset NODE_LAZY_TRIGGERS

  # expensive operation
  eval "$(nodenv init - --no-rehash)"
  _load_npm_completions
}

_nodenv_lazy_init() {
  triggers=($@)
  for cmd in "${triggers[@]}"; do
    eval "${cmd}() { _nodenv_init; ${cmd} \$@; }"
  done
  unset -f $0
}

_load_npm_completions() {
  # load better npm completions (assumes zsh)
  npm_completions_dir="${DOTFILES_REPOS_DIR}/lukechilds/zsh-better-npm-completion"
  if [[ "${ZSH_NAME}" == "zsh" && -s "${npm_completions_dir}" ]]; then
    source "${npm_completions_dir}/zsh-better-npm-completion.plugin.zsh"
  fi
  unset -f $0
}

# initialize nodenv (lazy)
if command_exists "nodenv"; then
  _nodenv_lazy_init "${NODE_LAZY_TRIGGERS[@]}"
fi

if command_exists "node"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/node/aliases.sh"
fi
