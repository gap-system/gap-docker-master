FROM gapsystem/gap-docker-base

MAINTAINER The GAP Group <support@gap-system.org>

ENV GAP_BRANCH=master

RUN    mkdir /home/gap/inst/ \
    && cd /home/gap/inst/ \
    && wget -q https://github.com/gap-system/gap/archive/${GAP_BRANCH}.zip \
    && unzip -q ${GAP_BRANCH}.zip \
    && rm ${GAP_BRANCH}.zip \
    && cd gap-${GAP_BRANCH} \
    && ./autogen.sh \
    && ./configure \
    && make \
    && cp bin/gap.sh bin/gap \
    && mkdir pkg \
    && cd pkg \
    && wget -q https://www.gap-system.org/pub/gap/gap4pkgs/packages-${GAP_BRANCH}.tar.gz \
    && tar xzf packages-${GAP_BRANCH}.tar.gz \
    && rm packages-${GAP_BRANCH}.tar.gz \
    && ../bin/BuildPackages.sh \
    && test='JupyterKernel-*' \
    && mv ${test} JupyterKernel \
    && cd JupyterKernel \
    && python3 setup.py install --user

RUN jupyter serverextension enable --py jupyterlab --user

ENV PATH /home/gap/inst/gap-${GAP_BRANCH}/pkg/JupyterKernel/bin:${PATH}
ENV JUPYTER_GAP_EXECUTABLE /home/gap/inst/gap-${GAP_BRANCH}/bin/gap.sh

ENV GAP_HOME /home/gap/inst/gap-${GAP_BRANCH}
ENV PATH ${GAP_HOME}/bin:${PATH}
