run helper
----------

Run helper script is here to ease our life when we want to enter or run arbitrary script on a **non running** instance of
container. It's basically a wrapper for `docker-compose run` script.

Run script syntax looks like:
```bash
docker/run [<options>] <environment>:<service> [sh|bash] [<command> [<args...>]] 
```
- `[<options>]` - options that you can send to docker to change behavior (ie. `--user root` to access container as root 
user), to see full list of available options please use `docker-compose run -h` and check section **Options**
- `<environment>:<service>` - if you want to access **php** service of **dev** environment you would use `dev:php`
- `[sh|bash]` - in what shell you will be logged in when you go to interactive tty, `sh` shell is default as all
containers have it by default
- `[<command> [<args...>]]` - command that would be run in container

**Note:** There is `:` char separating environment and service name in `<environment>:<service>`.

**Note:** If you do not provide `[<command> [<args...>]]` part of command you will enter in interactive tty.

Dokman changes default behavior of `docker-compose run` by turning on flags `--rm` and `--no-deps`(as we do not want to
run linked services and we want to remove container after running in most cases). Those behaviors can easily be
turned off as we introduced 2 new flags `--no-rm` and `--deps` (those flags belongs in `[<options>]` part of command).

Examples:

0) Running `composer install` command on fresh instance of **php** service in **dev** environment:
    ```bash
    docker/run dev:php composer install
    ```
0) Running `apt update` command on fresh instance of **ubuntu** service in **dev** environment as **root** user:
    ```bash
    docker/run --user root dev:mysql apt install
    ```
0) Running `yarn install` command on fresh instance of **node** service in **dev** environment without removing container when it's finished:
    ```bash
    docker/run --no-rm dev:node yarn install
    ```
0) Entering fresh instance of **php** service in **prod** environment as **root** user:
    ```bash
    docker/run --user root prod:php
    ```
0) Entering fresh instance of **nginx** service in **dev** environment as **root** user, in **/tmp** directory:
    ```bash
    docker/run --user root -w /tmp dev:nginx
    ```
0) Entering fresh instance of **php** service in **dev** environment with creation of all linked services:
    ```bash
    docker/run --deps dev:php
    ```
0) Pipe output of command run inside docker to file on your local machine (**/tmp/all-routes**)
    ```bash
    docker/run dev:php bin/console debug:routes > /tmp/all-routes
    ```


