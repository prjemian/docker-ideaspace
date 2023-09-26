#!/bin/bash

# Build the EPICS MEDM application

# Construct requisite directory structure
cd "${APP_ROOT}"
git clone https://github.com/epics-extensions/extensions
ls -lAFghR extensions/

# Update for X11 support directories
cd extensions
sed -i s+/usr/lib64+/usr/lib/x86_64-linux-gnu/+g configure/os/CONFIG_SITE.linux-x86_64.linux-x86_64

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
# Remove the requirement for libXp.so (X11 printing), it's impossible to install now.
sed -i s+"Xt Xp Xmu"+"Xt Xmu"+g medm/medm/Makefile
make

# Install
make install
