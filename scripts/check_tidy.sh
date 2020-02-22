#!/bin/bash

if [[ -n $(grep "warning: " ../tidy_log.txt) ]] || [[ -n $(grep "error: " ../tidy_log.txt) ]]; then
  echo "Please fix ClangTidy warnings and/or errors:"
  grep --color -E '^|warning: |error: ' ../tidy_log.txt
  exit -1
fi
