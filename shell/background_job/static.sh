#!/bin/sh

(sleep 1; undefined_cmd) &
cmd_p=$!
(sleep 1; undefined_cmd) &
cmd_p2=$!
(sleep 1; ls) &
cmd_p3=$!

wait $cmd_p
echo cmd_p: $?

wait $cmd_p2
echo cmd_p2:$?

wait $cmd_p3
echo cmd_p3:$?
