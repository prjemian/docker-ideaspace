#!/bin/bash

# usage:  source ./setup_environment.sh

# sets up the shell for building caQtDM
# makes certain that Anaconda Python is not providing Qt to the build

PATH=${HOME}/bin
PATH+=:/usr/local/sbin
PATH+=:/usr/local/bin
PATH+=:/usr/sbin
PATH+=:/usr/bin
PATH+=:/sbin
PATH+=:/bin
#PATH+=:/usr/games
#PATH+=:/usr/local/games
PATH+=:/usr/local/epics/base/bin/
PATH+=:/usr/local/epics/base/lib/
PATH+=:/usr/local/epics/opi/bin/
PATH+=:/usr/local/epics/base/bin/linux-x86_64
PATH+=:/usr/local/epics/base/lib/linux-x86_64
PATH+=:/usr/local/epics/opi/bin/linux-x86_64
export PATH

export PYTHONVERSION=3.8
export PYTHONINCLUDE=/usr/include/python${PYTHONVERSION}
export PYTHONLIB=/usr/lib/

export EPICS_BASE=/usr/local/epics/base
export EPICSINCLUDE=${EPICS_BASE}/include
export EPICSLIB=${EPICS_BASE}/lib/linux-x86_64
#export EPICSEXTENSIONS=/usr/local/epics/extensions
export EPICSEXTENSIONS=/usr/local/epics/opi

export QTHOME=/usr
export QWTHOME=/usr
export QWTINCLUDE=/usr/include/qwt
export QWTLIB=${QWTHOME}/lib/qwt

export QTCONTROLS_LIBS=/usr/local/epics/opi/src/caqtdm/caQtDM_Binaries
export CAQTDM_COLLECT=/usr/local/epics/opi/src/caqtdm/caQtDM_Binaries
export QTBASE=${QTCONTROLS_LIBS}

export QTDM_BININSTALL=${EPICSEXTENSIONS}/bin/${EPICS_HOST_ARCH}
export QTDM_LIBINSTALL=${EPICSEXTENSIONS}/lib/${EPICS_HOST_ARCH}

mkdir -p ${QTDM_BININSTALL}
mkdir -p ${QTDM_LIBINSTALL}

#export QTDM_RPATH=${QTDM_LIBINSTALL}:${QTBASE}
