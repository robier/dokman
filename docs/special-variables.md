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

Host IP under Docker Desktop
----------------------------

The variable `DOKMAN_HOST_IP` will be empty on Mac OS and Windows. If you are using the mentioned platforms, you should overwrite the variable in your `docker/.env` file with the `host.docker.internal` value:

```text
DOKMAN_HOST_IP=host.docker.internal
```

If you want more information, consult Docker Desktop's networking documentation for [Mac OS](https://docs.docker.com/docker-for-mac/networking/#there-is-no-docker0-bridge-on-macos) and [Windows](https://docs.docker.com/docker-for-windows/networking/#there-is-no-docker0-bridge-on-windows).
