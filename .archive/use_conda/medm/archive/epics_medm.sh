#!/bin/bash

# Build the EPICS MEDM application

# Construct requisite directory structure
cd "${APP_ROOT}"
git clone https://github.com/epics-extensions/extensions
ls -lAFghR extensions/

# "${EPICS_BASE}/lib/${EPICS_HOST_ARCH}"
# "${CONDA_PREFIX}/lib"
# Update X11_LIB & MOTIF_LIB for X11 support directories
cd extensions
# EPICS_BASE=$(TOP)/../base
sed -i s+EPICS_BASE=\$\(TOP\)/../base+"EPICS_BASE=${EPICS_BASE}"+g configure/RELEASE
sed -i s+/usr/lib64+"${CONDA_PREFIX}/lib"+g configure/os/CONFIG_SITE.linux-x86_64.linux-x86_64

# Download source code package
cd src
MEDM_TARBALL=MEDM3_1_11.tar.gz
wget \
    -q \
    --no-check-certificate \
    "https://epics.anl.gov/download/extensions/${MEDM_TARBALL}"

tar xzf "${MEDM_TARBALL}"
ln -s $(ls | grep medm) ./medm

# Compile
# For missing packages, see https://wiki.debian.org/apt-file
# # Remove the requirement for libXp.so (X11 printing), it's impossible to install now.
# sed -i s+"Xt Xp Xmu"+"Xt Xmu"+g medm/medm/Makefile
make

# Install
make install
