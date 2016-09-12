Dotfiles
========

```
     _       _    __ _ _
  __| | ___ | |_ / _(_) | ___  ___
 / _` |/ _ \| __| |_| | |/ _ \/ __|
| (_| | (_) | |_|  _| | |  __/\__ \
 \__,_|\___/ \__|_| |_|_|\___||___/
```

> These are my dotfiles ...

Overview
--------

This is my system configuration files, settings, etc.

Here's a list of things that are used:

* [zsh](https://github.com/zsh-users/zsh)
* [zgen](https://github.com/tarjoilija/zgen)
* [homebrew](https://github.com/homebrew/homebrew) (macOS)
* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) (some modules)
* [zsh-uses](https://github.com/zsh-users) (some modules)

Setup
-----

```bash
# Change your default shell to zsh:
$ chsh -s /bin/zsh

# Clone the repository:
$ git clone --recursive https://github.com/andrewthauer/dotfiles

# Run setup (create rc symlinks, etc.)
$ ./setup
```

### Symlinks

The `./setup` command symlinks configuration files from various topic directories. For example:

* `~/.zshrc` -> `~/.dotfiles/zsh/zshrc.symlink`
* `~/.gitconfig` -> `~/.dotfiles/secrets/gitconfig.symlink`
* `~/.some-config` -> `~/.dotfiles/secrets/some-config.symlink`
* `~/some-directory/.some-config` -> `~/.dotfiles/secrets/some-directory/some-config.symlink`
* `~/.some-directory/` -> `~/.dotfiles/secrets/some-directory.symlink/`

### Updating

`git pull && git submodule update --init --recursive`

Customizing
-----------

### zshrc.local

Create a `~/.zshrc.local` file to run custom scripts. This could also be added to the secrets directory (i.e. `secrets/zshrc.local.symlink).

```bash
#!/usr/bin/env zsh
# Setup local environment variables
# Setup local aliases
# Source other files
# etc ...
```

### zprofile

The `secrets/zprofile` file is sourced at the start of a new zsh session (if found). It can be used to add environment variables before other files are sourced.

### gitconfig

The `secrets/gitconfig` is included by `git/gitconfig`. This should contain any user specific git information (i.e. user/email).

### Secret Files

Any file located in the `secrets` directory should not be committed to source control since it contains secret information or is specific to the local environment. Any `.symlink` file will be automatically linked to the home directory when `setup` is run.

**Make sure you re-run `./setup` to setup any new symlinks**

*NOTE: See `Configuration Settings` below for more details.*

Functions
---------

There are various common shell functions located in the `./functions` directory. Each topic based directory (i.e git), may also contain a functions directory specific to that topic. These are auto loaded when the shell session is started.

**ssh_config_merge**

This function can be used to merge various ssh configurations files together into `~.ssh/config` (since ssh does not have an include file feature). This can be useful to separate personal and work ssh configurations.

```bash
# Setup desired SSH config files (add to zshrc.local)
SSH_CONFIGS=("$DOTFILES/secrets/ssh.personal.config" "$DOTFILES/secrets/ssh.work.config")

# Merge configs together manually
ssh_config_merge
```

Windows
-------

The dotfiles are compatible with `Windows Subsystem for Linux` (i.e. Windows Bash). Follow these steps to setup:

* Clone the repo somewhere on a windows partition (i.e. D:\Username\dotfiles). This will be available as `/mnt/d/Username/dotfiles` in the bash shell.
* [Install bash for Windows 10](http://www.howtogeek.com/249966/how-to-install-and-use-the-linux-bash-shell-on-windows-10/)
* Change the default bash user from root in a command prompt `lxrun /setdefaultuser username` (if applicable)
* Install `zsh` via `apt-get install zsh`
* Open the windows bash command prompt
* Run the setup (i.e. `/mnt/d/Username/dotfiles/setup`)

### Configuration

*NOTE: This is a work in progress ...*

Various windows configuration settings can be symlinked to the user profile directory (making them more portable). Running the PowerShell script `windows/setup/run.ps1` will run the windows setup routines.

Backups & Syncing
-----------------

Most configuration settings are contained in this repo. This means git is used to version and store the majority of settings that are not secrets.

### Secrets

Anything that is secret or environment specific should go into the `secrets` directory where it exists locally only.

*NOTE: Work in progress*

The `./bin/backup-secrets` script will backup settings to a server, NAS, etc. using env variables defined in the secrets folder (i.e. zshrc.local).

### App Configuration

The following are used to sync application settings:

* Atom - [Sync Settings for Atom](https://atom.io/packages/sync-settings) package
* Visual Studio Code - [Visual Studio Code Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync) extension

Reference
---------

* [dotfiles.github.io](https://dotfiles.github.io/)
* [awesome-zsh-plugins](https://github.com/unixorn/awesome-zsh-plugins)
* [Master Your Z Shell with These Outrageously Useful Tips](http://reasoniamhere.com/2014/01/11/outrageously-useful-tips-to-master-your-z-shell/)
* [docopt: Command-line interface description language](http://docopt.org/)

### Command Line Parsing

* [Handling Command Line Arguments](http://www.shelldorado.com/goodcoding/cmdargs.html)
* [ Command Line Options: How To Parse In Bash Using “getopt”](http://www.bahmanm.com/blogs/command-line-options-how-to-parse-in-bash-using-getopt)

Inspiration
-----------

* [matiasbynens](https://github.com/mathiasbynens/dotfiles)
* [sorin-ionescu](https://github.com/sorin-ionescu/dotfiles)
* [ijcd](https://github.com/ijcd/dotfiles)
