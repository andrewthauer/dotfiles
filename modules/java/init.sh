#
# Initialize java module
#

# initialize jenv
if [[ -x "$(command -v jenv)" ]]; then
  eval "$(jenv init - --no-rehash)"
fi
