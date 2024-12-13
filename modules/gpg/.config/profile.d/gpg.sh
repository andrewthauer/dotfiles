#
# GnuPG environment
#

# XDG specification
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# Create the directory if it doesn't exist
if [ ! -d "${GNUPGHOME}" ]; then
  mkdir -p "${GNUPGHOME}"
  chmod 700 "${GNUPGHOME}"
fi

# Ensure git will work with gpg v2
# shellcheck disable=SC2016
GPG_TTY='$(tty)'
export GPG_TTY
