#!/bin/sh

# Usage:
#   $ puzzle-help.sh a.......z
# みたいに使う


dic="/usr/share/dict/words /Users/koji/hints.rb"
# -f: ファイル名を省略. 複数ファイルがあると表示される
# -i: case insentive
grep -h -i "$1" $dic | fmt
