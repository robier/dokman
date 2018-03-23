env helper
----------

Env helper script is here to ease our life when we want to interact with **dokman** environment. It's here for up/down 
containers, checking logs, restarting containers... As env script is wrapper around plain `docker-compose` command you
can do any of `docker-compose` commands on it (to see all available commands just run `docker-compose -h`).

Env script syntax looks like:
```bash
docker/env <environment> <command> [<args...>]
```
- `<environment>` - name of environment you want to interact with
- `<command> [<args...>]` - one of `docker-compose` commands and arguments

**Note:** Aside default `docker-compose` commands there are also two **dokman** specific commands (`on` and `off`)

We introduced 2 new commands that are **dokman** specific:
- `on` - it will run `docker-compose up -d --build --no-recreate` + **dokman** `on` [event](../events.md)
- `off` - it will run `docker-compose down` + **dokman** `off` [event](../events.md)

Examples:

0) Start **dev** environment and trigger **dokman** `on` events:
    ```bash
    docker/env dev on
    ```
0) Start **dev** environment and **don't** trigger **dokman** `on` events:
    ```bash
    docker/env dev up -d
    ```
0) Stop **dev** environment and trigger **dokman** `off` events:
    ```bash
    docker/env dev off
    ```
0) Stop **dev** environment and **don't** trigger **dokman** `off` events:
    ```bash
    docker/env dev down
    ```
0) Stop **php** service in **dev** environment:
    ```bash
    docker/env dev stop php
    ```
0) Print out all logs of **nginx** service in dev environment:
    ```bash
    docker/env dev logs nginx
    ```
0) Tail logs of **nginx** service in **prod** environment:
    ```bash
    docker/env prod logs -f prod 
    ```
0) See parsed YAML file of `docker-compose` for **dev** environment:
    ```bash
    docker/env dev config
    ```
0) Restart all services in **prod** environment:
    ```bash
    docker/env prod restart
    ```
0) Restart only **nginx** service in **prod** envirnoment:
    ```bash
    docker/env prod restart nginx
    ```
0) Restart multiple services (**php** and **nginx**) in **dev** envirnoment:
    ```bash
    docker/env dev restart php nginx
    ```

This are just most used use cases, there is much more as those are not all
`docker-compose` commands.

**Note:** Do not use `exec` or `run` commands on `env` helper scripts, as we have
special wrappers for them, ie. [enter helper script](./enter.md) and [run helper script](./run.md).

