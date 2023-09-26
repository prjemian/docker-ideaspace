FROM  condaforge/mambaforge
LABEL Name="mambaforge"

# docker pull condaforge/mambaforge
# docker run -i -t condaforge/mambaforge /bin/bash
# --------------
# docker build -t prjemian/try_hkl:latest ./
# docker run -i -t prjemian/try_hkl:latest /bin/bash

USER  root
CMD ["/bin/bash"]
WORKDIR /home

COPY hkl.tar.gz try_hkl.py .
RUN \
    conda \
    create \
    -n hkl \
    -y \
    gobject-introspection=1.66.1 \
    gsl=2.6 \
    hklpy \
    ipython \
    pygobject

# see: https://stackoverflow.com/questions/55123637
# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "hkl", "/bin/bash", "-c"]
# The code to run when container is started:
# ENTRYPOINT ["conda", "run", "-n", "hkl", "python3", "src/server.py"]

# and: https://pythonspeed.com/articles/activate-conda-dockerfile/
RUN \
    pushd "${CONDA_PREFIX}" \
    && tar xzf /home/hkl.tar.gz

RUN \
    python /home/try_hkl.py
