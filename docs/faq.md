FAQ
---

0. Why would I use this library?
    >This library allows you to standardize workflow on many projects and also to create as many environments 
    as you need in your project as building blocks are small. In this way you can easy copy some docker
    container setup from one project to another.

0. As all YMLs are split in small parts, it's hard to see big picture of all services in one project.
    >To see all YML configs connected with all variables parsed you can use `config` command of `docker-compose`.
    As `env` script is only a wrapper around `docker-compose` you can do something like this:
    >```bash
    >docker/env dev config   
    >```
    >Also all variables will be resolved.

0. Why is **dokman** written in `bash` and not in some other "language"?
    >Bash was selected for only one reason, no external dependencies for Mac and Linux (we do not care about Windows).
    Most of `bash` scripts works for Mac and Linux and if not there are some workarounds, also I wanted to learn bash :D.
    
0. Is **dokman** only a wrapper around `docker-compose`?
    >Main purpose of dokman is to be a wrapper but dokman also have really handy events system. For example you can 
    attach some logic to be run after all docker containers are up and running, or maybe before. Or maybe you want to
    populate database you have in your docker setup, after install.
