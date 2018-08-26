Special variables
-----------------

System creates few handy variables that you can use in your setup: 

- `DOKMAN_HOST_USER_ID` - current user id (handy for setting up permissions)
- `DOKMAN_HOST_GROUP_ID` - current user group id (handy for setting up permissions)
- `DOKMAN_HOST_IP` - IP of host machine that can be used in container to access host (handy for xdebug or similar services)
- `DOKMAN_SCRIPT_DIR` - absolute path of running **dokman** script
- `DOKMAN_DIR` - absolute path to **dokman** directory
- `DOKMAN_ENV` - name of current **dokman** environment
- `DOKMAN_PROJECT_ROOT` - absolute path to project root

**Note:** Special variables are also accessible in `YAML` files.

**Note:** Variable `DOKMAN_HOST_IP` will be empty on Mac, if you are using Mac you should
overwrite that variable in your `docker/.env` with value [host.docker.internal](https://docs.docker.com/docker-for-mac/networking/#there-is-no-docker0-bridge-on-macos) ie.

```text
DOKMAN_HOST_IP=host.docker.internal
```
