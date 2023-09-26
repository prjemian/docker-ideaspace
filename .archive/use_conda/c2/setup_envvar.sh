#!/bin/bash

# usage:  source ./setup_environment.sh

# sets up the shell for building caQtDM

export PYTHONVERSION=3.11
export PYTHONINCLUDE=/usr/include/python${PYTHONVERSION}
export PYTHONLIB=/usr/lib/python${PYTHONVERSION}

# export EPICS_BASE=/usr/local/epics/base
export EPICSINCLUDE="${EPICS_BASE}/include"
export EPICSLIB="${EPICS_BASE}/lib/${EPICS_HOST_ARCH}"
export EPICSEXTENSIONS=${EPICS_BASE}/extensions

export QTHOME=/usr
export QWTLIBNAME=qwt-qt5
export QWTHOME=$QTHOME
export QWTINCLUDE=/usr/include/qwt
# export QWTLIB=${QWTHOME}/lib/qwt

export QTCONTROLS_LIBS=${EPICSEXTENSIONS}/src/caqtdm/caQtDM_Binaries
export CAQTDM_COLLECT=${EPICSEXTENSIONS}/src/caqtdm/caQtDM_Binaries
export QTBASE=${QTCONTROLS_LIBS}

export QTDM_BININSTALL=${EPICSEXTENSIONS}/bin/${EPICS_HOST_ARCH}
export QTDM_LIBINSTALL=${EPICSEXTENSIONS}/lib/${EPICS_HOST_ARCH}

mkdir -p ${QTDM_BININSTALL}
mkdir -p ${QTDM_LIBINSTALL}

#export QTDM_RPATH=${QTDM_LIBINSTALL}:${QTBASE}

# make certain that Anaconda Python is not providing Qt to the build
PATH=${HOME}/bin
PATH+=:/usr/local/sbin
PATH+=:/usr/local/bin
PATH+=:/usr/sbin
PATH+=:/usr/bin
PATH+=:/sbin
PATH+=:/bin
#PATH+=:/usr/games
#PATH+=:/usr/local/games
PATH+=:${EPICS_BASE}/bin/
PATH+=:${EPICS_BASE}/lib/
PATH+=:${EPICSEXTENSIONS}/bin/
PATH+=:${EPICS_BASE}/bin/${EPICS_HOST_ARCH}
PATH+=:${EPICS_BASE}/lib/${EPICS_HOST_ARCH}
PATH+=:${EPICSEXTENSIONS}/bin/${EPICS_HOST_ARCH}
export PATH
