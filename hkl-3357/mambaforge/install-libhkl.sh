#!/bin/bash

# conda activate hkl
tar xzf /home/libhkl.tar.gz -C "${CONDA_PREFIX}"
echo "VERSION: $(grep VERSION ${CONDA_PREFIX}/include/hkl-5/hkl.h)"
