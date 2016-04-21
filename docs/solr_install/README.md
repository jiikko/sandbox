# Solr Install for Production
see https://cwiki.apache.org/confluence/display/solr/Taking+Solr+to+Production

## ゴール
* railsから接続して検索できる

## Solrホストを1つ作成する流れ
* (1) solr config files for sunspot を作成するrailsプロジェクトをローカルで作成する
* (2) Solrホストにsolrをinstallする
* (3) ローカルで作成した solr config files for sunspot をSolrホストにコピーする

2つめのSolrホストを作成するときは、2と3を繰り返す

## (1) solr config files for sunspot を作成するrailsプロジェクトをローカルで作成する
リポジトリにコミット済み

```
brew cask install 'java-beta' # java8
gem install rails
rails new rails_app_for_sunspot -T
cd rails_app_for_sunspot
echo 'gem "sunspot_solr"' > Gemfile
echo 'gem "sunspot_rails"' > Gemfile
rm -r pubic app
bundle install
bundle exec rails generate sunspot_rails:install
bundle exec rake sunspot:solr:start
bundle exec rake sunspot:solr:stop
```

## (2) Solrホストにsolrをinstallする
```
# in host OS
wget http://ftp.jaist.ac.jp/pub/apache/lucene/solr/6.0.0/solr-6.0.0.tgz
scp files/solr-6.0.0.tgz koji@192.168.56.102:~/
```
```
# in koji@192.168.56.102
sudo apt-get install openjdk-8-jre -y
tar xzf solr-6.0.0.tgz solr-6.0.0/bin/install_solr_service.sh --strip-components=2
sudo bash ./install_solr_service.sh solr-6.0.0.tgz
```
* serviceにsolrが追加される
* solr関係の所有者はsolrユーザになっておりsolrもsolrユーザで起動されてる
* /var/slor はシンボリックリンクになっている

##  (3) ローカルで作成した solr config files for sunspot をSolrホストにコピーする
```
# in host OS
scp files/rails_app_for_sunspot/solr koji@192.168.56.102:/tmp/_solr
```
```shell
# in koji@192.168.56.102
sudo sed 's/HOME//var/solr/server/solr/' /etc/defaults/solr.sh
sudo rm -rf /var/solr/server/solr
sudo cp /tmp/_solr /var/solr/server/solr
sudo chown -R solr /var/solr/server/solr
sudo rm -rf /tmp/_solr
```
