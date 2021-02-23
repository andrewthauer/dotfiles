# PostgreSQL

This package initializes the `postgres` environment.

## Setup

```sh
createuser -s postgres
```

## psql

```sh
psql -h [host] -p [port] -U [user] -d [database]
```

### Aliases

- `psql-local` - Connect to localhost database as `postgres` user.

### Commands:

- `\l` - list all databases
- `\c [db]` - connect to a database
- `\d` - list all objects
- `\d+` - list all objects with additional info
- `\du` - list all users
- `\dn` - list all schemas
- `\dt` - list all tables
- `\dt+` - list all tables
- `\d+ [tbl]` - list table info
- `\dv` - list all views
- `\df` - list all functions
- `\df+ [fn]` - list function info
- `\x` - toggle expanded display results
- `\i` - run sql file in relative path
- `\ir` - run sql file at absolute path

## Resources

- https://www.postgresql.org/
- https://www.postgresql.org/docs/current/app-psql.html
- http://www.postgresqltutorial.com/postgresql-cheat-sheet/
