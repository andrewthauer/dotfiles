#
# Post completion script
#

# Exit if prefix is not set
if [ -z ${BREW_PREFIX} ]; then
  return 1
fi

# Load zsh prompt syntax highlighting
# - https://github.com/zsh-users/zsh-syntax-highlighting
# - NOTE: Must be loaded before zsh-history-substring-search
if [ -d "${BREW_PREFIX}/share/zsh-syntax-highlighting" ]; then
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
  source "${BREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Load zsh history substring search
# - https://github.com/zsh-users/zsh-history-substring-search
# - NOTE: Must be loaded after zsh-syntax-highlighting
if [ -d "${BREW_PREFIX}/share/zsh-history-substring-search" ]; then
  source "${BREW_PREFIX}/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
fi

# Load zsh auto suggestions
# - https://github.com/zsh-users/zsh-autosuggestions
if [ -d "${BREW_PREFIX}/share/zsh-autosuggestions" ]; then
  source "${BREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
