#
# Initialize Node environment
#

# Initialize nodenv
if [[ -x "$(command -v nodenv)" || -s "${HOME}/.nodenv/bin/nodenv" ]]; then
  export PATH="${HOME}/.nodenv/bin:${PATH}"
  eval "$(nodenv init - --no-rehash)"
fi

# Load node helpers
if [[ -x "$(command -v node)" ]]; then
  # Load aliases
  source "${DOTFILES_MOD_DIR}/node/aliases.sh"

  # Load better npm completions (assumes zsh)
  if [[ -s "${DOTFILES_REPOS_DIR}/lukechilds/zsh-better-npm-completion" ]]; then
    source "${DOTFILES_REPOS_DIR}/lukechilds/zsh-better-npm-completion/zsh-better-npm-completion.plugin.zsh"
  fi
fi
