#/bin/sh

# 後方置換
cat sample_texts/filelist.txt | sed 's| { \(.*\)|\1\1|'

# 2
echo 'abc-target-bbb-ccc' | sed -e "s|^[a-z]*-\([a-z]*\)-[a-z]*-[a-z]*|\1|"
