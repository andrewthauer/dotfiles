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
* [zplug](https://github.com/zplug/zplug)
* [homebrew](https://github.com/homebrew/homebrew) (macOS)
* [zsh-users](https://github.com/zsh-users) (some modules)
* [zsh-nvm](https://github.com/lukechilds/zsh-nvm)
* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) (some modules)

Setup
-----

Setup on macOS:

```bash
# Change your default shell to zsh:
$ chsh -s /bin/zsh

# Clone the repository:
$ git clone https://github.com/andrewthauer/dotfiles ~/.dotfiles

# Run setup (creates dotfile symlinks in $ZDOTDIR, $HOME, etc.)
cd ~/.dotfiles
$ ./bin/dotfiles-setup
```

Structure
---------

Each topic is grouped into a specific directory (i.e. zsh, git, etc.). The following directories are common:

* `bin` - Contains functions (added to `$PATH`)
* `config` - Contains misc configuration files
* `functions` - Contains misc zsh functions
* `local` - Used for local environment customizations
* `secrets` - Store local secrets
* `system` - OS Specific files and setup scripts

Configuration Files
-------------------

Any files with the extension `.symlink` will be symlinked to the $HOME directory. The following are examples of output:

* `~/.zshrc -> ~/.dotfiles/config/zsh/zshrc.symlink`
* `~/.zsrc.local -> ~/.dotfiles/local/zshrc.local.symlink`
* `~/.gitconfig -> ~/.dotfiles/secrets/gitconfig.symlink`
* `~/some-directory/.some-config` ->  `~/.dotfiles/secrets/some-directory/some-config.symlink`
* `~/.some-directory/ -> ~/.dotfiles/secrets/some-directory.symlink/`

### Additional Config Files

The following can be used to sync application settings:

* Atom - [Sync Settings for Atom](https://atom.io/packages/sync-settings) package
* Visual Studio Code - [Visual Studio Code Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync) extension

Customizing
-----------

Make sure you run `./setup` after adding new .symlink files or direcories.

### `local` directory

* `local/zshenv.local.symlink` file to extend `~/.zshenv` with `~/.zshenv.local`
* `local/zshrc.local.symlink` file to extend `~/.zshrc` with `~/.zshrc.local`

Example:

```shell
# ~/.dotfiles/local/zprofile.local.symlink

# do some non secret stuff
# ...

# source the secret profile data
source ${DOTFILES_DIR}/secrets/profile
```

### `secrets` directory

Any file located in the `secrets` directory should not be committed to source control since it contains secret information or is specific to the local environment. Any `.symlink` file will be automatically linked to the home directory when `./setup` is run.

**gitconfig**

The `./secrets/gitconfig` file is included by `./config/dev/gitconfig`. This should contain any user specific git information (i.e. user/email).

Windows Support
---------------

The dotfiles are compatible with `Windows Subsystem for Linux` (i.e. Windows Bash). Follow these steps to setup:

* Clone the repo somewhere on a windows partition (i.e. D:\Username\dotfiles). This will be available as `/mnt/d/Username/dotfiles` in the bash shell.
* [Install bash for Windows 10](http://www.howtogeek.com/249966/how-to-install-and-use-the-linux-bash-shell-on-windows-10/)
* Change the default bash user from root in a command prompt `lxrun /setdefaultuser username` (if applicable)
* Install `zsh` via `apt-get install zsh`
* Open the windows bash command prompt
* Run the setup (i.e. `/mnt/d/Username/dotfiles/setup`)

**Configuration**

*NOTE: This is a work in progress ...*

Various windows configuration settings can be symlinked to the user profile directory (making them more portable). Running the PowerShell script `system/windows/setup.ps1` will run the windows setup routines.

Reference
---------

* [dotfiles.github.io](https://dotfiles.github.io/)
* [awesome-zsh-plugins](https://github.com/unixorn/awesome-zsh-plugins)
* [Master Your Z Shell with These Outrageously Useful Tips](http://reasoniamhere.com/2014/01/11/outrageously-useful-tips-to-master-your-z-shell/)
* [docopt: Command-line interface description language](http://docopt.org/)
* [Handling Command Line Arguments](http://www.shelldorado.com/goodcoding/cmdargs.html)
* [ Command Line Options: How To Parse In Bash Using “getopt”](http://www.bahmanm.com/blogs/command-line-options-how-to-parse-in-bash-using-getopt)

Inspiration
-----------

* [b4b4r07](https://github.com/b4b4r07)
* [matiasbynens](https://github.com/mathiasbynens/dotfiles)
* [sorin-ionescu](https://github.com/sorin-ionescu/dotfiles)
* [ijcd](https://github.com/ijcd/dotfiles)
