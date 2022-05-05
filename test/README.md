# Tests

> Some basic tests for dotfiles ...

## Testing

The install process can be manually tested with docker:

```shell
docker-compose run --rm --service-ports ubuntu-base bash

# Then once in the docker command line
cd /dotfiles
install.sh
```

_NOTE: This is a work in progress_
