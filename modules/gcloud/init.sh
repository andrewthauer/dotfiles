#
# Initialize gcloud module
#

if [[ -x "$(command -v gcloud)" ]]; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/gcloud/aliases.sh"
fi
