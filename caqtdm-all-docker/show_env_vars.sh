#!/bin/bash

# check for missing environment variables
# do NOT redefine ANYTHING

items=
items+=" CAQTDM_CA_ARCHIVELIBS"
items+=" CAQTDM_COLLECT"
items+=" CAQTDM_LOGGING_ARCHIVELIBS"
items+=" EPICS_BASE"
items+=" EPICS4LOCATION"
items+=" EPICSEXTENSIONS"
items+=" EPICSINCLUDE"
items+=" EPICSLIB"
items+=" PYTHONINCLUDE"
items+=" PYTHONLIB"
items+=" PYTHONVERSION"
items+=" QTCONTROLS_LIBS"
items+=" QTDM_BININSTALL"
items+=" QTDM_LIBINSTALL"
items+=" QTDM_RPATH"
items+=" QTHOME"
items+=" QWTHOME"
items+=" QWTINCLUDE"
items+=" QWTLIB"
items+=" QWTLIBNAME"
items+=" QWTVERSION"
items+=" TROLLTECH"
items+=" ZMQ"
items+=" ZMQINC"
items+=" ZMQLIB"

for item in $items; do
  if [ -z "${!item}" ]; then
    echo "# '${item}' does not exist"
  else
    echo "${item}=${!item}"
  fi
done
