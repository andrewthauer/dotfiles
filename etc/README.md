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

## Git

This package contains a base `gitconfig`, `gitignore` along with various useful
aliases.

### Setup

A `local/.config/git/credentials` file will include your git credentials:

```ini
[user]
  name = Your Name
  email = your@email.com

# macOS specific
[credential]
	helper = osxkeychain
```

You can also add a `local/.config/git/config.local` file to override any
settings or provide directory specific settings. For example:

```ini
# local/.config/git/config.local

# Custom local global core config
[core]
  editor = nvim

# Custom directory specific gitconfig
[includeIf "gitdir:/path/to/project"]
  path = /path/to/project/.gitconfig
```

Then create the custom directory specific gitconfig file:

```ini
# /path/to/project/.gitconfig

# Override global user config
[user]
  name = My Name
  email = email@organization.org

# Override global core config
[core]
  # Custom exclude file (optional)
  excludesfile = /path/to/project/.gitignore
```

See [gitconfig](.config/git/config) & [git.sh](.config/shell.d/git.sh).

## SSH

Use the `ssh-key-gen` command to create an `ssh` key in a single step. The
`ssh-config-merge` command can merge multiple `ssh` configuration files together
(`config.base`, `config.personal`, `config.work`, etc.). For more details
[see the command](./bin/ssh-config-merge).

```shell
# This will create an `id_rsa` key in the `~/.ssh` directory
SSH_KEY_NAME="id_rsa" sh <(curl -fsS 'https://raw.githubusercontent.com/andrewthauer/dotfiles/master/bin/ssh-key-gen')
```

Optionally
[add the SSH Key to your GitHub account](https://help.github.com/articles/generating-ssh-keys/#step-4-add-your-ssh-key-to-your-account)

### Custom SSH Configuration

You can add additional `ssh` config settings to the `~/.ssh/config.d` directory
(e.g.`personal`or`work`). These are normally located in `local/.ssh/config.d`
and then symlinked to the `config.d` directory. Once this is done you can use
the `ssh-config-merge` script to merge those files into the final
`~/.ssh/config` file.

### Resources

- [macOS Sierra doesn’t seem to remember SSH keys between reboots](https://apple.stackexchange.com/questions/254468/macos-sierra-doesn-t-seem-to-remember-ssh-keys-between-reboots)

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
