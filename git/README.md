# Git

This package contains a base `gitconfig`, `gitignore` along with various useful
aliases.

## Setup

A `@local/.config/git/credentials` file will include your git credentials:

```ini
[user]
  name = Your Name
  email = your@email.com
```

You can also add a `@local/.config/git/config.local` file to override any
settings. For example:

```ini
# for directory specific git overrides:
[includeIf "gitdir:~/Code/personal"]
path = /path/to/another/.gitconfig
```

## Usage

See [gitconfig](.config/git/config) & [git.sh](.shell/git.sh).

## Resources

- https://git-scm.com
