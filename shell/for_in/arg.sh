#!/bin/sh


# loopされる
ls="README.md docs hoge.sh mysql rails ruby shell vimscript"
for i in $ls; do echo $i; done

# loopされない
for i in "README.md docs hoge.sh mysql rails ruby shell vimscript"; do echo $i; done

# loopされない
for i in "echo README.md docs hoge.sh mysql rails ruby shell vimscript"; do echo $i; done

# loopされる
list="echo README.md docs hoge.sh mysql rails ruby shell vimscript"
for i in $list; do echo $i; done

# loopされる
for i in `echo README.md docs hoge.sh mysql rails ruby shell vimscript`; do echo $i; done

# loopされる
for i in $(echo README.md docs hoge.sh mysql rails ruby shell vimscript); do echo $i; done

# loopされる
for i in `ls`; do echo $i; done
