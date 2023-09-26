#!/bin/bash

# build caQtDM locally

source ./symbols.sh

mkdir -p \
    "${EPICS_EXT}/src" \
    "${EPICS_EXT}/include" \
    "${EPICS_EXT}/bin/${EPICS_HOST_ARCH}" \
    "${EPICS_EXT}/lib/${EPICS_HOST_ARCH}"
