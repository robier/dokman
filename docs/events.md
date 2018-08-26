Events
------

Event scripts are special `bash` scripts that are called in case of some event. Those
scripts are handy if you need to run some specific `bash` logic before/after upping/downing
docker containers. For example let's say you want to populate some service after upping,
or do a cleanup after downing, you should use event scripts.

At the moment **dokman** have those mayor events:
- `install` - triggered on project installation
- `on` - triggered on starting project with `on` (special) command 
- `off` - triggered on stopping project with `off` (special) command

Every mayor event will trigger `before` and `after` event, so actual list of events is:
- `before-install` - dispatched before actual install of project
- `after-install` - dispatched after actual install of project
- `before-on` - dispatched before containers are upped with `on` command
- `after-on` - dispatched after all containers are upped with `on` command
- `before-off` - dispatched before containers are stopped with `off` command
- `after-off` - dispatched after all containers are stopped with `off` command

In dokman there is 2 types of events, **global** and **environment**.

**Note:** on/off events are only called if no containers are active or if all container are down. 
So if you have all containers down, and run `on` 2 times in row, only the 1st time, events will be triggered.

**Note:** There is environment specific events and also global events.

Global event scripts are placed in `events` directory of docker setup. For example:

```text
...
├── docker/
│   ├── ...
│   ├── events/
│   │   ├── after-off.sh
│   │   ├── after-on.sh
│   │   ├── before-off.sh
│   │   ├── before-on.sh
│   │   ├── before-install.sh
│   │   └── after-install.sh
│   └── ...
└── ...
```

Environment event scripts are placed in `events` directory under desired `environment`. For example:

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
│   │   │   │   ├── before-install.sh
│   │   │   │   └── after-install.sh
│   │   │   └── config
│   │   └── ci/
│   │       └── ...
│   └── ...
└── ...
```

In this example we can see that `dev` environment has all of possible events.

**Note:** All event scripts needs to have **sh** extension.

**Note:** Event scripts are optional.

**Note:** Event scripts are triggered on host machine, not in docker.

**Note:** All event scripts behaves like they are run from project root directory for easier working.

**Note:** Event folders (global or environment specific) are optional.

**Note:** Global events are handy for having common build/cleanup logic that are the same for all environments.

**Note:** When event is triggered, event script residing in environment will be triggered then global one if any of them
exists.
