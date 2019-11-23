# Java

This package initializes the `java` environment.

## Setup

```sh
# Copy default maven settings
cp -n $DOTFILES_DIR/java/.config/maven/settings.example.xml $DOTFILES_DIR/@local/.config/maven/settings.xml

# Link the appropriate files
stow -t ~ -d ${$DOTFILES_DIR} java @local
```

## Resources

- https://github.com/jenv/jenv
- https://sdkman.io
- https://maven.apache.org
- https://gradle.org
- https://github.com/halcyon/asdf-java
