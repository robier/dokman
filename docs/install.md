Install
-------

Our recommendation is that you have **docker** directory in the root of your project. In that directory 
you will place all scripts, docker configurations and also **dokman**. Recommended way of adding
**dokman** to your project is as git submodule, as in that way git will take care of **dokman** version
currently installed.

**Note:** All scripts are run from project root.

**Dokman** installation requires 2 steps:

0) You need to clone project to appropriate directory: 
    
    ```bash
    git submodule add --name dokman https://github.com/robier/dokman docker/.dokman
    ```
    In this example we are cloning **dokman** to `docker/.dokman` directory
0) You need to call **dokman** install script:
    
    ```bash
    docker/.dokman/install
    ```
    Install script will create [directory structure](./structure.md) for **dokman** in `docker` directory.
    
**Note:** Installation process will not override files that already exists.

**Note:** Repository is added as `https` (not as `ssh`), because this allows anonymous pulls from github.

Every time you clone project that uses **dokman**, you will need to initialize git submodules
and pull **dokman** (do not forget to add it to your CI procedure):
```bash
git submodule update --init docker/.dokman
```
