install helper
--------------

Install helper is here to ease your life with project install. Project install procedure should only
create necessary directories for project to work. This should not depend on any environment.

Install script syntax looks like:

```bash
docker/install [-v|--verbose] [-h|--help] [your registered options] [environment]
```

**Note:** Do not add creation of environment specific files or folders to global install script.  

Install is specific as it requires `.install.sh` file in docker root to work. There is a lot of special functions
to ease your way of writing install scripts:
- `dokmanInstall` - main instalation function, all instalation logic should go in that function
- `dokmanValidateHosts` - validates array of host strings in `/etc/hosts` file
- `dokmanRunCommand` - used for running any command (handles verbose mode) 1st parametar is a actuall command, 2nd parametar is description
- `dokmanOption` - used for registering new option to install command
- `dokmanValueOption` - used for registering new option to install command that will hold a value

**Note:** All dokman sh functions are also avaliable.

**Note:** You can register your own options via `dokmanOption` and `dokmanValueOption` functions, those new registered options
would be shown when showing help for install script.

If you call `docker/install` without environment provided, only `.install.sh` will be run. If environment is provided,
install script will try to run (if it's exists) `docker/environments/{env}/events/after-install.sh`. All functions that
are avaliable in `.install.sh` are also avaliable in `after-install.sh` event.

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

    title "Removing old configuration files if needed..."

    dokmanRunCommand "rm -f ./app/config/parameters.yml" "Removing parameters.yml file"

    title "Adding missing folders if needed..."

    dokmanRunCommand "mkdir -p ./var/logs" "Creating var/logs/ folder..."
    dokmanRunCommand "mkdir -p ./var/cache" "Creating var/cache/ folder..."
}
```
and it's `dev` `after-install.sh` event:
```bash
#!/usr/bin/env bash

title "Adding missing files..."

dokmanRunCommand "ln -s ./../docker/configurations/parameters/dev.yml ./app/config/parameters.yml" "Creating symlink for parameters.yml file..."

title "Docker handling..."

dokmanRunCommand "docker/env dev on" "Building and upping docker containers..."

title "Dependencies..."

dokmanRunCommand "docker/enter dev:php composer install -n" "Installing php packages..."
dokmanRunCommand "docker/run dev:node npm install" "Installing JavaScript dependencies..."
dokmanRunCommand "docker/run dev:node npm run build" "Building JavaScript dependencies..."
```



