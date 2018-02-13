Dokman
------

**DO**c**K**er **MAN**ager

This is a bash helper library for easier working with docker-compose.

This library allows you to:
- have multiple environments of your docker setup (ie. production, development, CI...)
- have easy access to your docker containers

Install
-------

Include Dokman to your project as git submodule.

```bash
git submodule add --name dokman https://github.com/robier/dokman docker/.dokman
```

It will add Dokman to directory docker/.dokman in your project.

Run install script

```bash
docker/.dokman/install
```

Script will create Dokman skeleton in your docker directory and installation is over.

Note: Installation process will not override files that already exists.
Note: Every time you clone project that uses Dokman, you will need to initialize git submodules and pull Dokman ie.
(do not forget to add it to your CI procedure)

```bash
git submodule update --init --remote dokman
```

Setup
-----

Install will create some folders and files:
- `configurations` - it house all of your configurations for example `php.ini` or `httpd.conf`
- `environments` - ih houses files that describe what services belong to witch environment
- `images` - custom build docker images used by your application
- `scripts` - custom scripts that you want to push inside your docker containers
- `services` - **docker-compose** yaml files
    - `services/links` - houses only yaml files that links containers
    - `services/ports` - houses only yaml files that opens local ports
- `env` - helper script for building, upping, downing etc. docker containers
- `enter` - helper script for entering container or running some arbitrary command on running container
- `install` - helper script for installing your project (in this file you have access to bunch of bash helpers)

Updating
--------

To update library just do:

```bash
git submodule update dokman
```

This should update you Dokman to newest version. 

Note: Before update check if there where any braking changes.

Special variables
-----------------

Dokman creates few handy environment variables that are accessible in your YAML files.

- `DOKMAN_HOST_USER_ID` - current user id (handy for setting up permissions)
- `DOKMAN_HOST_GROUP_ID` - current user group id (handy for setting up permissions)
- `DOKMAN_HOST_IP` - IP of host machine that can be used in container to access host (handy for xdebug or similar services)

Helper scripts
--------------

Let's say you created YAML files in `services` directory and you created file named `dev` in
`environments` directory with list of YAML files. You can have as match `environments` as you want.
As helper script `env` is only wrapper for `docker-compose` with additional of combining YAML files
you can call whatever command as you would call it on `docker-compose`, to see full list of supported
commands and arguments see:

```bash
docker/env dev -h
```

I will only mention some of them for example:

```bash
docker/env dev build # build containers
docker/env dev up -d # up containers in daemon mode
docker/env dev down  # down all containers
docker/env dev logs  # check the logs of containers
```

---------------

There is also `enter` script that will ease you way into docker container. `enter` helper script
will try to enter docker container by it's name, for example.

```bash
docker/enter sh php
```
or
```bash
docker/enter php
```

If you omit 1. argument (in this case **sh**) it will default it to **sh** as it comes default with
linux machines, **bash** needs to be installed manually (if we take alpine linux for example).

If you send parameter after container name it will run that command and when command is done
it will close tty.

For example:
```bash
docker/enter php composer install
``` 

For easier use you can easily create helper script that will have `sh` or `bash` hardcoded as shorthand.

`docker/sh` example:

```bash
docker/enter sh ${@:1}
``` 

`docker/bash` example:

```bash
docker/enter bash ${@:1}
```

------------

There is a `install` helper script as well. It's used to create script that will help you with full 
project install. That script has access to a bunch of bash helper functions. All helper functions 
are located in `.dokman/helpers` folder. From name it should be obvious what they are doing, 
but check them out to see what arguments should be provided. 

Todo
----
- add possibility for multiple instances running at the same time?
