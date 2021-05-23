# Linux

> `Linux` specific system setup & configuration

## Setup

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/andrewthauer/dotfiles/master/install.sh)"
```

## Testing

A fresh machine setup can be tested by running `docker-compose` up in the
[test](./test) directory. This will run the install script that is intended to
bootstrap a new system.
