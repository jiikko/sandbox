#!/bin/sh

CMD="babel --presets react,es2015 js/source -d js/build && browserify ./js/build/app.js -o bundle.js"
$(npm bin)/watch "$CMD" js/source
