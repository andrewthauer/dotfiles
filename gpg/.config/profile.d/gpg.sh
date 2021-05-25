#
# GnuPG environment
#

# XDG specification
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# Ensure git will work with gpg v2
GPG_TTY="$(tty)"
export GPG_TTY
