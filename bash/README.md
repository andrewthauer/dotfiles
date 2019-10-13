# Bash

This package loads the base `bash` shell setup along with any registered
packages.

## Overview

Bash does not support the XDG spec, so the standard files are sourced
(`~/.bash_profile`, `~/.bashrc`). All additional support files are sourced from
`$XDG_CONFIG_HOME/bash`.

## Resources

- https://www.gnu.org/software/bash/
