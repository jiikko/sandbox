# trace_condition_say_command

はいが2回出力される
```
echo 'hai' | say; echo 'hai' | say
```

はいが1回出力される
```
echo 'hai' | say &; echo 'hai' | say
```


pipe を使って排他制御しようと思ったけどpipe への書き込みと出力の間で他のプロセスをブロックしないできない。

```shell
#!/bin/bash

if [[ $(file /tmp/say_pipe | grep 'named pipe') ]]; then
  echo 'hello pipe'
else
  rm -f /tmp/say_pipe
  mkfifo /tmp/say_pipe
fi
sleep 1

echo 'こんにちわ' > /tmp/say_pipe &
cat /tmp/say_pipe | say
```

```
sh say.sh &; sh say.sh
```
