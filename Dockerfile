FROM gapsystem/gap-docker-base

MAINTAINER The GAP Group <support@gap-system.org>

ENV GAP_BRANCH=master

# download and build GAP
RUN    mkdir /home/gap/inst/ \
    && cd /home/gap/inst/ \
    && git clone --depth=1 -b ${GAP_BRANCH} https://github.com/gap-system/gap gap-${GAP_BRANCH} \
    && cd gap-${GAP_BRANCH} \
    && ./autogen.sh \
    && ./configure \
    && make \
    && cp bin/gap.sh bin/gap

# download and build GAP packages
RUN    mkdir /home/gap/inst/gap-${GAP_BRANCH}/pkg \
    && cd /home/gap/inst/gap-${GAP_BRANCH}/pkg \
    && curl https://www.gap-system.org/pub/gap/gap4pkgs/packages-${GAP_BRANCH}.tar.gz | tar xz \
    && ../bin/BuildPackages.sh

# build JupyterKernel
RUN    cd /home/gap/inst/gap-${GAP_BRANCH}/pkg \
    && mv JupyterKernel-* JupyterKernel \
    && cd JupyterKernel \
    && python3 setup.py install --user

RUN jupyter serverextension enable --py jupyterlab --user

ENV PATH /home/gap/inst/gap-${GAP_BRANCH}/pkg/JupyterKernel/bin:${PATH}
ENV JUPYTER_GAP_EXECUTABLE /home/gap/inst/gap-${GAP_BRANCH}/bin/gap.sh

ENV GAP_HOME /home/gap/inst/gap-${GAP_BRANCH}
ENV PATH ${GAP_HOME}/bin:${PATH}
