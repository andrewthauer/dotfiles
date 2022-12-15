# Git

This package contains a base `gitconfig`, `gitignore` along with various useful
aliases for [git](https://git-scm.com).

## Setup

```bash
stow git
```

## Configuration

A `local/.config/git/credentials` file will include your git credentials:

```ini
[user]
  name = Your Name
  email = your@email.com

# macOS specific
[credential]
	helper = osxkeychain
```

You can also add a `local/.config/git/config.local` file to override any
settings or provide directory specific settings. For example:

```ini
# local/.config/git/config.local

# Custom local global core config
[core]
  editor = nvim

# Custom directory specific gitconfig
[includeIf "gitdir:/path/to/project"]
  path = /path/to/project/.gitconfig
```

Then create the custom directory specific gitconfig file:

```ini
# /path/to/project/.gitconfig

# Override global user config
[user]
  name = My Name
  email = email@organization.org

# Override global core config
[core]
  # Custom exclude file (optional)
  excludesfile = /path/to/project/.gitignore
```

See [gitconfig](.config/git/config) & [git.sh](.config/shell.d/git.sh).

### GitHub Credential Helpers

```ini
# Add to local/.config/git/config.local

[credential "https://github.com"]
	helper =
	helper = !/opt/homebrew/bin/gh auth git-credential

[credential "https://gist.github.com"]
	helper =
	helper = !/opt/homebrew/bin/gh auth git-credential
```

## Resources

- https://git-scm.com
