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
settings or provide directory specific settings. For example:

```ini
# @local/.config/git/config.local
[includeIf "gitdir:/path/to/project"]
path = /path/to/project/.gitconfig

# /path/to/project/.gitconfig
[user]
  name = My Name
  email = email@organization.org

[core]
  excludesfile = /path/to/project/.gitignore
```

## Usage

See [gitconfig](.config/git/config) & [git.sh](.config/profile.d/git.sh).

## Resources

- https://git-scm.com
