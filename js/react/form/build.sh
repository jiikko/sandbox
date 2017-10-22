#!/bin/bash

CMD=$(cat <<-EOF
babel --presets react,es2015 js -d tmp/js && browserify ./tmp/js/app.js -o bundle.js;
if [[ \$? = 0 ]]; then
  RESULT="success compile"
else
  RESULT="failure compile"
fi
echo \$RESULT | terminal-notifier
EOF
)
$(npm bin)/watch "$CMD" js
