#
# Node.js related aliases
#

# Skip if node is not installed
if ! [ -x "$(command -v node)" ]; then
  return
fi

# npm list
alias npm-list="npm list --depth=0 2>/dev/null"
alias npm-list-g="npm list -g --depth=0 2>/dev/null"

# npm outdated
alias npm-outdated="npm outdated --depth 0 -q"
alias npm-outdated-g="npm outdated -g --depth 0 -q"
