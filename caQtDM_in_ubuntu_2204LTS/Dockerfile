FROM  ubuntu:23.10
LABEL Name="caqtdm_ubuntu_23_10" \
      Version="latest" \
      Maintainer="prjemian <prjemian@gmail.com>" \
      Description="source: https://github.com/prjemian/"

USER  root
CMD ["/bin/bash"]
SHELL ["/bin/bash", "--login", "-c"]
WORKDIR /home

# set the time zone for the image
RUN ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime

COPY install_prereqs.sh ./
RUN ./install_prereqs.sh

COPY  symbols.sh ./
COPY build_epics_base.sh ./
RUN ./build_epics_base.sh

COPY prepare_epics_extensions.sh ./
RUN ./prepare_epics_extensions.sh

RUN pwd
COPY build_caqtdm.sh ./
RUN ./build_caqtdm.sh
