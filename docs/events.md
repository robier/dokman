Events
------

Event scripts are special `bash` scripts that are called in case of some event. Those
scripts are handy if you need to run some specific `bash` logic before/after upping/downing
docker containers. For example let's say you want to populate some service after upping,
or do a cleanup after downing, you should use event scripts.

At the moment **dokman** have those events:
- `before-on` - called before containers are upped with `up` (special) command
- `after-on` - called after all containers are upped with `up` (special) command
- `before-off` - called before containers are stopped with `off` (special) command
- `after-off` - called after all containers are stopped with `off` (special) command
- `after-install` - called when we specify `environment` when running install command

**Note:** on/off events are only called if no containers are up/down when running command. 
So if you have all containers down, and run `on` 2 times in row, only the 1st time, events will be triggered.

Event scripts are placed in `events` directory under desired `environment`. For example:

```text
...
├── docker/
│   ├── ...
│   ├── environments/
│   │   ├── dev/
│   │   │   ├── events/
│   │   │   │   ├── after-off.sh
│   │   │   │   ├── after-on.sh
│   │   │   │   ├── before-off.sh
│   │   │   │   ├── before-on.sh
│   │   │   │   └── after-install.sh
│   │   │   └── config
│   │   └── ci/
│   │       └── ...
│   └── ...
└── ...
```

In this example we can see that `dev` environment has all of possible events, and 
that `ci` environment does not have any.

**Note:** All event scripts needs to have **sh** extension.

**Note:** Event scripts are optional.

**Note:** Event scripts are triggered on host machine, not in docker.

**Note:** There is no global event scripts that are triggered no matter of `environment`.

**Note:** All event scripts behaves like they are run from project root directory for easier working.

**Note:** Events folder is optional.

