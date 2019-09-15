# Modules

Various additional module module packages that can be used.

## Setup

Each module can be installed using `stow` just like in the root `dotfiles`
directory. The only difference is that because they are located in a
subdirectory the target `-t` option must be used.

```shell
stow -t ~ docker node redis
```
