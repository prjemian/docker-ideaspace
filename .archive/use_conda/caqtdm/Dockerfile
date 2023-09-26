FROM  prjemian/epics-base:3.0.0
# FROM  debian:12-slim
LABEL Name="epics-caqtdm" \
      Version="latest" \
      Maintainer="prjemian <prjemian@gmail.com>" \
      Description="source: https://github.com/prjemian/"

USER  root

CMD ["/bin/bash"]

ENV \
  APP_ROOT=/opt \
  MAMBA_ROOT_PREFIX=/opt/conda

WORKDIR /home
# COPY \
#   ./build-caqtdm.sh \
#   ./env.yml \
#   ./no_conda.sh \
#   ./

# RUN \
#     micromamba install \
#     -y \
#     --root-prefix "${MAMBA_ROOT_PREFIX}" \
#     --prefix "${MAMBA_ROOT_PREFIX}" \
#     --file env.yml

# RUN bash build-caqtdm.sh 2>&1 | tee ./build.log
