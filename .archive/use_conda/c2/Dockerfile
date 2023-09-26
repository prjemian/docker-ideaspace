FROM  debian:latest
# FROM  debian:12-slim
LABEL Name="epics-caqtdm" \
      Version="latest" \
      Maintainer="prjemian <prjemian@gmail.com>" \
      Description="source: https://github.com/prjemian/"

USER  root

CMD ["/bin/bash"]

ENV APP_ROOT=/usr/local/epics
ENV \
  MAMBA_ROOT_PREFIX=/usr/local/conda \
  EDITOR="nano" \
  IMAGE_VERSION="3.0.0" \
  LOG_DIR="${APP_ROOT}/logs" \
  PREFIX="ioc:" \
  PROMPT_DIRTRIM=3 \
  RESOURCES="${APP_ROOT}/resources"

RUN \
    touch ~/.bashrc ~/.bash_aliases \
    && echo "if [ -f ~/.bash_aliases ]; then" >> ~/.bashrc \
    && echo "    . ~/.bash_aliases" >> ~/.bashrc \
    && echo "fi" >> ~/.bashrc \
    && echo "# file: ~/.bash_aliases" >> ~/.bash_aliases \
    && echo "export LS_OPTIONS='--color=auto'" >> ~/.bash_aliases \
    && echo "export EDITOR=nano" >> ~/.bash_aliases \
    && echo "export PATH=${PATH}:${HOME}/bin" >> ~/.bash_aliases \
    && echo "export PROMPT_DIRTRIM=3" >> ~/.bash_aliases \
    && echo "alias ls='ls --color=auto'" >> ~/.bash_aliases \
    && echo "alias ll='ls -lAFgh'" >> ~/.bash_aliases \
    && mkdir ~/bin "${LOG_DIR}" \
    mkdir -p "${APP_ROOT}"

RUN echo "# -------------------------------- update OS" 2>&1 | tee -a "${LOG_DIR}/dockerfile.log"
# Build EPICS software here
RUN \
    echo "export APP_ROOT=${APP_ROOT}" >> ~/.bash_aliases \
    && echo "export RESOURCES=${RESOURCES}" >> ~/.bash_aliases \
    && echo "export LOG_DIR=${LOG_DIR}" >> ~/.bash_aliases


# sysAdmin work: Install necessary libraries from offical repo
RUN echo "# update OS" 2>&1 | tee -a "${LOG_DIR}/dockerfile.log"
RUN DEBIAN_FRONTEND=noninteractive apt-get update  -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y  \
        apt-utils \
        build-essential \
        git \
        less \
        libnet-dev \
        libpcap-dev \
        libreadline-dev \
        libusb-1.0-0-dev \
        libusb-dev \
        libx11-dev \
        libxext-dev \
        nano \
        procps \
        re2c \
        screen \
        vim \
        wget \
        2>&1 | tee -a "${LOG_DIR}/dockerfile.log"
    # && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
RUN rm -rf /var/lib/apt/lists/*
RUN echo "# -------------------------------- end OS install" 2>&1 | tee -a "${LOG_DIR}/dockerfile.log"


WORKDIR /home
RUN echo "# -------------------------------- build EPICS base" 2>&1 | tee -a "${LOG_DIR}/dockerfile.log"
COPY ./epics_base.sh "${RESOURCES}/"
RUN bash "${RESOURCES}/epics_base.sh"  2>&1 | tee -a "${LOG_DIR}/dockerfile.log"
RUN echo "# -------------------------------- end EPICS base build" 2>&1 | tee -a "${LOG_DIR}/dockerfile.log"


RUN echo "# -------------------------------- build caQtDM" 2>&1 | tee -a "${LOG_DIR}/dockerfile.log"
RUN DEBIAN_FRONTEND=noninteractive apt-get update  -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y  \
      apt-file \
      libgl-dev \
      libgl1 \
      libgl1-mesa-dev \
      libqt5svg5-dev \
      libqwt-qt5-dev \
      libzmq3-dev \
      python3-dev \
      python3-pip \
      qt5-qmake \
      qtbase5-dev \
      qtbase5-dev-tools \
      qttools5-dev \
      qtchooser \
    2>&1 | tee -a "${LOG_DIR}/dockerfile.log"

# ENV CAQTDM_RELEASE=V4.4.0
# ENV CAQTDM_RELEASE=V4.3.0
ENV \
  CAQTDM_RELEASE=V4.2.4 \
  EPICSEXTENSIONS=${APP_ROOT}/extensions

RUN mkdir -p ${EPICSEXTENSIONS}/src
WORKDIR ${EPICSEXTENSIONS}/src
RUN git clone https://github.com/caqtdm/caqtdm


WORKDIR /home
