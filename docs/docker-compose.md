docker-compose
--------------

For backward compatibility, default is `docker-compose` command. If you want to use `docker compose` plugin you can do that. To use `docker compose`
instead of `docker-compose` you need to create the ENV variable `DOKMAN_DOCKER_COMPOSE_COMMAND` and set it to `docker compose`. 
Default value of that ENV is `docker-compose`.

When having new installation of dokman, if `docker compose` plugin is detected in your system, dokman will use it. By setting the ENV variable
DOKMAN_DOCKER_COMPOSE_COMMAND inside `<project root>/docker/.env.dist` file.

Example:

```text
DOKMAN_DOCKER_COMPOSE_COMMAND="docker compose"
```

That ENV variable can be added to any of:
- `<project root>/docker/.env` file (only as local change)
- `<project root>/docker/.env.dist` file (project wide change - other developers will also have that ENV)
- `<project root>/docker/environments/<environment>/.env` file (environment specific change - local change)
- `<project root>/docker/environments/<environment>/.env.dist` file (environment specific change - other developers will also have that ENV)

Possible values for `DOKMAN_DOCKER_COMPOSE_COMMAND` are:
- `docker-compose` - default (will be removed in future versions)
  - a standalone Python-based tool
  - requires a separate installation
  - legacy, being phased out
  - use docker compose for better integration and future-proofing
- `docker compose` - preferred way
  - a newer, native Docker CLI command integrated into docker
  - requires Docker CLI v20.10+
  - recommended for modern setups
