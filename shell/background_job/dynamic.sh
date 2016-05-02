#!/bin/bash

pids=()

list="undefined_cmd ls pwd"
pno=1 # list[0] is bad range.
for cmd in $list; do
  $cmd > /dev/null 2>&1 &
  pids[$pno]=$!
  ((pno=pno + 1))
done

for pid in ${pids[@]}; do
  if ! wait $pid; then
    echo 'found fail commands'
    exit 1
  fi
done
wait
