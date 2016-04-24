#/bin/sh

# 後方置換
cat sample_texts/filelist.txt | sed 's| { \(.*\)|\1\1|'
