# macOS

> `macOS` system specific setting & configuration

## Defaults

The `macOS` default settings can be configured with:

```shell
scripts/macos-defaults.sh
```

## Environment Variables & XDG

```sh
# NOTE: If the plist file is already loaded, you need to unload it first

# Load the plist file
launchctl load ~/Library/LaunchAgents/dotfiles.launchctl.env.plist

# Unload the plist file
launchctl unload ~/Library/LaunchAgents/dotfiles.launchctl.env.plist
```

## Homebrew & Linuxbrew

Run [`brew bundle`](https://github.com/Homebrew/homebrew-bundle) to install all
the packages in the `Brewfile`.

You can also create a `Brewfile.local` in `local/.config/homebrew` in order to
install machine specific packages. This file will be symlinked to
`$XDG_CONFIG_HOME/homebrew` when running `stow local`.

### Keyboard Bindings

See [Hammerspoon](../hammerspoon) & [Karabiner-Elements](../karabiner).
