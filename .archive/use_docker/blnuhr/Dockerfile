FROM  mambaorg/micromamba:latest
LABEL Name="blnuhr" \
      Maintainer="prjemian <prjemian@gmail.com>" \
      Description="source: https://github.com/prjemian/epics-docker/"

    #   lastupdate="2023-04-07" \
USER  root

CMD ["/bin/bash"]
WORKDIR /home

# https://stackoverflow.com/questions/25281992/alternatives-to-ssh-x11-forwarding-for-docker-containers
# https://stackoverflow.com/questions/43613474/using-x11-forwarding-for-docker-containers
# https://jaydenm.com/blog/docker-x11-desktop/
# https://docs.docker.com/get-started/02_our_app/
# https://unix.stackexchange.com/questions/481532/x11-error-when-run-as-a-docker-container
# https://github.com/mviereck/x11docker

RUN DEBIAN_FRONTEND=noninteractive apt-get update  -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y  \
        libgl1 libglib2.0-0

ENV MM_ROOT="/home/mm"
ENV MM_ENV="${MM_ROOT}/envs/blnuhr"
RUN \
  micromamba create \
    --root-prefix mm \
    --prefix "${MM_ENV}" \
    -y \
    -c defaults \
    -c conda-forge \
    "pyqt=5" \
    pip \
    libglib
RUN ${MM_ENV}/bin/pip install blnuhr

RUN ls -lAFgh "${MM_ENV}/bin/blnuhr"

# https://stackoverflow.com/questions/35040020/gui-qt-application-in-a-docker-container
# Available platform plugins are: eglfs, minimal, minimalegl, offscreen, vnc, webgl, xcb.

ENV APP=/home/blnuhr.sh
RUN \
  (echo "#!/bin/bash" > "${APP}") \
  && (echo "export QT_QPA_PLATFORM=offscreen" >> "${APP}") \
  && (echo "export QT_GRAPHICSSYSTEM=native" >> "${APP}") \
  && (echo "${MM_ENV}/bin/blnuhr &" >> "${APP}") \
  && (chmod +x "${APP}")
