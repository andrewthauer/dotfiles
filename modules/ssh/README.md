# SSH

Configuration for [SSH](https://www.openssh.com/).

## Setup

```bash
stow ssh
```

## Commands

Use the `ssh-key-gen` command to create an `ssh` key in a single step. The
`ssh-config-merge` command can merge multiple `ssh` configuration files together
(`config.base`, `config.personal`, `config.work`, etc.). For more details
[see the command](./bin/ssh-config-merge).

```shell
# This will create an `id_rsa` key in the `~/.ssh` directory
SSH_KEY_NAME="id_rsa" sh <(curl -fsS 'https://raw.githubusercontent.com/andrewthauer/dotfiles/main/bin/ssh-key-gen')
```

Optionally
[add the SSH Key to your GitHub account](https://help.github.com/articles/generating-ssh-keys/#step-4-add-your-ssh-key-to-your-account)

### Custom SSH Configuration

You can add additional `ssh` config settings to the `~/.ssh/config.d` directory
(e.g.`personal`or`work`). These are normally located in `local/.ssh/config.d`
and then symlinked to the `config.d` directory. Once this is done you can use
the `ssh-config-merge` script to merge those files into the final
`~/.ssh/config` file.

### SSH on macOS

- [macOS Sierra doesn’t seem to remember SSH keys between reboots](https://apple.stackexchange.com/questions/254468/macos-sierra-doesn-t-seem-to-remember-ssh-keys-between-reboots)

## Resources

- https://www.openssh.com
