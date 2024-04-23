#
# Initialize nix environment
#

# Return if requirements not found
if ! command_exists "nix"; then
  return 1
fi

#
# Aliases
#

alias nix-build="nix-build --no-out-link"
alias nix-indirect-roots='nix-store --gc --print-roots | egrep -v "^(/nix/var|/run/\w+-system|\{memory|/proc)"'

#
# Helpers
#

nix-full-clean() {
  nix-channel --update
  nix-env --delete-generations old
  nix-env -u --always
  rm -f /nix/var/nix/gcroots/auto/*
  nix-collect-garbage -d
}

# Use this to fix permissions on /nix
nix-store-fix-permissions() {
  sudo chown -R "$USER":staff /nix
}
