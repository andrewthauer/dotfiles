# Dotfiles

> These are my dotfiles 🎉 ...

```
     _       _    __ _ _
  __| | ___ | |_ / _(_) | ___  ___
 / _` |/ _ \| __| |_| | |/ _ \/ __|
| (_| | (_) | |_|  _| | |  __/\__ \
 \__,_|\___/ \__|_| |_|_|\___||___/
```

![license](https://img.shields.io/github/license/andrew/dotfiles?style=flat-square)
![for hackers](https://img.shields.io/badge/built%20for-hackers-50dd7e.svg?logo=dependabot&style=flat-square)
![awesome](https://img.shields.io/badge/pretty-awesome-ffc24b.svg?logo=sourcegraph&style=flat-square)

## Features

- **extremely fast startup!** with lazy loading for expensive operations.
- **limited dependencies** make it very portable.
- **[`stow`](https://www.gnu.org/software/stow/) powered:** symlink dotfiles and
  thus keep them always up-to-date.
- **topical organization** to organize dotfiles by topic for easy reuse across
  different machines.
- **install scripts** for brand new systems and specific topic areas.
- **posix compliant** so it works with most shells (`bash`, `zsh`).
- **optimized for zsh** with auto-completion & syntax highlighting.
- **pure** pretty, fast, minimal command prompt.
- **useful aliases & utilities** for maximum productivity.
- **vim & nvim** work interchangeably.
- **[homebrew](https://brew.sh) compatible** packages with smart fallbacks.

## Pre-requisites

The following packages are required:

- `git`
- `make`
- `stow`

## Installation

```shell
git clone git@github.com:andrewthauer/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make
# now restart your shell ...
```

To install on a brand new system see:

- [macOS](macos/README.md)
- [Linux](linux/README.md)
- [Windows](windows/README.md)

## Configuration

Most common configuration is handled by symlinking files to the users `$HOME`
home directory. This is handled by `stow`. Local system configs & secrets should
be added to the `local` directory and never committed.

### Local Customization

The `local` directory (git ignored) can be used to customize the dotfiles for a
particular environment. It is also a good place to store an secret information
you don't want to commit to source control.

_NOTE: Make sure you create a `local/.stow-local-ignore` file to avoid
symlinking unwanted paths_

### Zsh / Bash

The following files will be sourced automatically if they exist. They can be
added to `dotfiles/local` and then symlinked to `~` by running `stow local` from
the `dotfiles` directory.

- sourced by `zsh`
  - `~/.profile`
  - `~/.zshenv.local`
  - `~/.zprofile.local`
  - `~/.zshrc.local`
  - `~/.zsh/*.zsh`
  - `~/.shell/*.sh`
- sourced by `bash`
  - `~/.profile`
  - `~/.bash_profile.local`
  - `~/.bashrc.local`
  - `~/.bash/*.sh`
  - `~/.shell/*.sh`

### Homebrew

Homebrew makes it easy to install system wide dependencies. There is a
`brew bundle` file that contains commonly used system packages. You can create a
`~/.Brewfile.local` file to install any system specific brews.

### SSH

Use the `ssh-key-gen` command to create an `ssh` key in a single step. The
`ssh-config-merge` command can merge multiple `ssh` configuration files together
(`config.base`, `config.personal`, `config.work`, etc.). For more details
[see the command](./bin/ssh-config-merge).

To create an `ssh` key:

```shell
# This will create an `id_rsa` key in the `~/.ssh` directory
SSH_KEY_NAME="id_rsa" sh <(curl -fsS 'https://raw.githubusercontent.com/andrewthauer/dotfiles/master/bin/ssh-key-gen')
```

_[Add the SSH Key to your GitHub account](https://help.github.com/articles/generating-ssh-keys/#step-4-add-your-ssh-key-to-your-account)_

### Git

A `local/.config/git/credentials` file will include your git credentials:

```ini
[user]
  name = Your Name
  email = your@email.com
```

You can also add a `local/.config/git/config.local` file to override any
settings. For example:

```ini
# for directory specific git overrides:
[includeIf "gitdir:~/Code/personal"]
path = /path/to/another/.gitconfig
```

## Testing

A fresh machine setup can be tested by running `docker-compose` up in the
[linux/test](./linux/test) directory. This will run the linux install script
that is intended to bootstrap a new system. _NOTE: There is currently no `macos`
tests but the overall process is very similar._

## Profiling

It is very important to make sure the shell startup is fast. To help ensure this
there is built-in support for profiling the startup time.

- The `time-zsh` command can be used to profile `zsh` startup time
  - `time-zsh -r` loads `zsh` multiple times to get an average
  - `time-zsh -p` runs `zsh` with the `zprof` module for an execution summary.
    This helps determine areas that are having the largest affect on the startup
    time.
- The `time-bash` command will display the execution time for loading a `bash`
  shell

## Inspiration

- [dotfiles.github.io](https://dotfiles.github.io/)
- [F-dotfiles](https://github.com/Kraymer/F-dotfiles)
- [Cowboy](https://github.com/cowboy/dotfiles)
- [holman](https://github.com/holman/dotfiles)
- [b4b4r07](https://github.com/b4b4r07/dotfiles)
- [matiasbynens](https://github.com/mathiasbynens/dotfiles)
- [sorin-ionescu](https://github.com/sorin-ionescu/dotfiles)
- [prezto](https://github.com/sorin-ionescu/prezto)
- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

## License

MIT © Andrew Thauer
