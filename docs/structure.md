Structure
---------

Install script of **dokman** will create all folders and files that are needed for quick start. Some 
files/directories are optional and not needed so you can delete them if you do not use them. When
you run it for first time your should get directory structure like this:

```text
...
├── docker
│   ├── *.bootstrap.sh
│   ├── .install.sh
│   ├── *configurations/
│   ├── .dokman/
│   ├── enter
│   ├── env
│   ├── *.env
│   ├── .env.dist
│   ├── environments/
│   ├── .gitignore
│   ├── *images/
│   ├── install
│   ├── *scripts/
│   ├── *override.yml
│   └── *services/
...
```

**Note:** All files/directories marked with `*` are **optional** in **dokman** setup.

Docker directory structure explanation:
- `.bootstrap.sh` - Bash file that can hold logic for bootstrapping application. In this script
you have an access to all variables defined in `.env.dist` and `.env`. This script is run before any
**dokman** [helper scripts](./helpers/index.md) (except `install`).
- `.install.sh` - Special **dokman** script holding install logic. This logic **should not be** environment specific.
- `configurations` - Directory that you can place all of your configurations (files like `php.ini` or `nginx.conf`)
- `.dokman` - Directory holding **dokman** source files.
- `enter` - Special **dokman** helper script.
- `env` - Special **dokman** helper script.
- `.env` - File holding developer specific variables and is used for overwriting variables
defined in file `.env.dist`.
- `.env.dist` - File holding project specific variables.
- `environments` - Directory housing environments.
- `.gitignore` - File that defines that .env and environments/*/.env files are excluded in git.
- `images` - Directory holding Dockerfile files if they are needed in project.
- `install` - Special **dokman** helper script.
- `scripts` - Directory holding scripts that are pushed into docker container like some
entry script, or some helper script that needs to be available inside container.
- `override.yml` - Developer specific override for **docker-compose** `yml` files. 
(there is also possibility to have override per environment)
- `services` - Directory holding all **docker-compose** `yml` files. Philosophy is to create
little building blocks as possible, so it can be easily reused. Having that
in mind you can make folders and sub folders any way you like and organise your `yml` files 
(ie. you can make a folder with `ports` where you will have only yml parts that
exposes some service port inside docker to host machine).

**Note:** You can add additional folders and sub-folders that suits your project needs.
