#!/bin/sh

# クォートが必要？
if [ -f $1 ]; then
  echo success
else
  echo fail
fi

# ひかくする文字列の先頭にxを記述するという手法は広く使われています。こうすれば、変数の値がハイフンから始まっている場合に、変数を展開した結果がtestコマンドとみなさあああああれてしまうのを防げます。
# test "x$envvar" = "xPATH"
