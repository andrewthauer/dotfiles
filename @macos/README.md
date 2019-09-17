# macOS

> Setup a new macOS machine

## Setup

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/andrewthauer/dotfiles/master/macos/install.sh)"
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

## Testing

### Install VirtualBox

https://medium.com/@twister.mr/installing-macos-to-virtualbox-1fcc5cf22801

### Create the image

Go to the app store and download macOS installer

```
mkdir -p ~/Downloads/macos
cd ~/Downloads/macos

hdiutil create -o ~/mojave.cdr -size 6000m -layout SPUD -fs HFS+J
hdiutil attach mojave.cdr.dmg -noverify -mountpoint /Volumes/install_build
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/install_build
mv mojave.cdr.dmg InstallSystem.dmg
hdiutil detach /Volumes/Install\ macOS\ Mojave
hdiutil convert InstallSystem.dmg -format UDTO -o mojave.iso
```

Setup the VirtualBox

```sh
VBoxManage modifyvm "MacOS" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3"
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VBoxManage setextradata "MacOS" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1

# VBoxManage setextradata "macOS" VBoxInternal2/EfiGopMode 4
```

## Resources

- https://www.hammerspoon.org/docs
- https://pqrs.org/osx/karabiner/complex_modifications/
