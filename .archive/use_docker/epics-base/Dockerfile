FROM  debian:stable-slim
LABEL Name="epics-base" \
      Version="3.0.0" \
      Maintainer="prjemian <prjemian@gmail.com>" \
      Description="source: https://github.com/prjemian/epics-docker/"

    #   lastupdate="2023-04-07" \
USER  root

CMD ["/bin/bash"]
WORKDIR /home

# use "nano" with `crontab -e`
# only show last few subdirs before console prompt
ENV APP_ROOT="/opt"
ENV EDITOR="nano" \
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
    && mkdir ~/bin "${LOG_DIR}"

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

RUN echo "# -------------------------------- start EPICS base" 2>&1 | tee -a "${LOG_DIR}/dockerfile.log"
COPY ./resources/epics_base.sh "${RESOURCES}/"
RUN "${RESOURCES}/epics_base.sh" 2>&1 | tee -a "${LOG_DIR}/dockerfile.log"
RUN echo "# -------------------------------- end EPICS base" 2>&1 | tee -a "${LOG_DIR}/dockerfile.log"
