# Maven

This package initializes the `maven` environment.

## Setup

### Enable XDG cache

Create a `settings.xml` file in the `~/.config/maven` directory.

```xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                      https://maven.apache.org/xsd/settings-1.0.0.xsd">
  <localRepository>${env.XDG_CACHE_HOME}/maven/repository</localRepository>
  ...
</settings>
```

Then link the `~/.m2/setting.xml` directory to the
`~/.config/maven/settings.xml` file.

## Resources

- https://maven.apache.org
