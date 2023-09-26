# Build EPICS GUI applications

**Summary**: As [advised in SO](https://stackoverflow.com/questions/65642916/running-a-qt-gui-in-a-docker-container),

> You can't run GUI applications in Docker "without much hassle"; you need administrator-level permission and to manually configure several details of the X Window System connection setup. A native binary will be much easier for your end users.

Try building a conda package instead.
Try it in a docker image.

- [MEDM](https://anaconda.org/conda-forge/epics-medm)
