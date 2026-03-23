# Docker

This package contains colima docker setup

## Resources

- [Colima](https://github.com/abiosoft/colima)

## Colima Setup

```sh
# Run the base docker setup
$DOTFILES_HOME/modules/docker/install.sh

# startup colima, which will use the docker runtime by default
colima start --runtime docker --cpu 2 --memory 6 --ssh-config=false
```

Or using `containerd` as the runtime:

```sh
pkg install colima
colima start --runtime containerd --ssh-config=false
colima nerdctl install
```
