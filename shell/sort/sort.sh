#!/bin/sh

# 区切り文字、並び替えキー
cat passwd | sort -t: -k1,1 | less

# user id でソート
cat passwd | sort -t: -k3 -n | less
