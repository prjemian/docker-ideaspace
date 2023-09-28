#!/bin/bash

git clone "${HKL_REPO_URL}"

pushd hkl
git checkout --detach "${HKL_TAG}"
popd
