#
# Git helpers & aliases
#
# Note:
#   On macOS `envsubst` requires gettext:
#     brew install gettext
#     brew link --force gettext
#

alias dotenv="env $(cat .env | tr "\\n" " ") "${@:1}""
alias dotenvsubst="dotenv envsubst < $1"
