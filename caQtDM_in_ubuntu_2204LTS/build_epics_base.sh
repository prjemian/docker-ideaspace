#!/bin/bash

# build caQtDM locally

source ./symbols.sh

mkdir -p "${APP_ROOT}"
cd "${APP_ROOT}" || exit
wget -q ${EPICS_DOWNLOADS_URL}/${EPICS_BASE_NAME}.tar.gz

tar xzf "${EPICS_BASE_NAME}.tar.gz"
rm  "${EPICS_BASE_NAME}.tar.gz"
ln -s "${EPICS_BASE_NAME}" base
ls -lAFgh

export EPICS_HOST_ARCH="$(${EPICS_BASE}/startup/EpicsHostArch)"
export PATH="${PATH}:${EPICS_BASE}/bin/${EPICS_HOST_ARCH}"
echo "" >> ~/.bash_aliases
echo "# EPICS base symbols" >> ~/.bash_aliases
echo "EPICS_BASE_VERSION=${EPICS_BASE_VERSION}" >> ~/.bash_aliases
echo "EPICS_HOST_ARCH=${EPICS_HOST_ARCH}" >> ~/.bash_aliases
echo "PATH=\${PATH}:${EPICS_BASE}/bin/${EPICS_HOST_ARCH}" >> ~/.bash_aliases
echo "PATH=\${PATH}:${EPICS_EXT}/bin/${EPICS_HOST_ARCH}" >> ~/.bash_aliases

cd "${EPICS_BASE}" || exit
make \
    "${MAKE_JOBS_N}" \
    all \
    CFLAGS="-fPIC" \
    CXXFLAGS="-fPIC"
make clean
