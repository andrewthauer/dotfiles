#
# Node aliases
#

# npm list
alias npm-list="npm list --depth=0 2>/dev/null"
alias npm-list-g="npm list -g --depth=0 2>/dev/null"

# npm outdated
alias npm-outdated="npm outdated --depth 0 -q"
alias npm-outdated-g="npm outdated -g --depth 0 -q"

# jest
alias jest="npx jest"
alias jestw="npx jest --watch"

# nodenv
if [[ -x "$(command -v nodenv)" ]]; then
  alias nenv="nodenv"
  alias nenv-a="nodenv alias"
  alias nenv-dpi="nodenv default-packages install --all"
fi
