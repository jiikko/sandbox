# AssumeRole
* 最大1時間限定で任意の権限を付与する
* 別のAWSアカウントからでも付与できる
* コンピュータに認証情報を保存しておくといつか漏洩してしまうリスクがある
  * 期日つきの認証情報を発行していると漏れても無害

# 手順
* コンソール
  * アクセス権限が何もないユーザ(以下`no_skill`ユーザ)を作成する
  * role を作成する
  * role に適当なアクセス許可を設定する
  * role の信頼関係 に先程作成した`no_skill`を許可するように記述する(jsonは後述する)
* cli
  * `~/.aws/credentials`, `~/.aws/profile` に`no_skill`ユーザの認証情報(`aws_access_key_id`, `aws_secret_access_key`)を記述する
  * コマンドを実行してrole に割り当てられているアクセス権限をもった認証情報を作成する
    * `aws sts assume-role --role-arn arn:aws:iam::111111111:role/s3_role --role-session-name s3_role --profile no_skill --duration-seconds 3600`(実行結果は後述)
  * 実行結果から `aws_access_key_id`, `aws_secret_access_key`, `aws_session_token` を  `~/.aws/credentials` に追記する(後述)
  * s3のバケット一覧をとってみる
    * `aws s3api list-buckets --profile s3_test` (実行結果は後述)

## 二段階認証にする
* 上記だと認証なしに特定の認証情報をいつでも発行できるので漏洩リスクは変わらない。 mfaを使う。
* ユーザにmfaの設定を済ませておいて認証情報発行時に引数として渡せばよい
* `aws sts assume-role --role-arn arn:aws:iam::111111111:role/s3_role --role-session-name s3_role --profile no_skill --duration-seconds 3600 --serial-number arn:aws:iam::111111111:mfa/no_skill --token-code 508114`

## 後述
### role の信頼関係 に先程作成した`no_skill`を許可する
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::111111111:user/no_skill",
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

### `aws sts assume-role --role-arn arn:aws:iam::111111111:role/s3_role --role-session-name s3_role --profile no_skill --duration-seconds 3600` の実行結果
```
$ aws sts assume-role --role-arn arn:aws:iam::111111111:role/s3_role --role-session-name s3_role --profile no_skill --duration-seconds 3600
{
    "AssumedRoleUser": {
        "AssumedRoleId": "AROAxxxxxxxxx:s3_role",
        "Arn": "arn:aws:sts::xxxxxxxxxxxx:assumed-role/s3_role/s3_role"
    },
    "Credentials": {
        "SecretAccessKey": "xxxxxxxxxxxxxxxxxxxxxxxxxxxx",
        "SessionToken": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
        "Expiration": "2017-04-02T15:08:23Z",
        "AccessKeyId": "xxxxxxxxxxx"
    }
}
```

### 実行結果から `aws_access_key_id`, `aws_secret_access_key`, `aws_session_token` を  `~/.aws/credentials` に追記する
```shell
credential=$(cat <<EOH
[s3_test]
aws_access_key_id = xxxxxxxxxxxxxxxxxxxxxxx
aws_secret_access_key = xxxxxxxxxxxxxxxxxxxxxxx
aws_session_token = xxxxxxxxxxxxxxxxxxxxxxx
)
EOH
echo "$credential" >> ~/.aws/credentials
```

### `aws s3api list-buckets --profile s3_test` の実行結果
```
$ aws s3 ls --profile s3_test
2014-06-25 20:03:53 xxx.com
2016-12-18 17:07:45 xxx.com
```

# リンク
* http://dev.classmethod.jp/cloud/aws/iam-role-and-assumerole/
* http://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-roles.htmltop
* http://qiita.com/ryo0301/items/0730e4b1068707a37c31
