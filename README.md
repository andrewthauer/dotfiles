# Dotfiles

```
     _       _    __ _ _
  __| | ___ | |_ / _(_) | ___  ___
 / _` |/ _ \| __| |_| | |/ _ \/ __|
| (_| | (_) | |_|  _| | |  __/\__ \
 \__,_|\___/ \__|_| |_|_|\___||___/
```

> These are my dotfiles ...

## Overview

This is my system configuration files, settings, etc.

Here's a list of things that are used:

- [zsh](https://github.com/zsh-users/zsh)
- [homebrew](https://github.com/homebrew/homebrew)
- [zsh-users](https://github.com/zsh-users) (some modules)

## Setup

### Pre-requisites

- git
- make

### TL;DR;

For a partially setup machine you can:

```shell
git clone git@github.com:andrewthauer/dotfiles.git
cd dotfiles
make
# ... restart your shell
```

### System Specific

For brand new systems:

- [macOS](modules/macos/README.md)
- [Linux](modules/linux/README.md)
- [Windows Bash](modules/windows/README.md)

## Commands

```sh
dotfiles help
```

## Structure

The dotfiles are mostly organized by topics. The following directories do not
follow the specific topic organization:

- `bin` - Contains various scripts (added to `$PATH`)
- `modules` - Contains modules & plugins
- `local` (git ignored) - Used for local environment customizations
- `repos` (git ignored) - External dependencies (downloaded)
- `zfunc` (git ignored) - Added to zsh's `fpath`

## Configuration

Most common configuration is handled by symlinking files to the users `$HOME`
home directory. This is handled by `Make` files. Local system configs & secrets
should be added to the `local` directory and never committed.

### Symlinking

Configuration files are symlinked with the `bin/symlink` script which does
some special handling for directories and relative paths. This script is used
in the `modules/Makefile` for any stock settings.

## Customization

The `local` directory (git ignored) can be used to customize the dotfiles for
a particular environment. It is also a good place to store an secret information
(e.g. in `local/secrets`). Custom files can be [symlinked](#symlinking) as
required. [See here](local/README.md) for an example.

The following sections describe various common customizations:

### Zsh

These files can be used to customize a `zsh` shell for a particular machine:

- `local/zsh/.zprofile` - Customize the zsh login (sourced by `modules/zsh/.zprofile`)
- `local/zsh/.zshrc` - Customize the interactive zsh shell (sourced by `modules/zsh/.zshrc`)

### Homebrew

You can create a `~/.Brewfile.local` file to add system specific brew packages
view `brew bundle`.

- `local/homebrew/Brewfile` - Custom brew bundle (called by `modules/homebrew/Brewfile`)

### SSH

The `ssh-config-merge` command allows seperate SSH configuration files to be
merged. For more details [see the command](./bin/ssh-config-merge).

### Git

You can also define local `.gitconfig` files based on specific paths:

```ini
# ~/.dotfiles/local/git/.gitconfig-personal
[user]
  name = Your Name
  email = your@email.com
```

```ini
# ~/.dotfiles/local/git/.gitconfig
[includeIf "gitdir:~/Code/personal"]
path = ~/.dotfiles/local/git/.gitconfig-personal
```

## Reference

- [dotfiles.github.io](https://dotfiles.github.io/)
- [awesome-zsh-plugins](https://github.com/unixorn/awesome-zsh-plugins)
- [Master Your Z Shell with These Outrageously Useful Tips](http://reasoniamhere.com/2014/01/11/outrageously-useful-tips-to-master-your-z-shell/)

## Inspiration

- [b4b4r07](https://github.com/b4b4r07)
- [holman](https://github.com/holman/dotfiles)
- [matiasbynens](https://github.com/mathiasbynens/dotfiles)
- [sorin-ionescu](https://github.com/sorin-ionescu/dotfiles)
- [ijcd](https://github.com/ijcd/dotfiles)
- [prezto](https://github.com/sorin-ionescu/prezto) (some modules)
- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) (some modules)
