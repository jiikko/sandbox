# YARVの内部スタックとRubyのコールスタック(62P)
* SP
  * スタックポインタ、スタックの一番上の場所を示している
* PC
  * プログラムカウンタ、現在の命令の場所を示している
* CFP(control frame pointer)
  * このポイントは((外部)スタック中の)現在の制御フレームを示すポインタだ

* このあとですぐ説明するが、YARVは途中の値や引数、戻り値を把握するために内部的にスタックを使用する
  * YARVはRubyプルグラムのコールスタックも把握し続ける
  * コールスタックには，どのメソッドが他のメソッド、関数、ブロックやラムダなどを呼び出したかが記録される
  * 実際のところ、YARVはその命令列自体のためだけではなくRubyプログラム全体のために引数や返り値を把握しておく必要がある


```ruby
code = <<-CODE
'def hoge;s = "dd"; end; def gggg; hgh = "ff";gg = "ff"; 10.times { puts gg }; end'
CODE
puts RubyVM::InstructionSequence.compile(code).disasm
```
