# Common Configuration

This directory contains common shell configurations that are potentially
relevant to any system. It is designed to work with both `bash` & `zsh`.

## Stow

This package contains configurations for
[GNU Stow](https://www.gnu.org/software/stow/). The `.stow-global-ignore`
contains various common patterns to ignore when symlinking dotfiles to `~`.

## Bash

Bash does not support the XDG spec, so the standard files are sourced
(`~/.bash_profile`, `~/.bashrc`). All additional support files are sourced from
`$XDG_CONFIG_HOME/bash`.

## Zsh

Since `zsh` does not directly support the XDG spec. , the `~/.zshenv` file sets
the `ZDOTDIR` environment variable. This will make `zsh` source the subsequent
standard files from `$XDG_CONFIG_HOME/zsh`. You can also add `.local` versions
of each which will be sourced if they exist (e.g.
`$XDG_CONFIG_HOME/zsh/.zshrc.local`).

### Features

- [Pure](https://github.com/sindresorhus/pure) - Pretty, minimal and fast ZSH
  prompt
- Syntax Highlighting

## Fasd

[Fasd](https://github.com/clvv/fasd) comes with some useful aliases by default:

```
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
```
