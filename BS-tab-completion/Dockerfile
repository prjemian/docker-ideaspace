FROM  continuumio/miniconda3
LABEL Name="sandbox"

USER  root
CMD ["/bin/bash"]
SHELL ["/bin/bash", "--login", "-c"]
ENV HOME /root
WORKDIR "${HOME}"

# ------------------------------ docker developer UI
ENV \
      PROMPT_DIRTRIM=3 \
      BLUESKY_CONDA_ENV=bluesky_2023_2 \
      BLUESKY_DIR="${HOME}/bluesky" \
      IPYTHON_DIR="${HOME}/.ipython"
RUN conda install -y conda-libmamba-solver

ADD \
      https://raw.githubusercontent.com/BCDA-APS/bluesky_training/main/bluesky/environments/environment_2023_2.yml \
      ./env.yml
RUN \
      conda env create \
            --force \
            -n "${BLUESKY_CONDA_ENV}" \
            -f ./env.yml \
            --solver=libmamba \
      && conda init bash

RUN conda env list
RUN which python
RUN echo "${BLUESKY_CONDA_ENV}"

# ref: https://pythonspeed.com/articles/activate-conda-dockerfile/
# Too bad an env var (${BLUESKY_CONDA_ENV}) fails when used here
SHELL ["conda", "run", "-n", "bluesky_2023_2", "/bin/bash", "-c"]
RUN which python
RUN ls -lAFgh "${HOME}/"
ADD \
      https://raw.githubusercontent.com/BCDA-APS/bluesky_training/main/new_bluesky_instrument.py \
      "${HOME}/"

RUN python "${HOME}/new_bluesky_instrument.py" "${BLUESKY_DIR}"
RUN mkdir -p "${IPYTHON_DIR}"
RUN ipython profile create bluesky --ipython-dir="${IPYTHON_DIR}"
RUN /bin/cp \
      "${BLUESKY_DIR}/console/__start_bluesky_instrument__.py" \
      "${IPYTHON_DIR}/profile_bluesky/startup/"
RUN sed -i s:ipython-bluesky:ipython:g "${BLUESKY_DIR}/blueskyStarter.sh"
WORKDIR "${BLUESKY_DIR}"
