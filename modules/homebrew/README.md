# Homebrew & Linuxbrew

This package initializes [homebrew](https://brew.sh).

## Setup

Run `brew bundle` to install all the packages in the `Brewfile`.

You can also create a `$XDG_CONFIG_HOME/homebrew/Brewfile.local` in order to
install machine specific packages. This file will be symlinked to
`$XDG_CONFIG_HOME/homebrew` when running `stow local`.

## Resources

- https://brew.sh
- https://docs.brew.sh/Homebrew-on-Linux
- https://github.com/Homebrew/homebrew-core
