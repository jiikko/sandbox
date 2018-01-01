# https://dev.classmethod.jp/cloud/aws/1st-javascript-1st-lambda/
## npmパッケージをzipにかためて実行する
```
$ npm i async
```
```
var async = require('async');
exports.handler = function(event, context) {
  async.series([
    function(callback) {
      console.log("one");
      callback(null, "one");
    },
    function(callback) {
      console.log('tw');
      callback(null, 'two');
    },
    function(callback) {
      console.log('three');
      callback(null, 'three');
    }
  ], function(err, results) {
    if(err) {
      throw err;
    }
    console.log('all done.' + results);
  });
};
```

```
$ zip -r test_lambad.zip index.js node_modules/
```

zipをアップオードして実行すると下記出力になる
```
START RequestId: 4eae2c10-eee8-11e7-a8e1-8dd45dfd71f2 Version: $LATEST
2018-01-01T11:38:38.107Z	4eae2c10-eee8-11e7-a8e1-8dd45dfd71f2	one
2018-01-01T11:38:38.165Z	4eae2c10-eee8-11e7-a8e1-8dd45dfd71f2	tw
2018-01-01T11:38:38.165Z	4eae2c10-eee8-11e7-a8e1-8dd45dfd71f2	three
2018-01-01T11:38:38.166Z	4eae2c10-eee8-11e7-a8e1-8dd45dfd71f2	all done.one,two,three
END RequestId: 4eae2c10-eee8-11e7-a8e1-8dd45dfd71f2
REPORT RequestId: 4eae2c10-eee8-11e7-a8e1-8dd45dfd71f2	Duration: 122.85 ms	Billed Duration: 200 ms 	Memory Size: 128 MB	Max Memory Used: 21 MB	
```
