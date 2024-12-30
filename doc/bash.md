# Bash

## Snippets

### Command Exists

```sh
# Summary:
#   Check if a command exists
#
# Usage:
#   command-exists "cmd_name"
command_exists() {
  local cmd_name=$1
  [ -z "$cmd_name" ] && return 1
  command -v "$cmd_name" >/dev/null 2>&1
  return $?
}
```

### Function Exists

```sh
# Summary:
#   Check if a function exists
#
# Usage:
#   function-exists "func_name"
function_exists() {
  local function_name=$1
  [ -z "$function_name" ] && return 1
  declare -F "$function_name" >/dev/null 2>&1
  return $?
}
```

### Join By

```sh
# Summary:
#   Joins the args >= 2 by the first arg delimeter
#
# Usage:
#   join_by , a "b c" d #a,b c,d
#   join_by / var local tmp #var/local/tmp
#   join_by , "${FOO[@]}" #a,b,c
join_by() {
  local IFS="$1"
  shift
  echo "$*"
}
```

### Favicon

```sh
#!/usr/bin/env bash
# Summary:
#   Create a favicon
#
# Usage:
#   favicon /path/to/image

file=$1

if [ -z "$file" ]; then
  echo "No source file provided"
  exit 1
fi

if [ ! -x "$(command -v convert)" ]; then
  echo "ImageMagick not installed"
  exit 1
fi
convert "$file" -define icon:auto-resize=64,48,32,16 favicon.ico
```
