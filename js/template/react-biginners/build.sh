#!/bin/bash

CMD=$(cat <<-EOF
babel --presets react,es2015 js/source -d js/build && browserify ./js/build/app.js -o bundle.js;
if [[ \$? = 0 ]]; then
  RESULT="success compile"
else
  RESULT="failure compile"
fi
echo \$RESULT | terminal-notifier
EOF
)
$(npm bin)/watch "$CMD" js/source
