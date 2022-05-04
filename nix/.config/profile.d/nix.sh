#
# Initialize nix environment
#

# if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
#   # shellcheck disable=SC1091
#   source "$HOME/.nix-profile/etc/profile.d/nix.sh"
# fi

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

if [ -z "$NIX_PATH" ]; then
  # export NIX_PATH="nixpkgs=/nix/var/nix/profiles/per-user/$USER/channels/nixpkgs:/nix/var/nix/profiles/per-user/$USER/channels"
  export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
fi
