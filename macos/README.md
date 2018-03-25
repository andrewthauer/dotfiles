# macOS

> Setup a new macOS machine.

## Setup

Follow the [README](../readme.md#setup) for general setup.

### macOS Settings

macOS Defaults

```sh
# Optional - Run setup scripts
${DOTFILES_DIR}/macos/setup/defaults.sh
```

HostName, LocalHostName & ComputerName

```sh
${DOTFILES_DIR}/macos/setup/hostname.sh "my-host-name"
```

### Install Homebrew

```sh
${DOTFILES_DIR}/macos/setup/homebrew.sh
```
