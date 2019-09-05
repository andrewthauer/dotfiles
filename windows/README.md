# Windows

> For usage with `Windows Subsystem for Linux` (i.e. Windows Bash)
>
> _NOTE: WINDOWS SUPPORT IS EXPERIMENTAL_

## Setup

Follow these steps to setup:

- Clone the repo somewhere on a windows partition (i.e. D:\Username\dotfiles).
  This will be available as `/mnt/d/Username/dotfiles` in the bash shell.
- [Install bash for Windows 10](http://www.howtogeek.com/249966/how-to-install-and-use-the-linux-bash-shell-on-windows-10/)
- Change the default bash user from root in a command prompt
  `lxrun /setdefaultuser username` (if applicable)
- Install pre-requisites - `apt-get install git`
- Open the windows bash command prompt
- Cd into a the directory (e.g. `/mnt/d/Username/dotfiles`)
- Run `linux/install.sh`

See [linux readme](../linux/README.md) form more information.
