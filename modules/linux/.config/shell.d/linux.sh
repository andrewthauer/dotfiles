# mimic macos open & clipboard commands on linux
if [[ "$(uname)" == "Linux" ]]; then
  # macOs open everywhere
  alias open='xdg-open'

  # macOS clipboard everywhere
  if [ -x "$(command -v xclip)" ]; then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  elif [ -x "$(command -v xsel)" ]; then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  fi
fi
