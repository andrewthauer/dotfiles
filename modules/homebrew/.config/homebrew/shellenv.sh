# Initialize Homebrew environment
if [[ "$OSTYPE" == darwin* ]]; then
  if [ -d "/opt/homebrew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  if [ -x "$(command -v brew)" ]; then
    eval "$("$(brew --prefix)"/bin/brew shellenv)"
  elif [ -d "/home/linuxbrew/.linuxbrew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  elif [ -d "$HOME/.linuxbrew" ]; then
    eval "$("$HOME"/.linuxbrew/bin/brew shellenv)"
  fi
fi
