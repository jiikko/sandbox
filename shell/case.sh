#!/bin/bash

case $1 in
  -f)
    echo file
    ;;
  -d | --directory)
    echo directory
    ;;
  *)
    echo oh....

esac
