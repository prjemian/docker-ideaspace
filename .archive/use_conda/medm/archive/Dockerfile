FROM  mambaorg/micromamba
LABEL Name="epics-medm" \
      Version="3.0.0" \
      Maintainer="prjemian <prjemian@gmail.com>" \
      Description="source: https://github.com/prjemian/epics-docker/"

    #   lastupdate="2023-04-07" \
USER  root

CMD ["/bin/bash"]
WORKDIR /home

ENV \
  APP_ROOT=/opt \
  MAMBA_ROOT_PREFIX=/opt/conda
COPY \
  ./env.yml \
  ./epics_medm.sh \
  ./medm_fonts.alias \
  /home

RUN \
    micromamba install \
    -y \
    --root-prefix "${MAMBA_ROOT_PREFIX}" \
    --prefix "${MAMBA_ROOT_PREFIX}" \
    --file env.yml
