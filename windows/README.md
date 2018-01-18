# Windows

> For usage with `Windows Subsystem for Linux` (i.e. Windows Bash)
>
> *NOTE: WINDOWS SUPPORT IS EXPERIMENTAL*

## Dotfiles Setup

Follow these steps to setup:

* Clone the repo somewhere on a windows partition (i.e. D:\Username\dotfiles). This will be available as `/mnt/d/Username/dotfiles` in the bash shell.
* [Install bash for Windows 10](http://www.howtogeek.com/249966/how-to-install-and-use-the-linux-bash-shell-on-windows-10/)
* Change the default bash user from root in a command prompt `lxrun /setdefaultuser username` (if applicable)
* Install `zsh` via `apt-get install zsh`
* Open the windows bash command prompt
* Run the setup (i.e. `/mnt/d/Username/dotfiles/setup`)

### Configuration

*NOTE: This is a work in progress ...*

Various windows configuration settings can be symlinked to the user profile directory (making them more portable). Running the PowerShell script `system/windows/setup.ps1` will run the windows setup routines.
