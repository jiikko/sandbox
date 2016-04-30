#!/bin/sh

# クォートが必要？
if [ -f $1 ]; then
  echo success
else
  echo fail
fi
