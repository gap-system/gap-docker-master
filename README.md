# Docker container for GAP development version

This container provides the core GAP system build from the master branch
of the GAP repository (https://github.com/gap-system) and GAP packages
prepared for the next major release of GAP.

If you have installed Docker (see https://www.docker.com/), to use this
container first you need to download it using

    docker pull gapsystem/gap-docker-master

After that, you can start the GAP container using

    docker run --rm -i -t gapsystem/gap-docker-master

Note that you may have to run `docker` with `sudo`, particularly if you are on Ubuntu.

The location of GAP in the container is `/home/gap/inst/gap-master`
