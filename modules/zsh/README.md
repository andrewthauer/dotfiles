# Zsh

Configuration for [Zsh](https://www.zsh.org).

Since `zsh` does not directly support the XDG spec. , the `~/.zshenv` file sets
the `ZDOTDIR` environment variable. This will make `zsh` source the subsequent
standard files from `$XDG_CONFIG_HOME/zsh`. You can also add `.local` versions
of each which will be sourced if they exist (e.g.
`$XDG_CONFIG_HOME/zsh/.zshrc.local`).

## Setup

```bash
make
```

## Resources

- https://www.zsh.org
- https://github.com/zsh-users
- https://ohmyz.sh/
- https://github.com/sorin-ionescu/prezto
