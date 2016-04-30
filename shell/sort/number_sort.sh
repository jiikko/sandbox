#!/bin/bash

# why $text without \n
text=$(cat << EOH > /tmp/sandbox_sort_origin_text
  ddd 102 111
  aaa 8   111
  ccc 33  111
  bbb 999 999
EOH
)
cat /tmp/sandbox_sort_origin_text | sort -k2 -n -r
# echo $text | sort -k2
rm /tmp/sandbox_sort_origin_text
