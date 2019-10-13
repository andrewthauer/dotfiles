# Zsh

This package loads the base `zsh` shell setup along with any registered
packages.

## Features

- [Pure](https://github.com/sindresorhus/pure) - Pretty, minimal and fast ZSH
  prompt
- Syntax Highlighting
- etc.

## Overview

The following files will be sourced automatically if they exist. They can be
added to `dotfiles/@local` and then symlinked to `~` by running `stow local`
from the `dotfiles` directory.

Since `zsh` does not directly support the XDG spec. , the `~/.zshenv` file sets
the `ZDOTDIR` environment variable. This will make `zsh` source the subsequent
standard files from `$XDG_CONFIG_HOME/zsh`. You can also add `.local` versions
of each which will be sourced if they exist (e.g.
`$XDG_CONFIG_HOME/zsh/.zshrc.local`).

## Resources

- https://www.zsh.org
- https://github.com/zsh-users
