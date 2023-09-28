#!/bin/bash

# custom build script to build the hkl library

export PREFIX=/opt/hkl

bash ./step1-install-requirements.sh
bash ./step1b-build-local-libraries.sh
bash ./step2-download_source.sh
bash step3-build-library.sh

ls -lAFghR "${PREFIX}"
