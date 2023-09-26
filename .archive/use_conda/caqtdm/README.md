# CaQtDM as conda package

- [home](https://caqtdm.github.io/)
- [source](https://github.com/caqtdm/caqtdm)

## Build notes

Unconfigured, as downloaded from github, this output from
calling `bash ./caQtDM_BuildAll`:

```bash
QTHOME now defined as /usr for locating Qt
QWTHOME now defined as /usr for locating qwt
QWTINCLUDE now defined as /usr/include/qwt for locating the include files of qwt
QWTLIB now defined as /usr/lib for locating the libraries of qwt
EPICS_BASE now defined as /opt/conda/epics for locating epics
EPICSINCLUDE now defined as /opt/conda/epics/include for locating epics include files
EPICSLIB now defined as /opt/conda/epics/lib/linux-x86_64 for locating epics libraries
QTBASE now defined as /home/caqtdm/caQtDM_Binaries for building the package locally, pointing to caQtDM_Binaries
QTDM_RPATH now defined as /usr/local/epics/extensions/lib/linux-x86_64:/binQt:/home/caqtdm/caQtDM_Binaries for runtime search path

libraries for channel access archive and logging archive:

CAQTDM_LOGGING_ARCHIVELIBS now defined as /home/caqtdm/caQtDM_Binaries for logging archive rpc library
CAQTDM_CA_ARCHIVELIBS now defined as /home/caqtdm/caQtDM_Binaries for channel access archive library

for python:

PYTHONVERSION now defined as 2.6 for locating python
PYTHONINCLUDE now defined as /usr/include/python2.6 for locating python include files
PYTHONLIB now defined as /usr/lib/ for locating python libraries

for zmq:

ZMQINC now defined as /usr/local/include for locating zmq include files
ZMQLIB now defined as /usr/local/lib for locating zmq libraries

for install:

EPICSEXTENSIONS now defined as /usr/local/epics/extensions for locating epics extensions
QTDM_LIBINSTALL now defined as /usr/local/epics/extensions/lib/linux-x86_64 for libraries install
QTDM_BININSTALL now defined as /usr/local/epics/extensions/bin/linux-x86_64 for binaries install
============================================================================================
```

## Next Unresolved Build Error

```bash
src/castripplot.cpp: In member function 'virtual QwtText TimeScaleDraw::label(double) const':
src/castripplot.cpp:68:39: error: 'floor' was not declared in this scope; did you mean 'std::chrono::floor'?
   68 |         double normalized = v - day * floor(v/day);
      |                                       ^~~~~
      |                                       std::chrono::floor
```

Per this [comment](https://github.com/CogChameleon/ChromaTag/issues/3#issuecomment-763602066),
`caQtDM_QtControls/src/castripplot.cpp` needs `#include <math.h>` after these [lines](https://github.com/caqtdm/caqtdm/blob/9abca43e8b4aa3fbf0d9aa766f5b0a136c3d1027/caQtDM_QtControls/src/castripplot.cpp#L28-L29):

```cpp
#include <windows.h>
#include <float.h>
```

Solved by this advice:
https://stackoverflow.com/questions/487894/how-can-i-add-a-line-to-a-file-in-a-shell-script

sed -i~ "29i#include <math.h>" caQtDM_QtControls/src/castripplot.cpp

## Next Unresolved Build Error

