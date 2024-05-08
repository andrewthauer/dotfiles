#
# Initialize nix environment
#

# Nix
# if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
#   # shellcheck disable=SC1091
#   . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
# fi
# End Nix

# For home-manager
# if [ -z "$NIX_PATH" ]; then
#   # export NIX_PATH="nixpkgs=/nix/var/nix/profiles/per-user/$USER/channels/nixpkgs:/nix/var/nix/profiles/per-user/$USER/channels"
#   # shellcheck disable=SC1091
#   export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
# fi
