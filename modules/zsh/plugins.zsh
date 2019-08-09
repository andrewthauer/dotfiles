#
# Zsh Plugins
#

REPOS_DIR="${DOTFILES_REPOS_DIR}"

# Add zsh completions to function path
if [[ -f "${REPOS_DIR}/zsh-users/zsh-completions" ]]; then
  fpath=("${REPOS_DIR}/zsh-users/zsh-completions" $fpath)
fi

# Zsh substring history search
if [[ -f "${REPOS_DIR}/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh" ]]; then
  source "${REPOS_DIR}/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh"
fi

# Zsh prompt syntax highlighting
if [[ -f "${REPOS_DIR}/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "${REPOS_DIR}/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
