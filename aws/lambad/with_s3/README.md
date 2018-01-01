# s3 にファイルをアップロードしたら同盟のファイルをコピーする
https://dev.classmethod.jp/cloud/aws/1st-javascript-1st-lambda/

```
$ npm i async aws-sdk
$ zip -r with_s3.zip index.js node_modules/
```

```
var async = require('async');
var aws = require('aws-sdk');
var s3 = new aws.S3();

exports.handler = function(event, context) {
  var Bucket = event.Records[0].s3.bucket.name;
  var srcKey = event.Records[0].s3.object.key;
  var dstKey = "copy" + srcKey;

  if (srcKey.substr(0, 5) == 'copy-') {
    return;
  }
  async.waterfall([
    function download(callback) {
      console.log('download start:' + srcKey);
      s3.getObject({ Key: srcKey }, function(err, data) {
        if(err) { callback(err); }
        try { callback(null, data); } catch(e) { callback(e); }
      });
    },
    function upload(arg1, callback) {
      console.log('upload start:' + dstKey);
      console.log('data:' + args1.Body);
      s3.putObject({
        Bucket: Bucket,
        Key, dstKey,
        Body: args1.Body
      }, function(err, data) {
        if(err) { callback(err); }
        try { callback(null); } catch (e) { callback(e); }
      });
    }
  ], function(err) {
    if(err) { console.log('Error:' = err); }
    console.log('all done');
  });
}
```

* s3のイベントをトリガーとしてlambad関数を実行する、という設定が必要
* ログを出力するにはlambda関数実行ロールにcloudwatch logs権限がないとログを履いてくれない
  * ロググループを作成してこれない状態が続く
  * メトリクスは計測してくれているので実行していることはわかる
* ログを出力に成功すると下記のようになっていた。

```
module initialization error: ReferenceError
if(err) { console.log('Error:' = err); }
^^^^^^^^
ReferenceError: Invalid left-hand side in assignment
at createScript (vm.js:56:10)
at Object.runInThisContext (vm.js:97:10)
at Module._compile (module.js:542:28)
at Object.Module._extensions..js (module.js:579:10)
at Module.load (module.js:487:32)
at tryModuleLoad (module.js:446:12)
at Function.Module._load (module.js:438:3)
at Module.require (module.js:497:17)
```

* エラーになってるがイベントをトリガーにしてlabdaが動かない時に、何をみてトラブルシューティングすればいいかわかったので終了とする
