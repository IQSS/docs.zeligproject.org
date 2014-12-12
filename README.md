docs.zeligproject.org
=====================

The [Zelig](http://zeligproject.org) documentation hosted at http://docs.zeligproject.org is built from the files in this repository.

[Sphinx](http://sphinx-doc.org) is used to build the docs from [reStructuredText](http://en.wikipedia.org/wiki/ReStructuredText) files that are generated on-the-fly by [knitr](http://yihui.name/knitr/) which executes the Zelig code embedded in .Rrst files. 

When the docs are built periodically by [a Jenkins job](https://build.hmdc.harvard.edu:8443/job/docs.zeligproject.org/) the following versions are in use:

- R 3.1.2
- knitr 1.8
- Python 2.7
- Sphinx 1.2.2

To build the docs, you can install the software above on your computer or use the [Vagrant environment in another git repo](https://github.com/IQSS/zeligproject.org) to build the docs in a virtual machine.

## Building the docs on your computer

Once you have the software above installed, clone this repo with...

    git clone https://github.com/IQSS/docs.zeligproject.org.git

... then cd to the "doc" directory and run `make html` or `make latexpdf`. The output will go to the "build" directory.

If you are satisfied with the results please feel free to make a pull request.

## Building the docs in Vagrant 

Vagrant is used to model the production server environment in which the docs are built periodically with [a Jenkins job](https://build.hmdc.harvard.edu:8443/job/docs.zeligproject.org/). By running `vagrant up`, the same scripts to build the docs in production will be used on a virtual machine running on your computer.

After installing [Vagrant](http://vagrantup.com) and [VirtualBox](http://virtualbox.org), clone [a different repo (zeligproject.org)](https://github.com/IQSS/zeligproject.org) that contains the Vagrant environment:

    git clone https://github.com/IQSS/zeligproject.org.git

Then `cd zeligproject.org` (the repo you just cloned) and run `vagrant up`. After much time has passed, you should be able to see the docs at <http://localhost:8000>

For more information about what Vagrant is doing, please see below.

## Zelig Docs Hackers Guide to Vagrant

In Vagrant, we install R, Python 2.7 and other dependencies with this script: https://github.com/IQSS/zeligproject.org/blob/master/deploy/setup/stage1.sh

That "stage 1" script installs R packages such as knitr and Zelig with this script: https://github.com/IQSS/zeligproject.org/blob/master/deploy/librarysetup.r

The way to know that the "stage 1" script is the starting point for Vagrant is by looking at the Vagrantfile: https://github.com/IQSS/zeligproject.org/blob/master/Vagrantfile

To test building the docs in Vagrant, clone https://github.com/IQSS/zeligproject.org and `cd` into the "zeligproject.org" directory and run `vagrant up`.

`vagrant up` will take a while as it installs R and compiles various R packages defined in the librarysetup.r script mentioned above. Now would be a good time to grab a coffee. Or lunch.

When `vagrant up` is finished, you should see "Docs should be visible at <http://localhost:8000>". Go ahead and click that link and see if the docs look ok.

The main script that generates the docs is https://github.com/IQSS/zeligproject.org/blob/master/deploy/post-build2 . Before executing this script in Vagrant, you must ssh into the Vagrant vm, become root, become the unprivileged "plaid" user, switch from Python 2.6 to 2.7, and source the script /webapps/code/zeligproject.org/deploy/workon-docs.zeliproject.org to enable virtualenvwrapper and "workon" the "docs.zeligproject.org" virtual environment. When all this is done, your prompt should look like "(docs.zeligproject.org)[plaid@localhost ~]$" and you should have the version of Sphinx specified in https://github.com/IQSS/zeligproject.org/blob/master/requirements.txt (1.2.2 as of this writing). You should expect to see output like this (some extra commands are executed to double-check version numbers):

    murphy:zeligproject.org pdurbin$ vagrant ssh
    Last login: Mon Dec  8 07:05:08 2014 from 10.0.2.2
    Welcome to your Packer-built virtual machine.
    [vagrant@localhost ~]$ sudo -i
    [root@localhost ~]# su - plaid
    [plaid@localhost ~]$ python --version
    Python 2.6.6
    [plaid@localhost ~]$ scl enable python27 bash
    [plaid@localhost ~]$ python --version
    Python 2.7.5
    [plaid@localhost ~]$ sphinx-build 2>&1 | head -1
    Sphinx v1.1.3
    [plaid@localhost ~]$ source /webapps/code/zeligproject.org/deploy/workon-docs.zeliproject.org
    (docs.zeligproject.org)[plaid@localhost ~]$
    (docs.zeligproject.org)[plaid@localhost ~]$ sphinx-build --version
    Sphinx (sphinx-build) 1.2.2

Now that you are the "plaid" user and have the correct version of Sphinx loaded, you can run this script to re-generate the docs and copy them into place: /webapps/code/zeligproject.org/deploy/post-build2

The output you see should be similar to the console output of the Jenkins job used to build the docs periodically: https://build.hmdc.harvard.edu:8443/job/docs.zeligproject.org/1/console

After you have run `post-build2` your changes should be reflected at <http://localhost:8000>

When you are finished with vagrant, you may want to run `vagrant halt` or `vagrant destroy` to shut down the virtual machine or delete it, respectively.
