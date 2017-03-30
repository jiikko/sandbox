http://dev.classmethod.jp/cloud/aws/manage-s3-lifecycle-via-cli/
# awscli から s3のライフサイクルを設定する

## ライフサイクルを設定していない時
```
$ aws s3api get-bucket-lifecycle-configuration --bucket yjiikko.github.com --profile s3test

An error occurred (NoSuchLifecycleConfiguration) when calling the GetBucketLifecycleConfiguration operation: The lifecycle configuration does not exist
```

## ライフサイクルを設定している時
* 設定はWEBから適当に行なった
```
$ aws s3api get-bucket-lifecycle-configuration --bucket yjiikko.github.com --profile s3test
{
    "Rules": [
        {
            "Filter": {
                "Prefix": ""
            },
            "Status": "Enabled",
            "Expiration": {
                "Days": 365
            },
            "ID": "test"
        }
    ]
}
```

## ライフサイクルを更新する
* 3650日で削除され、365日にglacierへ転送する
```json
$ cat /Users/koji/s3_rules.json
{
    "Rules": [
        {
            "Filter": {
                "Prefix": ""
            },
            "Status": "Enabled",
            "Transitions": [
              { "Days": 365,
                "StrageClass": "GLACIER"
            ],
            "Expiration": {
                "Days": 3650
            },
            "ID": "test"
        }
    ]
}
```

```
$ aws s3api put-bucket-lifecycle-configuration --bucket yjiikko.github.com --lifecycle-configuration file:///Users/koji/s3_rules.json --profile s3test
$ echo $?
0
```

* ライフサイクルを取得すると反映されている
```sh
$ aws s3api get-bucket-lifecycle-configuration --bucket yjiikko.github.com --profile s3test
{
    "Rules": [
        {
            "Filter": {
                "Prefix": ""
            },
            "Status": "Enabled",
            "Transitions": [
                {
                    "Days": 365,
                    "StorageClass": "GLACIER"
                }
            ],
            "Expiration": {
                "Days": 3650
            },
            "ID": "test"
        }
    ]
}
```

## ライフサイクルを削除する
```sh
koji@kojis-MacBook-Air[/Users/koji]$ aws s3api delete-bucket-lifecycle --bucket yjiikko.github.com --profile s3test
koji@kojis-MacBook-Air[/Users/koji]$ echo $?
0
```
```sh
$ aws s3api get-bucket-lifecycle-configuration --bucket yjiikko.github.com --profile s3test

An error occurred (NoSuchLifecycleConfiguration) when calling the GetBucketLifecycleConfiguration operation: The lifecycle configuration does not exist
```
