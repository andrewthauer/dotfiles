#
# Initialize nodejs module
#

# initialize nodenv
if [[ -x "$(command -v nodenv)" ]]; then
  eval "$(nodenv init - --no-rehash)"
fi

# load node helpers
if [[ -x "$(command -v node)" ]]; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/node/aliases.sh"

  # load better npm completions (assumes zsh)
  npm_completions_dir="${DOTFILES_REPOS_DIR}/lukechilds/zsh-better-npm-completion"
  if [[ "${ZSH_NAME}" == "zsh" && -s "${npm_completions_dir}" ]]; then
    source "${npm_completions_dir}/zsh-better-npm-completion.plugin.zsh"
  fi
  unset npm_completions_dir
fi
