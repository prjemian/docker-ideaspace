FROM  debian:bullseye
LABEL Name="sandbox"

USER  root
CMD ["/bin/bash"]
WORKDIR /home

# ------------------------------ docker developer UI
ENV \
  EDITOR="nano" \
  PROMPT_DIRTRIM=3

# developer tools
RUN DEBIAN_FRONTEND=noninteractive apt-get update  -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y  \
        less \
        nano

COPY \
    ./all_steps.sh \
    ./step1-install-requirements.sh \
    ./step2-download_source.sh \
    ./step3-build-library.sh \
    .

RUN bash ./all_steps.sh

WORKDIR /opt/hkl
RUN tar czf /opt/hkl.tar.gz */
