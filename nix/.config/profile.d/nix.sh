#
# Initialize nix environment
#

if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  # shellcheck disable=SC1091
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi
