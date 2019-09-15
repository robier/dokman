install helper
--------------

Install helper is here to ease your life with project install. Project install procedure should for example
create necessary directories for project to work, or maybe populate database. After install project should be
accessible.

Install script syntax looks like:

```bash
docker/install [-v|--verbose] [-h|--help] [-c|--colors] [your registered options] environment
```

Install is specific as it requires `.install.sh` file in docker root to work. There is a lot of special functions
to ease your way of writing install scripts:
- `dokmanInstall` - main installation function, all installation logic should go in that function
- `runCommand` - used for running any command (handles verbose mode) 1st parameter is a actual command, 2nd parameter is description
- `dokmanOption` - used for registering new option to install command
- `dokmanValueOption` - used for registering new option to install command that will hold a value
- `validateEnv` - validates provided env for existence
- `validateHostEntries` - validates array of host strings in `/etc/hosts` file 
- `waitHealthyService` - waits until all listed services becomes healthy
- `runEvent` - runs custom user event

**Note:** All dokman functions are also available in install script.

**Note:** You can register your own options via `dokmanOption` and `dokmanValueOption` functions, those new registered options
would be shown when showing help for install script.

All functions that are available in `.install.sh` are also available in `after-install.sh` event.

Example of one symfony `.install.sh` file:

```bash
#!/usr/bin/env bash

readonly hosts=(
    test.loc
)

function dokmanInstall
{
    # checks if all specified hosts are registered in /etc/hosts file
    dokmanValidateHosts "${hosts[*]}"

    if [ -L './.env' ] || [ ! -f './.env' ]; then
        # check if .env is a symlink or if it missing
        title "Removing old configuration files if needed..."
        dokmanRunCommand "rm -f ./.env" "Removing .env file"
        
        title "Adding missing files..."
        dokmanRunCommand "ln -s ./docker/configurations/env/${DOKMAN_ENV} .env" "Creating symlink for ${DOKMAN_ENV}/.env file..."
    fi

    title "Adding missing folders if needed..."

    dokmanRunCommand "mkdir -p ./var/logs" "Creating var/logs/ folder..."
    dokmanRunCommand "mkdir -p ./var/cache" "Creating var/cache/ folder..."
    
    title "Docker handling..."
    
    dokmanRunCommand "docker/env ${DOKMAN_ENV} on" "Building and upping docker containers..."
    # wait services mysql and elasticsearch to become healthy
    dokmanWaitHealthyService mysql elasticsearch
    
    title "Dependencies..."
    
    # backend
    dokmanRunCommand "docker/enter ${DOKMAN_ENV}:php composer install -n" "Installing php packages..."
    # frontend
    dokmanRunCommand "docker/run ${DOKMAN_ENV}:node npm install" "Installing JavaScript dependencies..."
    dokmanRunCommand "docker/run ${DOKMAN_ENV}:node npm run build" "Building JavaScript dependencies..."
    
    # create tables
    dokmanRunCommand "docker/enter ${DOKMAN_ENV}:php bin/console doctrine:schema:update --force" "Create tables..."
}
```

Best practice should be that all configuration files (may or may not be part of git) exists in docker directory and that
those configuration files are symlinked instead of just being copy/pasted.

As in your dev environment you'l need some dummy data for easier working you can generate it via `after-install.sh` 
event in `dev` environment: 

```bash
#!/usr/bin/env bash

title "Populate database..."

# create tables
dokmanRunCommand "docker/enter dev:php bin/console doctrine:fixtures:load" "Loading database fixtures..."
```




