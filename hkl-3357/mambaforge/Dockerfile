FROM  condaforge/mambaforge
LABEL Name="mambaforge"

# docker build -t prjemian/try_hkl:latest ./
# docker run -i -t prjemian/try_hkl:latest /bin/bash

USER  root
CMD ["/bin/bash"]
WORKDIR /home

COPY \
    env.yml \
    libhkl.tar.gz \
    install-libhkl.sh \
    run-libhkl.sh \
    try_libhkl.py \
    /home/

# RUN conda env create --force -n hkl -f /home/env.yml
RUN conda env update -n base -f /home/env.yml
RUN conda init bash
# RUN bash /home/install-libhkl.sh
# RUN bash /home/run-libhkl.sh
