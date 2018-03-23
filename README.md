Dokman
------

**DO**c**K**er **MAN**ager

This is a bash helper library for easier working with `docker-compose`. Main goal of this library is to reduce
everyday typing of developer. As `docker` has `docker-compose` to easier orchestrate with docker containers
now developer has `dokman` for easier working with `docker-compose` enabling commonly used docker commands.

Main purpose for creating this library was to unify docker workflow on many projects I'm currently working
on and to reduce typing as match as possible.  

This library allows you to:
- have multiple environments of your docker setup (ie. production, development, CI...) and running simultaneously (if you create them with that in mind)
- have easy access to your docker containers (less typing)
- same docker philosophy on multiple projects
- whole docker is wrapped in easy to use shorthands
- `docker-compose` commands are wrapped in that manner to reduce typing with our special commands

Pre-requirements
----------------

Dokman pre-requires for you to have `docker` and `docker-compose` installed. 

Index
-----

1) [Install](docs/install.md)
   1) [Update](docs/update.md)
   1) [Structure](docs/structure.md)
1) [Environments](docs/environments.md)
   1) [Simple setup](docs/environments.md#simple-environment-vs-complex-environment)
   1) [Complex setup](docs/environments.md#simple-environment-vs-complex-environment)
      1) [Events](docs/events.md)
1) [Special variables](docs/special-variables.md)
1) [Helper scripts](docs/helpers/index.md)
   1) [enter](docs/helpers/enter.md)
   1) [env](docs/helpers/env.md)
   1) [install](docs/helpers/install.md)
   1) [run](docs/helpers/run.md)
1) [FAQ](docs/faq.md)
