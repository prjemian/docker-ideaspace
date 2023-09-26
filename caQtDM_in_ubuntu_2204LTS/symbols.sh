#!/bin/bash

# for the developer
export EDITOR="nano"
export PROMPT_DIRTRIM=3

# symbols to build caQtDM locally

# Did it compile?
# compiled  EPICS BASE  caQtDM
# no        7.0.7       V4.4.0
# no        7.0.7       V4.3.0
# no        7.0.7       V4.2.4
# no        7.0.5       V4.4.0
# no        7.0.3       V4.4.0
# yes       7.0.2       V4.4.0
# yes       7.0.7       V4.4.1-rc8

export CAQTDM_VERSION=V4.4.1-rc8
export EPICS_BASE_VERSION=7.0.7
export PYTHONVERSION=3.11

export APP_ROOT=/opt/epics
export LOG_FILE="${LOG_DIR}/build-base.log"
export MAKE_JOBS_N=-j8

export EPICS_HOST_ARCH=linux-x86_64
export EPICS_BASE_NAME=base-${EPICS_BASE_VERSION}
export EPICS_BASE="${APP_ROOT}/${EPICS_BASE_NAME}"
export EPICS_EXT=${APP_ROOT}/extensions
export EPICS_DOWNLOADS_URL=https://epics.anl.gov/download/base

export CAQTDM_DOWNLOAD_URL=https://github.com/caqtdm/caqtdm/archive/refs/tags
