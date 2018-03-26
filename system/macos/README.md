# macOS

> Setup a new macOS machine.

## Setup

Follow the [README](../../readme.md#setup) for general setup.

### macOS Settings

```sh
# macOS default settings
${DOTFILES_DIR}/system/macos/set-defaults.sh

# Set HostName, LocalHostName & ComputerName
${DOTFILES_DIR}/system/macos/set-hostname.sh "my-host-name"
```

### Install Homebrew

```sh
${DOTFILES_DIR}/modules/brew/install.sh
```
