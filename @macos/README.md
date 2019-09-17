# macOS

> `macOS` system specific setting & configuration

## Setup

For a fresh system install run:

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/andrewthauer/dotfiles/master/install.sh)"
```

The `macOS` default settings can be configured with:

```shell
./settings/defaults.sh
```

## Keyboard

> Towards a more useful keyboard ⌨️ !

### Features

- Keybindings to position windows
- Automatic configuration reloading
- Using [Karabiner-Elements](https://pqrs.org/osx/karabiner) for kernel level
  key re-mapping
- Using [Hammerspoon](http://www.hammerspoon.org) for macOS automation

### Keyboard Bindings

<kbd>hyper</kbd> == <kbd>⇧ Shift</kbd> <kbd>^ Ctrl</kbd> <kbd>⌥ Option</kbd>
<kbd>⌘ Cmd</kbd>

`Karabiner` maps <kbd>⇪ caps</kbd> to <kbd>hyper</kbd>

<table>
  <tr>
    <td><kbd>hyper</kbd> + <kbd>F</kbd></td>
    <td>Toggle fill screen or resize in center screen</td>
  </tr>
  <tr>
    <td><kbd>hyper</kbd> + <kbd>&leftarrow; left</kbd></td>
    <td>Position/resize window to the left side</td>
  </tr>
  <tr>
    <td><kbd>hyper</kbd> + <kbd>&leftarrow; left</kbd> + <kbd>&uparrow; up</kbd></td>
    <td>Position/resize window to the top left corner</td>
  </tr>
  <tr>
    <td><kbd>hyper</kbd> + <kbd>&leftarrow; left</kbd> + <kbd>&downarrow; down</kbd></td>
    <td>Position/resize window to the bottom left corner</td>
  </tr>
  <tr>
    <td><kbd>hyper</kbd> + <kbd>&rightarrow; right</kbd></td>
    <td>Position/resize window to the right side</td>
  </tr>
  <tr>
    <td><kbd>hyper</kbd> + <kbd>&rightarrow; right</kbd> + <kbd>&uparrow; up</kbd></td>
    <td>Position/resize window to the bottom top corner</td>
  </tr>
  <tr>
    <td><kbd>hyper</kbd> + <kbd>&rightarrow; right</kbd> + <kbd>&downarrow; down</kbd></td>
    <td>Position/resize window to the bottom right corner</td>
  </tr>
  <tr>
    <td><kbd>hyper</kbd> + <kbd>&uparrow; up</kbd> + <kbd>&downarrow; down</kbd></td>
    <td>Resize window to fill height</td>
  </tr>
  <tr>
    <td><kbd>hyper</kbd> + <kbd>[</kbd></td>
    <td>Move window left one screen</td>
  </tr>
  <tr>
    <td><kbd>hyper</kbd> + <kbd>]</kbd></td>
    <td>Move window right one screen</td>
  </tr>
</table>

## Resources

- https://www.hammerspoon.org/docs
- https://pqrs.org/osx/karabiner/complex_modifications/
