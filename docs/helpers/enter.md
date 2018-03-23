enter helper
------------

Enter helper script is here to ease our life when we want to enter or run arbitrary script on a **running** instance of
container. It's basically a wrapper for `docker-compose exec` script.

Enter script syntax looks like:
```bash
docker/enter [<options>] <environment>:<service> [sh|bash] [<command> [<args...>]]
```
- `[<options>]` - options that you can send to docker to change behavior (ie. `--user root` to access container as root 
user), to see full list of available options please use `docker-compose exec -h` and check section **Options**
- `<environment>:<service>` - if you want to access **php** service of **dev** environment you would use `dev:php`
- `[sh|bash]` - in what shell you will be logged in when you go to interactive tty, `sh` shell is default as all
containers have it by default
- `[<command> [<args...>]]` - command that would be run in container

**Note:** There is `:` char separating environment and service name in `<environment>:<service>`.

**Note:** If you do not provide `[<command> [<args...>]]` part of command you will enter in interactive tty.

**Note:** Enter script does not have any additional special (**dokman** specific) options like [run](./run.md) helper have.

Examples:

0) Running `composer install` command on existing instance of **php** service in **dev** environment:
    ```bash
    docker/enter dev:php composer install
    ```
0) Running `apk update` command on existing instance of **apline** service in **dev** environment as **root** user:
    ```bash
    docker/enter --user root dev:alpine apk update
    ```
0) Entering existing instance of **php** service in **prod** environment as **root** user:
    ```bash
    docker/enter --user root prod:php
    ```
0) Pipe output of command run inside docker to file on your local machine (**/tmp/all-routes**)
    ```bash
    docker/enter dev:php bin/console debug:routes > /tmp/all-routes
    ```
    

