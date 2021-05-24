# Stow

This package contains configurations for
[GNU Stow](https://www.gnu.org/software/stow/). The `.stow-global-ignore`
contains various common patterns to ignore when symlinking dotfiles to `~`.

**NOTE: This package is a pre-requisite for installing other packages.**

## Setup

```bash
stow -t ~ -S stow
```

## Resources

- https://www.gnu.org/software/stow
