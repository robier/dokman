Dokman
------

**DO**c**K**er **MAN**ager

Supports both `docker-compose` or `docker compose` commands. Default is `docker-compose`, for backward compatibility.
In documentation, we will use term `docker compose` referring to both.

This is a bash helper library for easier working with `docker compose`. Main goal of this library is to reduce
everyday typing. As `docker` has `docker compose` to easier orchestrate with docker containers
now developer has `dokman` for easier working with `docker compose` enabling commonly used docker commands.

Main purpose for creating this library was to unify docker workflow on multiple projects.

This library allows you to:
- easily setup multiple environments of your docker setup (i.e. production, development, test...)
- have easy access to your docker containers (less typing)
- same docker philosophy on multiple projects
- whole docker is wrapped in easy to use shorthands
- `docker compose` commands are wrapped in that manner to reduce typing with our special commands
- event system that will ease your life with setting up project
- support for waiting containers until they become healthy

Pre-requirements
----------------

Dokman pre-requires for you to have `docker` and `docker-compose` or `docker compose` plugin.

**Note:** To use `docker compose` plugin instead of `docker-compose`, please check [this](./docs/docker-compose.md).

**Note:** New installations of dokman if they detect you have a `docker compose` plugin, they will use it.

For easier working with docker in general, add your user to docker group, so you will not need to write every docker 
command with `sudo`.

```bash
sudo usermod -aG docker ${USER}
```

**Note:** Dokman will populate environment variables with your current user and group ID, so you can easily create
shadow user.

Index
-----

1) [Install](./docs/install.md)
   1) [Update](./docs/update.md)
   1) [Structure](./docs/structure.md)
1) [Environments](./docs/environments.md)
   1) [Simple setup](./docs/environments.md#simple-environment-vs-complex-environment)
   1) [Complex setup](./docs/environments.md#simple-environment-vs-complex-environment)
1) [Special variables](./docs/special-variables.md)
1) [Events](./docs/events.md)
1) [Helper scripts](./docs/helpers/index.md)
   1) [enter](./docs/helpers/enter.md)
   1) [env](./docs/helpers/env.md)
   1) [install](./docs/helpers/install.md)
   1) [run](./docs/helpers/run.md)
1) [Health check scripts](./docs/health-check-scripts.md)
1) [FAQ](./docs/faq.md)
   1) [docker-compose](./docs/docker-compose.md)
