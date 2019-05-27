#
# Zsh Plugins
#

# Add zsh completions to function path
if [[ -f "${DOTFILES_REPOS_DIR}/zsh-users/zsh-completions" ]]; then
  fpath=("${DOTFILES_REPOS_DIR}/zsh-users/zsh-completions" $fpath)
fi

# Zsh substring history search
if [[ -f "${DOTFILES_REPOS_DIR}/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh" ]]; then
  source "${DOTFILES_REPOS_DIR}/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh"
fi

# Zsh prompt syntax highlighting
if [[ -f "${DOTFILES_REPOS_DIR}/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "${DOTFILES_REPOS_DIR}/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
