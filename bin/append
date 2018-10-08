#!/usr/bin/env bash

APPEND="$1"
TARGET="$2"

pcregrep -qM "$APPEND" "$TARGET" || echo "$APPEND" >> "$TARGET"
