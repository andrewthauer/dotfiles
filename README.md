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

* [zsh](https://github.com/zsh-users/zsh)
* [zplug](https://github.com/zplug/zplug)
* [homebrew](https://github.com/homebrew/homebrew) (macOS)
* [zsh-users](https://github.com/zsh-users) (some modules)

## Setup

### Create SSH Key

The setup instructions assume using `git` with `ssh`:

```sh
# This will create an `id_rsa` key in the `~/.ssh` directory
SSH_KEY_NAME="id_rsa" sh <(curl -fsS 'https://raw.githubusercontent.com/andrewthauer/dotfiles/master/bin/ssh-key-gen')
```

[Add the SSH Key to your GitHub account](https://help.github.com/articles/generating-ssh-keys/#step-4-add-your-ssh-key-to-your-account).

### Dotfiles Setup

Change zsh to the default shell:

```sh
chsh -s $(which zsh)
```

Setup the dotfiles repo:

```sh
git clone git@github.com:andrewthauer/dotfiles.git
cd dotfiles
./bin/dotfiles setup
```

Restart your shell

### System Specific

* [macOS](system/macos/README.md)
* [Linux](system/linux/README.md)
* [Windows Bash](system/windows/README.md)

## Commands

```sh
# Display available dotfiles commands
dotfiles help
```

## Structure

The following directories are used to organize the dotfiles.

- `bin` - Contains various scripts (added to `$PATH`)
- `config` - Contains all configuration files
- `modules` - Contains various topic based modules
- `local` - Used for local environment customizations
- `system` - Used for OS specific settings & scripts

### `config`

The `config` directory contains common configuration files & directories which may be symlinked to the `~` home directory.

These files following files can be used to customize:

- `.symlinks` file is used to control which files are symlinked when running `dotfiles symlink`. If this file does not exist it will fallback to the - `.symlinks.default` file. Each line represents a file to be symlinked using `:` as a delimeter (e.g `./src/file:~/dest/file`)

### `modules`

Modules are based on topics grouped into a specific directory (i.e. zsh, git, etc.). The following conventions are used:

- `_init.zsh` - Used to initialize the module
- `aliases.zsh` - Contains various aliases
- `bin` - Contains executable commands (may be added to `$PATH`)
- `functions` - Contains functions that can be sourced
- `modules` - Contains additional submodules

### `local`

The `local` directory (git ignored) can be used to customize the dotfiles for a particular environment. It is also a good place to store an secret information (i.e. in `local/secrets`). Files located here can be symlinked to the $HOME directory either manually or via the `.symlinks` file and then running `dotfiles symlink`.

The following are part of the standard setup:

- `local/.zshenv.local` - Customize the zsh environment (sourced by `zsh/.zshenv`)
- `local/.zshrc.local` - Customize the zsh (sourced by `zsh/.zshrc`)
- `local/.gitconfig` - This should contain any local git settings (i.e. user/email)

#### `zplug`

- `local/zplug/zplug.zsh` - Load custom zsh plugins (sourced by `zsh/zplug.zsh`)

#### `.gitconfig`

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
path = ~/.dotfiles/local/.gitconfig-personal
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
