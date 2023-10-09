FROM  debian:12-slim
LABEL Name="sandbox" \
      Version="latest" \
      Maintainer="prjemian <prjemian@gmail.com>" \
      Description="source: https://github.com/prjemian/"

USER  root
CMD ["/bin/bash"]
WORKDIR /home

ENV  \
  CAQTDM_VERSION=V4.4.1-rc10 \
  EPICS_BASE_VERSION=7.0.7 \
  INSTALL_DIR=/opt/caQtDM

# ------------------------------ docker developer UI
ENV \
  EDITOR="nano" \
  PROMPT_DIRTRIM=3

RUN \
    touch ~/.bashrc ~/.bash_aliases \
    && echo "if [ -f ~/.bash_aliases ]; then" >> ~/.bashrc \
    && echo "    . ~/.bash_aliases" >> ~/.bashrc \
    && echo "fi" >> ~/.bashrc \
    && echo "# file: ~/.bash_aliases" >> ~/.bash_aliases \
    && echo "alias ls='ls --color=auto' " >> ~/.bash_aliases \
    && echo "alias ll='ls -lAFgh' " >> ~/.bash_aliases \
    && echo "export EDITOR=nano" >> ~/.bash_aliases \
    && echo "export LS_OPTIONS='--color=auto'" >> ~/.bash_aliases \
    && echo "export PATH=${PATH}:${HOME}/bin" >> ~/.bash_aliases \
    && echo "export PROMPT_DIRTRIM=3" >> ~/.bash_aliases \
    && mkdir ~/bin

RUN echo "# update OS" 2>&1 | tee -a "${LOG_DIR}/dockerfile.log"
RUN DEBIAN_FRONTEND=noninteractive apt-get update  -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y  \
        git \
        less \
        nano \
        wget \
        2>&1 | tee -a "${LOG_DIR}/dockerfile.log"

# ------------------------------ EPICS base
# use two steps to access new env var: APP_ROOT
ENV APP_ROOT=/opt
ENV LOG_DIR="${APP_ROOT}/logs"
RUN mkdir -p ~/bin "${LOG_DIR}"
RUN DEBIAN_FRONTEND=noninteractive apt-get update  -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y  \
        apt-file \
        apt-utils \
        build-essential \
        libreadline-dev \
        libusb-1.0-0-dev \
        libusb-dev \
        procps \
        re2c \
        2>&1 | tee -a "${LOG_DIR}/dockerfile.log"
RUN apt-file update 2>&1 | tee -a "${LOG_DIR}/dockerfile.log"

# Did it compile?
# compiled  EPICS BASE  caQtDM
# no        7.0.7       V4.4.0
# no        7.0.7       V4.3.0
# no        7.0.7       V4.2.4
# no        7.0.5       V4.4.0
# no        7.0.3       V4.4.0
# yes       7.0.2       V4.4.0
# yes       7.0.7       V4.4.1-rc8

ENV \
  EPICS_HOST_ARCH=linux-x86_64 \
  MAKE_JOBS_N=-j8
ENV EPICS_BASE_NAME=base-${EPICS_BASE_VERSION}
ENV EPICS_BASE="${APP_ROOT}/${EPICS_BASE_NAME}"
ENV LOG_FILE="${LOG_DIR}/build-base.log"

ADD \
  https://epics.anl.gov/download/base/${EPICS_BASE_NAME}.tar.gz \
  "${APP_ROOT}/"
WORKDIR "${APP_ROOT}/"
RUN tar xzf ${EPICS_BASE_NAME}.tar.gz \
  && rm  ${EPICS_BASE_NAME}.tar.gz \
  && ln -s ${EPICS_BASE_NAME} base \
  && ls -lAFgh \
  && export EPICS_HOST_ARCH="$(${EPICS_BASE}/startup/EpicsHostArch)" \
  && export PATH="${PATH}:${EPICS_BASE}/bin/${EPICS_HOST_ARCH}" \
  && echo "EPICS_BASE_VERSION=${EPICS_BASE_VERSION}" >> ~/.bash_aliases \
  && echo "EPICS_HOST_ARCH=${EPICS_HOST_ARCH}" >> ~/.bash_aliases \
  && echo "PATH=\${PATH}:${EPICS_BASE}/bin/${EPICS_HOST_ARCH}" >> ~/.bash_aliases
WORKDIR "${EPICS_BASE}"
RUN \
  make \
    "${MAKE_JOBS_N}" \
    all \
    CFLAGS="-fPIC" CXXFLAGS="-fPIC" \
    2>&1 \
    | tee -a "${LOG_FILE}"
RUN \
  make clean  2>&1 | tee -a "${LOG_FILE}"

# ------------------------------ EPICS extensions
WORKDIR "${APP_ROOT}/"

ENV \
  EPICSEXTENSIONS=${APP_ROOT}/extensions
RUN \
  mkdir -p \
    "${EPICSEXTENSIONS}/src" \
    "${EPICSEXTENSIONS}/include" \
    "${EPICSEXTENSIONS}/bin/${EPICS_HOST_ARCH}" \
    "${EPICSEXTENSIONS}/lib/${EPICS_HOST_ARCH}" \
  && echo "EPICSEXTENSIONS=${EPICSEXTENSIONS}" >> ~/.bash_aliases \
  && echo "PATH=\${PATH}:${EPICSEXTENSIONS}/bin/${EPICS_HOST_ARCH}" >> ~/.bash_aliases

# ------------------------------ caQtDM

ADD \
  https://github.com/caqtdm/caqtdm/archive/refs/tags/${CAQTDM_VERSION}.tar.gz \
  ${EPICSEXTENSIONS}/src
RUN \
  echo "CAQTDM_VERSION=${CAQTDM_VERSION}" >> ~/.bash_aliases \
  && cd "${EPICSEXTENSIONS}/src" \
  && tar xzf ${CAQTDM_VERSION}.tar.gz \
  && ln -s ./$(ls . | grep caqtdm) ./caqtdm

RUN DEBIAN_FRONTEND=noninteractive apt-get update  -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y  \
      libgl-dev \
      libgl1 \
      libgl1-mesa-dev \
      libqt5svg5-dev \
      libqt5x11extras5-dev \
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

ENV \
  CAQTDM_SOURCE="${EPICSEXTENSIONS}/src/caqtdm" \
  PYTHONVERSION=3.11 \
  QTHOME=/usr \
  QWTLIBNAME=qwt-qt5 \
  ZMQ="/usr"
ENV \
  CAQTDM_COLLECT="${CAQTDM_SOURCE}/caQtDM_Binaries" \
  PYTHONINCLUDE="/usr/include/python${PYTHONVERSION}" \
  PYTHONLIB="/usr/lib/python${PYTHONVERSION}" \
  QTBASE="${CAQTDM_SOURCE}" \
  QTDM_RPATH="${EPICS_BASE}/lib/${EPICS_HOST_ARCH}:${QTBASE}" \
  QWTHOME="${QTHOME}"

WORKDIR ${EPICSEXTENSIONS}/src/caqtdm
# # bash ./caQtDM_BuildAll
SHELL ["/bin/bash", "-c"]
RUN \
  source ./caQtDM_Env \
  && qmake all.pro \
  && make "${MAKE_JOBS_N}" \
  2>&1 | tee -a "${LOG_DIR}/dockerfile.log"

ENV \
  QTDM_BININSTALL="${INSTALL_DIR}/bin/${EPICS_HOST_ARCH}/" \
  QTDM_LIBINSTALL="${INSTALL_DIR}/lib/${EPICS_HOST_ARCH}/"
RUN \
  mkdir -p "/opt/caQtDM/bin/${EPICS_HOST_ARCH}/" \
  mkdir -p "/opt/caQtDM/lib/${EPICS_HOST_ARCH}/" \
  && sed -e '/read -p/ s/^read/#read/' -i caQtDM_Install \
  && ./caQtDM_Install
