#
# Post completion script
#

# Set the share directory to source from
SHARE_DIR="${XDG_DATA_HOME}"
if [ -n "${PROFILE_PREFIX}" ]; then
  SHARE_DIR="${PROFILE_PREFIX}/share"
fi

# Load zsh prompt syntax highlighting
# - https://github.com/zsh-users/zsh-syntax-highlighting
# - NOTE: Must be loaded before zsh-history-substring-search
# if [ -d "${SHARE_DIR}/zsh-syntax-highlighting" ]; then
#   ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
#   source "${SHARE_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# fi

# Load zsh history substring search
# - https://github.com/zsh-users/zsh-history-substring-search
# - NOTE: Must be loaded after zsh-syntax-highlighting
# if [ -d "${SHARE_DIR}/zsh-history-substring-search" ]; then
#   source "${SHARE_DIR}/zsh-history-substring-search/zsh-history-substring-search.zsh"
# fi

# Load zsh auto suggestions
# - https://github.com/zsh-users/zsh-autosuggestions
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#555555,bold,underline"
# if [ -d "${SHARE_DIR}/zsh-autosuggestions" ]; then
#   source "${SHARE_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh"
# fi

# Cleanup
unset SHARE_DIR
