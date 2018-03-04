Dokman
------

**DO**c**K**er **MAN**ager

This is a bash helper library for easier working with `docker-compose`. Main goal of this library is to reduce
everyday typing of developer. As `docker` has `docker-compose` to easier orchestrate with docker containers
now developer has `dokman` for easier working with `docker-compose` enabling commonly used docker commands.

Main purpose for creating this library was to unify docker workflow on many projects I'm currently working
on and to reduce typing as match as possible.  

This library allows you to:
- have multiple environments of your docker setup (ie. production, development, CI...) and running simultaneously
- have easy access to your docker containers (less typing)
- same docker philosophy on multiple projects
- whole docker is wrapped in easy to use shorthands
- `docker` and `docker-compose` commands are wrapped in that manner to reduce typing with our special commands

Install
-------

Let's assume that you have `docker` folder in the root of your project. We will install **dokman** as 
sub-folder of `docker` directory as git submodule.

**Note:** All script is run from project root.

```bash
git submodule add --name dokman https://github.com/robier/dokman docker/.dokman
```

**Note:** Repository is added as https (not as ssh), because this allows anonymous pulls from github. 

It will add **dokman** to directory `docker/.dokman` in your project.

Run install script

```bash
docker/.dokman/install
```

Script will create **dokman** [skeleton](#folder-skeleton-structure) in your docker directory.

**Note:** Installation process will not override files that already exists.
**Note:** Every time you clone project that uses **dokman**, you will need to initialize git submodules
and pull **dokman** (do not forget to add it to your CI procedure).

```bash
git submodule update --init --remote docker/.dokman
```

**Note:** If your user is not in docker group please add it, in that way you can run `docker` and `docker-compose` as
your own user (also you can create user in your containers that will "shadow" your own user and you will not have 
problems with permissions).

```bash
sudo usermod -aG docker ${USER}
```

Updating
--------

To update library to any tag/commit/branch just do:

```bash
cd docker/.dokman
git fetch
git checkout <tag|commit|branch>
```

This should update **dokman** to version you provided. 

**Note:** Before update check if there where any braking changes.

Folder skeleton structure
-------------------------

Install script of **dokman** will create all folders and files that are needed for quick start:

```text
docker
├── .bootstrap
├── configurations
├── .defaults
├── .dokman
├── enter
├── env
├── .env
├── environments
├── .gitignore
├── images
├── install
├── scripts
└── services
    ├── links
    └── ports
```

Explanation:
- `.bootstrap` - file where you can compute some variables via bash (you can access to all variables
from `.env` and `.default` and all **dokman** bash functions)
- `configurations` - it house all of your configurations for example `php.ini` or `nginx.conf`
- `.defaults` - file that houses project specific env default variables (can be changed by `.env` file)
- `.dokman` - directory that houses **dokman** library
- `enter` - helper script for entering container or running some arbitrary command on **running** container
- `env` - helper script for building, upping, downing etc. docker containers
- `.env` -  **optional** file that holds developer specific env variables (not in git)
- `environments` - ih houses files/folders that describe what services belong to witch environment
- `.gitingone` - ignores some files like main `.env` and environment specific `.env` file
- `images` - **optional** custom docker images used by your application
- `install` - helper script for installing your project (in this file you have access to bunch of bash helpers)
- `scripts` - **optional** directory for custom scripts that you want to push inside your docker containers
- `services` - houses **docker-compose** yaml files (philosophy is to to create small building blocks)
    - `services/links` - **optional** directory housing only yaml files that links containers
    - `services/ports` - **optional** directory housing only yaml files that opens local ports
    
To see real working example please check out [dokman demo](https://github.com/robier/dokman-demo).

**Note:** You can add additional folders and sub-folders that suits your needs.

Special variables
-----------------

**dokman** creates few handy environment variables that are accessible in your YAML files.

- `DOKMAN_HOST_USER_ID` - current user id (handy for setting up permissions)
- `DOKMAN_HOST_GROUP_ID` - current user group id (handy for setting up permissions)
- `DOKMAN_HOST_IP` - IP of host machine that can be used in container to access host (handy for xdebug or similar services)
- `SCRIPT_DIR` - absolute path of running script
- `DOKMAN_DIR` - absolute path to **dokman** directory
- `DOKMAN_ENV` - name of current **dokman** environment (only available trough `env` and `run` helper scripts)

Environments
------------

You can create environment as just a plain text file (without extension) or as a directory.

When you have a simple setup, ie. no need to additional/specific environment variables, you should use
**file environments**. 

-----------

Nginx + PHP sample for local development:

```text
# docker/environments/dev
php.yml
nginx.yml

# connect php and mysql
links/php-nginx.yml

# expose nginx port to local machine
ports/nginx.yml
```

PHP sample for running unit tests:

```text
# docker/environments/ci
php.yml
```

When running only unit tests you do not need any additional services as everything should be mocked.

----------------

For more complex setup you should use **directory environments**. Directory needs to have this structure:

```text
docker
├── ...
├── environments
│   ├── dev
│   │   ├── .bootstrap
│   │   ├── config
│   │   ├── .defaults
│   │   ├── down.sh
│   │   ├── .env
│   │   └── up.sh
│   └── ci
│       ├── .bootstrap
│       ├── config
│       ├── .defaults
│       ├── .env
│       └── down.sh
└── ...
```

Explanation:
- `.bootstrap` - **optional** bash file where you can do your project specific magic ie. set some variables
that requires some computations
- `config` - file in the same format as **file environment**
- `.defaults` - **optional** file with env variables specific for this environment
- `down.sh` - **optional** file with bash code that will be run after we down all containers (for clean-up)
- `.env` - **optional** file for developer specific env variables that can overwrite variables defined 
in `.defaults` or introduce new ones (this file is not in git)
- `up.sh` - **optional** file with bash code that will be run after upping all containers (for environment specific
setup) if we up container with `-d` flag

**Note:** Environment specific configuration files (`.bootstrap`, `.defaults` and `.env`) are loaded only
on build time.

Event scripts
-------------

Event scripts are called in case of some event. At the moment there is only 4 events:
- `before-on` - called before containers are upped with `up` (special) command
- `after-on` - called after all containers are upped with `up` (special) command
- `before-off` - called before containers are stopped with `off` (special) command
- `after-off` - called after all containers are stopped with `off` (special) command

**Note:** on/off events are only called if no containers are up/down when running command. So if you have all containers
down, and run `on` 2 time in row, only 1st time events will be triggered.

To create event specific command you need to add script with name of event to your environment folder(with sh extension).
For example let's say you want to populate some service after upping, you should create file `after-on.sh` in your
environment folder and write your populating logic in there.

**Note:** Event scripts are triggered on host machine, not in docker.

Helper scripts
--------------

Currently there is 4 helper scripts:
- `env` - wrapper for `docker-compose` that will ease your life as you can easily switch environments
- `enter` - script for entering running container
- `run` - script for running one-time containers
- `install` - script for installing your project trough docker (when this script finishes you should be
able to access the project)

docker/env
----------

As `env` command is a wrapper for `docker-compose` it has almost the same API as `docker-compose`. You can
up, down, stop, see logs and so on. Syntax should look like:

```bash
docker/env <env> <command> [<args>]
```

- `env` - name of your environment
- `command` - one of `docker-compose` commands (to see list of all available commands run `docker-compose -h`)
- `args` - arguments of provided `docker-compose` command (to see list of all available arguments of one command run
`dokcer-compose <command> -h`)

Special flavored commands:
- `on` - will run `dokcer-compose up --build --no-recreate -d` as shorthand with additional calling of event scripts
- `off` - will run `dokcer-compose down` as shorthand with additional calling of event scripts

Examples:
```bash
docker/env dev on               # special command for upping containers
docker/env dev off              # special command for downing containers
docker/env dev build            # build dev environment
docker/env dev up               # up all containers in dev environment in detach mode
docker/env dev ps               # list all containers in dev environment
docker/env dev logs             # show logs of all running containers
docker/env dev logs php         # show only logs of php container
docker/env dev logs -f php      # tail -f logs of php container
docker/env dev kill php         # kill php container
docker/env dev restart          # restart all containers
docker/env dev restart php      # restart only php container
```

docker/run
----------

It's used for running one time scripts/tasks. Syntax should look like:

```bash
docker/run [<options>] <env>:<service> [sh|bash] [<command>] [<args...>]
```

- `options` - options that can be passed to change behavior of container, all `docker-compose run -h` options are 
supported (two of them are turn on by default `--no-deps` and `--rm`)
- `<env>:<service>` - to run some command inside php service in dev environment we would write `dev:php`
- `sh|bash` - sh is default
- `command` - any command that wou want to run on your container
- `args` - arguments that you want to send to your command

By default run will not load linked containers and will remove container after run. If you do not provide any command and
arguments, you will enter container.

Special flavored options:
- `--deps` - will turn off default `--no-deps` switch
- `--no-rm` - will turn off default `--rm` switch 

**Note:** Notice special syntax for writing `env` and `service` delimited by `:`.

Examples:
```bash
docker/run dev:node yarn run build:development      # create node container form dev environment, run command `yarn run build:development` and exit 
docker/run dev:node                                 # create node container form dev environment and enter it
docker/run --user root dev:node                     # create node container form dev environment, login as root user
dokcer/run --user root -w /tmp dev:node             # create node container form dev environment, login as root user to /tmp directory
dokcer/run dev:node bash                            # create node container form dev environment, login to bash
```

docker/enter
------------

It's used to enter already running container. Syntax should look like:

```bash
docker/enter [<options>] <env>:<service> [sh|bash] [<command>] [<args...>]
```

- `options` - same options provided by `docker-compose exec -h`
- `<env>:<service>` - to run some command inside php service in dev environment we would write `dev:php`
- `sh|bash` - sh is default
- `command` - command you want to run in running service
- `args` - arguments you want to add to command

If command is not provided it will enter provided container. This command does not have any special flavors.

Examples:
```bash
docker/enter dev:php                        # enter already running php container
docker/enter --user root dev:php            # enter already running php container as root user
docker/enter dev:php composer install       # enter already running php container, run command `composer install` and exit
```

docker/install
--------------

Main purpose of this script is to install whole project and you have all **dokman** bash functions available.


Todo
----
- add tests
