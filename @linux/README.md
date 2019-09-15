# Linux

> Setup a new linux box

## Setup

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/andrewthauer/dotfiles/master/linux/install.sh)"
```

## Testing

The linux install process can be tested with docker:

```shell
cd docker-test
docker-compose run --rm --service-ports ubuntu bash

# Then once in the docker command line
/dotfiles/@linux/install.sh

# ... Follow any prompts as required
```

_NOTE: This is a work in progress_
