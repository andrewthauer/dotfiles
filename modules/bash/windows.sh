# If not running interactively (powershell), don't do anything
[ -z "$PS1" ] && return

# Launch zsh (for windows bash)
# NOTE: It may be possible to remove this post windows 10 creators update
if [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/p') ]; then
  exec zsh
fi
