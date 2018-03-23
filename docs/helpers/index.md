Dokman helpers
--------------

**Dokman** have really handy helper scripts for developer to use. All scripts are wrappers around 
**docker-compose** software (except `install` helper).

All **dokman** helper scripts are in fact relative symbolic links of scripts located inside **dokman** source
code. In this way nobody will touch those files, and when new version is checked out you would use
new code by default.

Those scripts are here to unify workflow between projects.

Available helper scripts:
- [`enter`](./enter.md) - enters already running container (wrapper for **docker-compose exec**)
- [`env`](./env.md) - main wrapper for **docker-compose** (all **docker-compose** commands are available)
- [`install`](./install.md) - script that will install the project, for example create folders and files that application
need to properly function
- [`run`](./run.md) - enters fresh container (wrapper for **docker-compose run**)

**Note:** The main helper is `env`, other helpers (except `install`) are just wrappers around `env` helper.

To speed up working with docker, some **docker-compose** flags that needed to be call explicitly
are now implicit, and can be turned off by new flags.

