# Rails Engine の始め方
## プロジェクトを作成する
```
rails plugin new happy_bottons --mountable -T --dummy-path=spec/dummy
```

```
rails plugin new happy_bottons --mountable -T --dummy-path=spec/dummy -d=mysql
```

## gemspec を修正する
* TODO, FIXME を削除する

## welcome pageを表示する
```
cd spec/dummy
rails server
```

* ./config/routes.rb に root を定義する

```ruby
HappyBottons::Engine.routes.draw do
  root 'top#index', as: :root
end
```

http://localhost:3000/happy_bottons にアクセスすると `top#index` が表示される

## rails generate で testunit の生成物を抑止する
```ruby
module HappyBottons
  class Engine < ::Rails::Engine
    isolate_namespace HappyBottons

    config.generators do |g|
      g.test_framework :rspec, fixture: false
    end
  end
end
```
