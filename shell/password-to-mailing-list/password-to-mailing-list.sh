#!/bin/sh

pid=${$}
tmpfile="/tmp/${pid}_tmp_password"
rm -f /tmp/${pid}_*.mailing-list
rm -f $tmpfile

# osxには一般ユーザないし
$(cat << PWD > $tmpfile
test:*:0:0:System Administrator:/var/root:/bin/bash
taro:*:0:0:System Administrator:/var/root:/bin/ksh
rin:*:0:0:System Administrator:/var/root:/bin/sh
take:*:0:0:System Administrator:/var/root:/bin/bash
hei:*:0:0:System Administrator:/var/root:/bin/ksh
PWD
)

IFS=:
cat $tmpfile | while read user password uid gid name home shell; do
  shell_name=$(echo $shell | sed -e "s|/bin/\(.*\)$|\1|")
  echo ${user}, >> /tmp/${pid}_${shell_name}.mailing-list
done

for mailing_list in /tmp/${pid}_*.mailing-list; do
  echo --${mailing_list}--
  cat $mailing_list
done

rm $tmpfile
rm -f /tmp/${pid}_*.mailing-list
