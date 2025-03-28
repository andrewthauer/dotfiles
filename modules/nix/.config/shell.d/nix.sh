# Exit early if nix is not installed
if ! command_exists "nix"; then
  return 1
fi

# Aliases
alias nix-build="nix-build --no-out-link"
alias nix-indirect-roots='nix-store --gc --print-roots | egrep -v "^(/nix/var|/run/\w+-system|\{memory|/proc)"'
