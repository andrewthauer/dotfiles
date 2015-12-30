Dotfiles
========

```
     _       _    __ _ _           
  __| | ___ | |_ / _(_) | ___  ___
 / _` |/ _ \| __| |_| | |/ _ \/ __|
| (_| | (_) | |_|  _| | |  __/\__ \
 \__,_|\___/ \__|_| |_|_|\___||___/
```

These are my dotfiles ...


Overview
--------

Here's a list of things that are used:

* [zsh](https://github.com/zsh-users/zsh)
* [zgen](https://github.com/tarjoilija/zgen)
* [brew](https://github.com/homebrew/homebrew) (OSX)
* [prezto](https://github.com/sorin-ionescu/prezto) (some modules)
* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) (some modules)


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

The `setup` command runs `dotfiles_symlink_dir` on various directories. This will automatically setup a symbolic link for each file with a `.symlink` extension to the user `$HOME` directory. Files will be renamed from `my_rc_file.symlink to `.my_rc_file`. Files inside sub directories will be treated relative to the user home directory.


Customizing
-----------

### zshrc.local

Create a `zsh/zshrc.local` file to run anything for a local environment.

```bash
#!/bin/zsh

# Setup local environment variables
# Setup local aliases
# Source other files
# etc ...
```

### zprofile

The `secrets/zprofile` file is sourced at the start of a new zsh session. It can be used to add environment variables before other files are sourced.

### gitconfig

The `secrets/gitconfig` is included by `git/gitconfig`. This should contain any user specific git information (i.e. user/email).

### Other Secrets

Any file located in the `secrets` directory should not be committed to source control or since it contains secret information or is specific to the local environment. Any `.symlink` file will be automatically linked to the home directory when `setup` is run.

*Make sure you re-run `./setup` to setup any new symlinks*


Updating
--------

`git pull && git submodule update --init --recursive`


Functions
---------

**ssh_config_merge**

This function can be used to merge various ssh configurations files together into `~.ssh/config` (since ssh does not have an include file feature). This can be useful to separate personal and work ssh configurations.

```bash
# Setup desired SSH config files (add to zshrc.local)
SSH_CONFIGS=("$DOTFILES/secrets/ssh.personal.config" "$DOTFILES/secrets/ssh.work.config")

# Merge configs together
ssh_config_merge
```


Reference
---------

* [dotfiles.github.io](https://dotfiles.github.io/)
* [awesome-zsh-plugins](https://github.com/unixorn/awesome-zsh-plugins)
* [Master Your Z Shell with These Outrageously Useful Tips](http://reasoniamhere.com/2014/01/11/outrageously-useful-tips-to-master-your-z-shell/)

### Command Line Parsing

* [Handling Command Line Arguments](http://www.shelldorado.com/goodcoding/cmdargs.html)
* [ Command Line Options: How To Parse In Bash Using “getopt”](http://www.bahmanm.com/blogs/command-line-options-how-to-parse-in-bash-using-getopt)


Inspiration
-----------

* [matiasbynens](https://github.com/mathiasbynens/dotfiles)
* [sorin-ionescu](https://github.com/sorin-ionescu/dotfiles)
* [ijcd](https://github.com/ijcd/dotfiles)
