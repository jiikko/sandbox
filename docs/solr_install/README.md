# Solr Install for Production
see https://cwiki.apache.org/confluence/display/solr/Taking+Solr+to+Production

## ゴール
* railsから接続して検索できる

## Solr のインストール
```
sudo apt-get install openjdk-8-jre -y
wget http://ftp.jaist.ac.jp/pub/apache/lucene/solr/6.0.0/solr-6.0.0.tg
tar xzf solr-6.0.0.tgz solr-6.0.0/bin/install_solr_service.sh --strip-components=2
sudo bash ./install_solr_service.sh solr-6.0.0.tgz
```
* serviceにsolrが追加される
* solr関係の所有者はsolrユーザになっておりsolrもsolrユーザで起動されてる

## sunspot設定ファイルを作成する
```
gem i rails
be rails new solr_sample
```

## itamae
### install solr
```shell
itamae ssh --host host001.example.jp solr.rb
```

### copy sunspot config files
```shell
itamae ssh --host host001.example.jp copy_sunspot_config_files.rb
```
