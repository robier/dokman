# Health check scripts

Some containers take time to boot holding service. Best example is MySQL. When you start MySQL docker container,
MySQL daemon will take additional time to boot and service will not accept any queries in that time.

To tackle this problem you can use health check [docker feature](https://docs.docker.com/engine/reference/builder/#healthcheck).

**Note:** The HEALTHCHECK feature was added in Docker 1.12.

You can easily find script that you need on internet or you can easily write your own. Examples of
docker health check scripts can be found on [https://github.com/docker-library/healthcheck](https://github.com/docker-library/healthcheck).

When you implement health check script you can use health status of container in install script so your
install will wait until all listed services are healthy (refer to [install](./helpers/install.md) helper and special
function `dokmanWaitHealthyService`).

Recommended directory for placing health check scripts would be `docker/scripts/health-check`. Name of the script
should be the same of the name of service it belongs ie. `docker/scripts/health-check/mysql`.

**Note:** Health check script must be executable. 
