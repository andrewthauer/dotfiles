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
* [prezto](https://github.com/sorin-ionescu/prezto) (some modules)
* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) (some modules)
* [zsh-users](https://github.com/zsh-users) (some modules)
* [zsh-nvm](https://github.com/lukechilds/zsh-nvm)

Setup
-----

[macOS](macos/README.md)
[Windows Bash](windows/README.md)

Commands
--------

```shell
# Display available dotfiles commands
dotfiles help
```

Structure
---------

Each topic is grouped into a specific directory (i.e. zsh, git, etc.). The following directories are common:

* `bin` - Contains various scripts (added to `$PATH`)
* `functions` - Contains misc zsh functions
* `local` - Used for local environment customizations
* `anothertopic` - A topic (e.g. language or tool)

Configuration Files
-------------------

The `.symlinks` file is used to control which files are symlinked when running `dotfiles symlink`. If this file does not exist it will fallback to the `.symlinks.default` file.

* `~/.zshrc -> ~/.dotfiles/zsh/.zshrc`
* `~/.zsrc.local -> ~/.dotfiles/local/.zshrc.local`
* `~/.gitconfig -> ~/.dotfiles/git/.gitconfig`
* `~/.some-directory/.some-file` ->  `~/.dotfiles/local/.some-directory/.some-file`
* `~/some-directory/some-file` ->  `~/.dotfiles/local/some-directory/some-file`

Customizing
-----------

### `local` directory

The `local` directory (git ignored) can be used to customize the dotfiles for a particular environment. It is also a good place to store an secret information (i.e. in `local/secrets`). Files located here can be symlinked to the $HOME directory either manually or via the `.symlinks` file and then running `dotfiles symlink`.

The following are part of the standard setup:

* `local/.gitconfig` - This should contain any user specific git information (i.e. user/email)
* `local/.zplug.local` - Load custom zsh plugins (sourced by `zsh/zplug.zsh`)
* `local/.zshenv.local` - Customize the zsh environment (sourced by `zsh/.zshenv`)
* `local/.zshrc.local` - Customize the zsh (sourced by `zsh/.zshrc`)

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
