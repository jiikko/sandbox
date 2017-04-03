# Rails::Engine
## 新規作成する
```
$ rails plugin new hoge_app --mountable -T --dummy-path=spec/dummy -d mysql
```
* dummy_path を指定するとrails アプリケーションが作成され、rails server を起動してここに組み込みながら開発しながらできる
* rspec も使える
