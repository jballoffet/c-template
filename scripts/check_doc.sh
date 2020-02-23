#!/bin/bash

if [[ -s doc/doxygen_warning_log.txt ]]; then
  echo "Please fix doxygen warnings:"
  cat doc/doxygen_warning_log.txt
  exit -1
fi
