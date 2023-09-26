#!/bin/bash

# build caQtDM locally

source ./symbols.sh

echo "EPICS_EXT: ${EPICS_EXT}"

cd "${EPICS_EXT}/src" || exit

# wget \
#     -q \
#     "${CAQTDM_DOWNLOAD_URL}/${CAQTDM_VERSION}.tar.gz"

# tar xzf "${CAQTDM_VERSION}.tar.gz"
# rm "${CAQTDM_VERSION}.tar.gz"

git clone https://github.com/caqtdm/caqtdm

cd "$(ls | grep caqtdm)" || exit

# git checkout "${CAQTDM_VERSION}"

# caQtDM uses the symbol "EPICSEXTENSIONS"
export EPICSEXTENSIONS="${EPICS_EXT}"
export QWTINCLUDE=/usr/include/qwt
export QWTLIBNAME=qwt-qt5

# comment the "press enter to continue"
sed -i s:^read:"# read":g ./caQtDM_BuildAll
./caQtDM_BuildAll 2>&1 | tee make.log

# # Do what caQtDM_BuildAll does, without the Q&A.
# export PYTHONINCLUDE="/usr/include/python${PYTHONVERSION}"
# export PYTHONLIB="/usr/lib/python${PYTHONVERSION}"

# export ZMQ="/usr"

# export QTHOME=/usr
# export QTBASE="${CAQTDM_SOURCE}"
# export QTDM_RPATH="${EPICS_BASE}/lib/${EPICS_HOST_ARCH}:${QTBASE}"
# export QWTHOME="${QTHOME}"

# export CAQTDM_SOURCE="${EPICS_EXT}/src/caqtdm"
# export CAQTDM_COLLECT="${CAQTDM_SOURCE}/caQtDM_Binaries"

# source ./caQtDM_Env
# qmake all.pro 2>&1 | tee qmake.log
# make "${MAKE_JOBS_N}" 2>&1 | tee make.log

# comment the "press enter to continue"
sed -i s:^read:"# read":g ./caQtDM_Install
./caQtDM_Install
