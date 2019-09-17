# Test

> Some basic tests for dotfiles ...

## Testing

The install process can be tested with docker:

```shell
docker-compose run --rm --service-ports ubuntu bash

# Then once in the docker command line
/dotfiles/install.sh

# ... Follow any prompts as required
# password is `dotty`
```

_NOTE: This is a work in progress_
