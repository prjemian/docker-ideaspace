#!/bin/bash

git clone "${HKL_REPO_URL}"

cd hkl
git checkout --detach "${HKL_TAG}"
cd ..
