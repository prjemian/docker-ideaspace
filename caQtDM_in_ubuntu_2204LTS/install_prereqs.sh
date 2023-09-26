#!/bin/bash

# install prerequisites for local building (& development)
#    EPICS base
#    caQtDM

# These steps require root permissions.

apt-get update  -y \
    && apt-get install -y  \
        apt-file \
        apt-utils \
        build-essential \
        git \
        less \
        libgl-dev \
        libgl1 \
        libgl1-mesa-dev \
        libqt5svg5-dev \
        libqt5x11extras5-dev \
        libqwt-qt5-dev \
        libreadline-dev \
        libusb-1.0-0-dev \
        libusb-dev \
        libzmq3-dev \
        nano \
        procps \
        python3-dev \
        python3-pip \
        qt5-qmake \
        qtbase5-dev \
        qtbase5-dev-tools \
        qtchooser \
        qttools5-dev \
        re2c \
        wget

apt-file update
