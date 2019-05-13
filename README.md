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
- [zplug](https://github.com/zplug/zplug)
- [homebrew](https://github.com/homebrew/homebrew) (macOS)
- [zsh-users](https://github.com/zsh-users) (some modules)

## Setup

### TL;DR;

```shell
git clone git@github.com:andrewthauer/dotfiles.git
cd dotfiles
./bin/dotfiles setup
# ... restart your shell
```

### System Specific

- [macOS](macos/README.md)
- [Linux](linux/README.md)
- [Windows Bash](windows/README.md)

## Commands

```sh
# Display available dotfiles commands
dotfiles help
```

## Structure

The dotfiles are mostly organzied modules by topic folder. The following
directories do not follow the specific topic organization:

- `bin` - Contains various scripts (added to `$PATH`)
- `local` - Used for local environment customizations
- `modules` - Contains modules & plugins
- `shell` - Contains common shell settings & features that work in
  `bash`, `zsh`, etc.

### `local`

The `local` directory (git ignored) can be used to customize the dotfiles for a particular environment. It is also a good place to store an secret information (i.e. in `local/secrets`). Files located here can be symlinked to the \$HOME directory either manually or via the `.symlinks` file and then running `dotfiles symlink`.

The following are part of the standard setup:

- `local/zsh/.zshenv.local` - Customize the zsh environment (sourced by `zsh/.zshenv`)
- `local/zsh/.zshrc.local` - Customize the zsh (sourced by `zsh/.zshrc`)
- `local/git/.gitconfig` - This should contain any local git settings (i.e. user/email)

### `modules`

Modules directories are based on topics grouped into a specific directory
(i.e. zsh, git, etc.). The following conventions are used:

- `init.{sh,zsh}` - Used to initialize the module
- `aliases.{sh,zsh}` - Contains various aliases
- `bin` - Contains executable commands (may be added to `$PATH`)
- `completions` - Contains related zsh completions
- `functions` - Contains functions that can be sourced
- `modules` - Contains additional submodules

## Configuration

Most configuration is handled via symlinks to the users home directory. Non system specific settings are defined in the `config` directory while local system configurations & secrets should be added to the `./local` directory.

### Setting up Symlinks

The `.symlinks` file is used to control which files are symlinked when running `dotfiles symlink`. If this file does not exist it will fallback to the - `.symlinks.default` file. Each line represents a file to be symlinked using `:` as a delimeter (e.g `./src/file:~/dest/file`)

### Zplug

ZSH plugins can be customized via a `local/zsh/zplug-packages.zsh` file.

### Homebrew

You can create a `~/.Brewfile.local` file to add system specific brew packages view `brew bundle`.

### SSH

The `ssh-config-merge` command allows seperate SSH configuration files to be merged. For more
details [see the command](./bin/ssh-config-merge).

### Git

You can also define local `.gitconfig` files based on specific paths:

```conf
# ~/.dotfiles/local/.gitconfig-personal
[user]
  name = Your Name
  email = your@email.com
```

```conf
# ~/.dotfiles/local/.gitconfig
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
