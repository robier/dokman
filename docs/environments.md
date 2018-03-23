Environments
------------

Environments are here to ease developer life by introducing multiple environment setup of same project.
For example in your project you can have `production`, `development`, `production` or any other environment.   

There are 2 types of environments in **dokman**: 
- **simple** - consists of only one file and it's name is actually name of environment (without extension) 
- **complex** - consists of directory and it's name is actually name of environment, that directory 
holds other files that are needed for complex environment setup


Environment configuration
-------------------------

Environment configuration consists of list of `YAML` files from directory `services`. When you writing path you need to
write full path from `docker` directory.

Example of environment file for `production` environment of simple php application:

```text
# services
services/php.yml
services/nginx.yml
services/mysql.yml

# links
services/links/php-nginx.yml
services/links/php-mysql.yml

# exposed ports to host machine
services/ports/nginx.yml
```

**Note:** Environment file supports comments (lines starting with # are skipped)

Corresponding file structure of previous example:

```text
...
├── docker/
│   ├── ...
│   ├── services/
│   │   ├── php.yml
│   │   ├── nginx.yml
│   │   ├── mysql.yml
│   │   ├── mailhog.yml
│   │   ├── links/
│   │   │   ├── php-nginx.yml
│   │   │   ├── php-mailhog.yml
│   │   │   └── php-mysql.yml
│   │   └── ports/
│   │       ├── nginx.yml
│   │       └── mailhog.yml
│   └── ...
...
```

Simple environment vs complex environment
-----------------------------------------

Simple environment allows you to simply define list of `YAML` files that will be
used in specific environment. Use simple environment when you don't need:
- to change any global variables
- events

While complex environment allows you to change variables or use any of **dokman**
events.

**Note:** You can also have developer specific `.env` file per environment that is 
not part of git.

Configuration file syntax is the same, but only the naming is different. In simple
environment configuration file has a name of the environment, while in complex
environment configuration is named `config` and it's under specific environment directory. 

```text
...
├── docker/
│   ├── ...
│   ├── environments/
│   │   ├── dev
│   │   └── ci/
│   │       ├── config
│   │       └── .env.dist
│   └── ...
...
```
Files `docker/environments/dev` and `docker/environments/ci/config` are
environment configurations.

In this way everything regarding one environment is in one place.
