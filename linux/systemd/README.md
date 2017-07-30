# systemd
## systemd にするといいこと
* 従来のsysvinit では、pid でのプロセス管理は難しかった(pidファイルとアクティブなプロセスpidの不一致とか起きるし実質管理できてない)
  * プロセスの監視デーモンが別途必要だったがsystemdのみで管理できる
  * systemd ではfork後のプロセスもまとめてkillしたりできる
* 標準出力と標準エラーをまとめて管理できる
* systemd構文で記述できるのでシェルスクリプトを読むより管理しやすい
* 設定を記述することで chroot と同様な振る舞いができる
* 指定したユーザ/グループのみが実行できる制限をかけれる

## 概要
* ユニットの種類
  * device
  * mount
  * service
  * target
  * swap
* ファイル名がunit名になる

## コマンド
* service list
  * `systemctl`
* update status of service
  * `systemctl enable httpd.service`
  * `systemctl disable httpd.service`
  * `systemctl mask httpd.service`
  * `systemctl unmask httpd.service`
  * `systemctl start httpd.service`
  * `systemctl stop httpd.service`
  * `systemctl status httpd.service`
* kill service
  * cgroupでプロセスをマークしているのでworkerが複数あるプロセスすべてに対してシグナルをおくれる
    * `systemctl kill -s9 httpd.service`

* show log
  * mainプロセスの標準出力と標準エラーを `/lib/systemd/systemd-journald` が管理する
  * sudo journalctl -u postfix.service
  * sudo journalctl -u ssh.service
  * sudo journalctl -o json-pretty -u ssh.service
* generator
  * `/usr/lib/systemd/generator` に自動生成している設定ファイルがある
    * upgrade時に既存のserviceから生成したファイルだと思う

## その他
* ランレベルは `default.target`
* service 単位での top コマンドがある
  * `systemd-cgtop`
