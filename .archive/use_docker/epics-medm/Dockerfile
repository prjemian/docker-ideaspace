FROM  prjemian/epics-base:3.0.0
LABEL Name="epics-medm" \
      Version="3.0.0" \
      Maintainer="prjemian <prjemian@gmail.com>" \
      Description="source: https://github.com/prjemian/epics-docker/"

    #   lastupdate="2023-04-07" \
USER  root

CMD ["/bin/bash"]
WORKDIR /home

# https://stackoverflow.com/questions/25281992/alternatives-to-ssh-x11-forwarding-for-docker-containers
# https://stackoverflow.com/questions/43613474/using-x11-forwarding-for-docker-containers
# https://jaydenm.com/blog/docker-x11-desktop/
# https://docs.docker.com/get-started/02_our_app/
# https://unix.stackexchange.com/questions/481532/x11-error-when-run-as-a-docker-container
# https://github.com/mviereck/x11docker

RUN echo "# -------------------------------- start EPICS MEDM" 2>&1 | tee -a "${LOG_DIR}/dockerfile.log"
# Install additional OS packages
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update  -y \
        2>&1 | tee -a "${LOG_DIR}/dockerfile.log"
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y  \
        apt-file \
        libmotif-dev \
        libxmu-dev \
        libxmu-headers \
        libxpm-dev \
        libxt-dev \
    && apt-file update \
        2>&1 | tee -a "${LOG_DIR}/dockerfile.log"

COPY ./resources/epics_medm.sh "${RESOURCES}/"
COPY ./resources/medm_fonts.alias "${RESOURCES}/"
RUN "${RESOURCES}/epics_medm.sh" 2>&1 | tee -a "${LOG_DIR}/dockerfile.log"
RUN echo "# -------------------------------- end EPICS MEDM" 2>&1 | tee -a "${LOG_DIR}/dockerfile.log"
