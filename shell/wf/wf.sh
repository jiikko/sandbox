#!/bin/bash

cat $1 | \
  ruby -ne 'puts $_.gsub(/[^a-zA-Z]+/, "\n").strip.gsub(/\n\n/, "")' | \
  sort | \
  uniq -c | \
  sort -k1 -r | \
  head -n30
