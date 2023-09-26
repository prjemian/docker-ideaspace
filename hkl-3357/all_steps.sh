#!/bin/bash

# custom build script to build the hkl library

export HKL_REPO_URL="https://repo.or.cz/hkl.git"
export HKL_TAG="v5.0.0.3001"
# export HKL_TAG="v5.0.0.3357"
export PREFIX=/opt/hkl

bash ./step1-install-requirements.sh
bash ./step2-download_source.sh

cd hkl/ || exit
bash ../step3-build-library.sh

ls -lAFghR "${PREFIX}"
