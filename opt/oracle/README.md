# Oracle

This package initializes the `oracle` client environment.

## Setup

To configure sqlplus for remote connections you must:

```sh
HOSTNAME="$(sudo scutil --set HostName)"
sudo /bin/bash -c "echo '127.0.0.1 ${HOSTNAME}' >> /etc/hosts"
```

## Reference

- https://www.oracle.com/
