FROM  debian:bullseye
LABEL Name="sandbox"

USER  root
WORKDIR /home
CMD ["/bin/bash"]

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
  ./step1b-build-local-libraries.sh \
  ./step2-download_source.sh \
  ./step3-build-library.sh \
  ./

# export HKL_TAG="v5.0.0.3001"
# export HKL_TAG="v5.0.0.3357"

RUN \
  export HKL_REPO_URL="https://repo.or.cz/hkl.git" \
  export HKL_TAG="v5.0.0.3357" \
  && bash ./all_steps.sh

WORKDIR /opt/hkl
RUN tar czf /opt/libhkl.tar.gz */
