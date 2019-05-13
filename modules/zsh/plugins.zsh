#
# Zsh Plugins
#

# Plugin completions
fpath=("${DOTFILES_REPOS_DIR}/zsh-users/zsh-completions" $fpath)

# Zsh users plugins
source "${DOTFILES_REPOS_DIR}/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "${DOTFILES_REPOS_DIR}/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
