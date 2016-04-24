#!/bin/sh

line='name:age:area:comment'
cmd="$line | cut -d : -f 2"
echo "cmd: $cmd"
echo `echo $cmd`
echo "cutted: "
