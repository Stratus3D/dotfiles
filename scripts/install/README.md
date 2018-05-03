#scripts/install/

Scripts in this directory are for installing specific pieces of software on one or more operating systems. Each script is self contained and must adhere to the following rules in order for `scripts/setup.sh` to be able to install all software on a new or existing machine:

* Must exit with a status code of 0 when software is successfully installed
* Must exit with a status code of 1 when software fails to install
* Must exit with a status code of 2 when software is already installed on the machine
* Must exit with a status code of 3 when the software is not supported on platform

It's important to exit with a status of 2 so the `setup.sh` script knows the software the script was going to install is already installed.
