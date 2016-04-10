#!/bin/bash

name=''
/bin/bash -c 'export name=sandbox-2'
echo $name

name=''
false ${name:='sandbox-1'}
echo $name

name=''
true ${name:='sandbox0'}
echo $name

name=''
: ${name:='sandbox1'}
echo $name

name=''
if [[ $name = '' ]]; then
  name=sandbox2
fi
echo $name

name=''
[[ $name = '' ]] && name=sandbox3
echo $name
