#!/bin/bash

DEBIAN_FRONTEND=noninteractive apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y \
        apt-file \
        apt-utils \
        build-essential \
        git \
        less \
        libgl1 \
        libgl-dev \
        nano \
        wget \
    && DEBIAN_FRONTEND=noninteractive apt-file update

# TODO: replace git with wget and the gzip archive
git clone https://github.com/caqtdm/caqtdm
cd caqtdm
export SRC_DIR=$(readlink -f .)

mkdir -p ./caQtDM_Binaries/{designer,controlsystems}

export EPICSEXTENSIONS="${EPICS_BASE}/extensions"
export QTHOME="${CONDA_PREFIX}"

export PYTHONINCLUDE="${CONDA_PREFIX}/include"
export PYTHONLIB="${CONDA_PREFIX}/lib"
export PYTHONVERSION=3.10
export QTBASE="$(readlink -f .)/caQtDM_Binaries"
export QTDM_RPATH="${EPICSEXTENSIONS}/lib/${EPICS_HOST_ARCH}:/binQt:${QTBASE}"
export QWTHOME="${QTHOME}"
export QWTINCLUDE="${QTHOME}/include"
export ZMQINC="${CONDA_PREFIX}/include"
export ZMQLIB="${CONDA_PREFIX}/lib"

# copy the OpenGL libraries and headers into CONDA_PREFIX directories
# per https://github.com/conda-forge/pygridgen-feedstock/issues/10#issuecomment-365985484
pushd "${CONDA_PREFIX}/lib"
cp /usr/lib/x86_64-linux-gnu/libGL.so.1.7.0 ./
ln -s ./libGL.so.1.7.0 ./libGL.so.1
ln -s ./libGL.so.1 ./libGL.so
cd ../include  # Where SHOULD these files go?
mkdir -p GL
cd GL
cp -r  /usr/include/GL/* ./
popd

cd "${SRC_DIR}"
# caQtDM_QtControls/src/castripplot.cpp needs `#include <math.h>`
# per https://github.com/CogChameleon/ChromaTag/issues/3#issuecomment-763602066
sed -i~ "30i#include <math.h>" caQtDM_QtControls/src/castripplot.cpp

# # # skip the prompt to continue
# # sed -i~ s+^read+"# read"+g ./caQtDM_BuildAll
# # bash ./caQtDM_BuildAll

echo ============ make all =================
qmake all.pro
#scan-build --use-analyzer Xcode make -j8
make -j8


# # for missing libraries: apt-file search GL/gl.h
# # apt update && apt install apt-file && apt-file update
