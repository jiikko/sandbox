```
npm i --save-dev react react-dom babel-preset-react babel-preset-es2015
npm i --global babel-cli
npm i --global browserify
```

```
babel --presets react,es2015 js/source -d js/build && browserify ./js/build/app.js -o bundle.js
```
