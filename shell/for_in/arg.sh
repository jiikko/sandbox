#!/bin/sh


# loopされる
ls="README.md docs hoge.sh mysql rails ruby shell vimscript"
for i in $ls; do
  echo $i
done

# loopされない
echo '----------'
for i in "README.md docs hoge.sh mysql rails ruby shell vimscript"; do
  echo $i
done

# loopされる
echo '----------'
for i in `ls`; do
  echo $i
done
