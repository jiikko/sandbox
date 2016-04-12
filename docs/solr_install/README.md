# Solr Install for Production
## Solr のインストール
see https://cwiki.apache.org/confluence/display/solr/Taking+Solr+to+Production
```
wget http://ftp.jaist.ac.jp/pub/apache/lucene/solr/6.0.0/solr-6.0.0.tg
tar xzf solr-6.0.0.tgz solr-6.0.0/bin/install_solr_service.sh --strip-components=2
sudo apt-get install openjdk-8-jre -y
```
* serviceにsolrが追加される
* solr関係の所有者はsolrユーザになっておりsolrもsolrユーザで起動されてる

## sunspot設定ファイルを作成する
```
gem i rails
be rails new solr_sample
```

