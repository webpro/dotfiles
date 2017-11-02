#!/usr/bin/env bash

if [ $# -eq 1 ]; then
  if eval "$1" > /dev/null 2>&1; then 
    exit 0
  else
    exit 1
  fi
else
  if eval "$1" > /dev/null 2>&1; then
    echo -n "$2"
  else
    echo -n "$3"
  fi
fi
