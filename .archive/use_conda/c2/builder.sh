#!/bin/bash

# set -e

# echo "alias ll='/bin/ls -lAFh --color=auto '" >> ~/.bashrc
# alias ll='/bin/ls -lAFh --color=auto '

# DEBIAN_FRONTEND=noninteractive apt update \
#     && DEBIAN_FRONTEND=noninteractive apt install -y \
#         apt-file \
#         libgl-dev \
#         libgl1 \
#         libgl1-mesa-dev \
#         libqt5svg5-dev \
#         libqwt-qt5-dev \
#         libzmq3-dev \
#         python3-dev \
#         python3-pip \
#         qt5-qmake \
#         qtbase5-dev \
#         qtbase5-dev-tools \
#         qttools5-dev \
#         qtchooser \
#     && DEBIAN_FRONTEND=noninteractive apt-file update
#     # && DEBIAN_FRONTEND=noninteractive apt install -y \
#     #     apt-utils \
#     #     nano \
#     #     wget \

CAQTDM_RELEASE=V4.4.0
CAQTDM_RELEASE=V4.3.0
CAQTDM_RELEASE=V4.2.4
# git clone https://github.com/caqtdm/caqtdm
# # TODO: replace git with wget and the gzip archive
# # wget https://github.com/caqtdm/caqtdm/archive/refs/tags/"${CAQTDM_RELEASE}".tar.gz
cd caqtdm || exit
git checkout "${CAQTDM_RELEASE}"
CAQTDM_SRC=$(readlink -f .)
export CAQTDM_SRC  # two-step per recommneded practice for security
export CAQTDM_COLLECT="${CAQTDM_SRC}/caQtDM_Binaries"

mkdir -p "${CAQTDM_COLLECT}"/{designer,controlsystems}

export EPICSINCLUDE="${EPICS_BASE}/include"
export EPICSLIB="${EPICS_BASE}/lib/${EPICS_HOST_ARCH}"
# export EPICSEXTENSIONS="${APP_ROOT}/extensions"
export QTHOME=/usr
export QWTLIBNAME=qwt-qt5

export PYTHONVERSION=3.11
export PYTHONINCLUDE="/usr/include/python${PYTHONVERSION}"
export PYTHONLIB="/usr/lib/python${PYTHONVERSION}"
QTBASE=$(readlink -f .)/caQtDM_Binaries
export QTBASE
export QTDM_RPATH="${EPICSLIB}:${QTBASE}"
export QWTHOME="${QTHOME}"
export QWTINCLUDE="${QWTHOME}/include/qwt"
export ZMQINC="/usr/include"
export ZMQLIB="/usr/lib"


echo ========= Construct EPICS extensions directory structure ==========
# pushd "${APP_ROOT}" || exit
# git clone https://github.com/epics-extensions/extensions
# ls -lAFghR extensions/
# popd
# export EPICSEXTENSIONS="${APP_ROOT}/app"
mkdir -p "${EPICSEXTENSIONS}"/{include,{bin,lib}/"${EPICS_HOST_ARCH}"}

source caQtDM_Env

echo ============ make all =================
qmake all.pro
#scan-build --use-analyzer Xcode make -j8
make -j8
