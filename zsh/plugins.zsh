#
# Zsh Plugins
#

# Plugin completions
fpath=("${DOTFILES_REPOS_DIR}/zsh-users/zsh-completions" $fpath)
fpath=("${DOTFILES_REPOS_DIR}/docker/cli/contrib/completion/zsh" $fpath)
fpath=("${DOTFILES_REPOS_DIR}/docker/compose/contrib/completion/zsh" $fpath)

# Zsh users plugins
source "${DOTFILES_REPOS_DIR}/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "${DOTFILES_REPOS_DIR}/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Other plugins
source "${DOTFILES_REPOS_DIR}/lukechilds/zsh-better-npm-completion/zsh-better-npm-completion.plugin.zsh"
