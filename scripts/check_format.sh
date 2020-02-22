#!/bin/bash

if [[ -n $(git diff) ]]; then
  echo "Please run make format"
  exit -1
fi
