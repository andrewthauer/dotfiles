# Java

This package initializes the `java` environment.

## Setup

```sh
# Link the appropriate files
stow java

# Make an sdk directory to the global macOS default java env
mkdir -p "${XDG_DATA_HOME}/sdk/java"

# Setup a current macOS default java environment
# ... Replace your version location here
ln -s "${XDG_DATA_HOME}/asdf/installs/java/11" "${XDG_DATA_HOME}/sdk/java/current"
```

## Resources

- https://github.com/halcyon/asdf-java
- https://sdkman.io
- https://github.com/jenv/jenv
- https://maven.apache.org
- https://gradle.org
