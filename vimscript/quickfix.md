# QuickFix
## 読み込み
```
/Users/koji/.rvm/rubies/ruby-2.4.1/lib/ruby/2.4.0/irb/workspace.rb:87:in `eval'
/Users/koji/.rvm/rubies/ruby-2.4.1/lib/ruby/2.4.0/irb/workspace.rb:87:in `evaluate'
/Users/koji/.rvm/rubies/ruby-2.4.1/lib/ruby/2.4.0/irb/context.rb:381:in `evaluate'
/Users/koji/.rvm/rubies/ruby-2.4.1/lib/ruby/2.4.0/irb.rb:493:in `block (2 levels) in eval_input'
/Users/koji/.rvm/rubies/ruby-2.4.1/lib/ruby/2.4.0/irb.rb:627:in `signal_status'
/Users/koji/.rvm/rubies/ruby-2.4.1/lib/ruby/2.4.0/irb.rb:490:in `block in eval_input'
/Users/koji/.rvm/rubies/ruby-2.4.1/lib/ruby/2.4.0/irb/ruby-lex.rb:246:in `block (2 levels) in each_top_level_statement'
/Users/koji/.rvm/rubies/ruby-2.4.1/lib/ruby/2.4.0/irb/ruby-lex.rb:232:in `loop'
/Users/koji/.rvm/rubies/ruby-2.4.1/lib/ruby/2.4.0/irb/ruby-lex.rb:232:in `block in each_top_level_statement'
/Users/koji/.rvm/rubies/ruby-2.4.1/lib/ruby/2.4.0/irb/ruby-lex.rb:231:in `catch'
/Users/koji/.rvm/rubies/ruby-2.4.1/lib/ruby/2.4.0/irb/ruby-lex.rb:231:in `each_top_level_statement'
/Users/koji/.rvm/rubies/ruby-2.4.1/lib/ruby/2.4.0/irb.rb:489:in `eval_input'
/Users/koji/.rvm/rubies/ruby-2.4.1/lib/ruby/2.4.0/irb.rb:430:in `block in run'
/Users/koji/.rvm/rubies/ruby-2.4.1/lib/ruby/2.4.0/irb.rb:429:in `catch'
/Users/koji/.rvm/rubies/ruby-2.4.1/lib/ruby/2.4.0/irb.rb:429:in `run'
/Users/koji/.rvm/rubies/ruby-2.4.1/lib/ruby/2.4.0/irb.rb:385:in `start'
/Users/koji/.rvm/rubies/ruby-2.4.1/bin/irb:11:in `<main>'
```

* というテキストを保存して、`vim -q e.log -c cw` でオープンするとquickfixリストにパースしてくれる。
* `:cfile path | cw` でもエラーログを読み込んでquickfixリストを作成できる
* `:echo &errorFormat` に式が書いており、quickfixリストを作成できない時は確認するとよい

## grep から
* `:grep hoge **/*.rb | cw`
* 外部grep コマンドを変える時h、grepprg にセットする
