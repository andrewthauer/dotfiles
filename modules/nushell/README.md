# Nushell

> A new type of shell

## Configuration

```sh
# List default configuration options
config env --default | nu-highlight | lines
config nu --default | nu-highlight | lines
```

## Plugins

https://www.nushell.sh/book/plugins.html

```sh
[ nu_plugin_inc
  nu_plugin_polars
  nu_plugin_gstat
  nu_plugin_formats
  nu_plugin_query
] | each { cargo install $in --locked } | ignore

# Register plugins
plugin add "$(mise where rust)/bin/nu_plugin_formats"
```

## Resources

- https://www.nushell.sh
- https://github.com/nushell/nushell
- https://github.com/nushell/nu_scripts
- https://github.com/nushell/awesome-nu
