# macOS

> Setup a new macOS machine

## Setup

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/andrewthauer/dotfiles/master/macos/install.sh)"
```

### Setup an SSH Key

```shell
# This will create an `id_rsa` key in the `~/.ssh` directory
SSH_KEY_NAME="id_rsa" sh <(curl -fsS 'https://raw.githubusercontent.com/andrewthauer/dotfiles/master/bin/ssh-key-gen')
```

Now
[Add the SSH Key to your GitHub account](https://help.github.com/articles/generating-ssh-keys/#step-4-add-your-ssh-key-to-your-account).
