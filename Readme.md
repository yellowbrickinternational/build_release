# Environments can be:

* {nl, be, de}-sit
* {nl, be, de}-acc

The script is using ssh to copy files. Then it relies on the ssh config locate under ~/.ssh/config where all machines (country-environment{1,2,3}) are defined.

```sh
Host nl-sit1
    User ${USERNAME}
    Hostname xxx.xxx.xxx.xxx
```

Of course, to avoid typing  a password for each file the script will copy, then using certificate authentication is highly recommended.
[ssh-copy-id](https://www.ssh.com/ssh/copy-id)

```sh
export SRC_ROOT=/path/to/top/directory/with/all/yb/projects
./deploy.sh ${ENV}
```

At the moment, this script only copy the war files on each servers under /tmp.
To deploy them under each individual tomcats, then:

Deployment of Yellowsoap:

```sh
ssh nl-sit1 /tmp/deploy_ys.sh
```

Deployment of MyYellowbrick:

```sh
ssh nl-sit2 /tmp/deploy_myb.sh
```
