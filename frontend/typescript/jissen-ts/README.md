* tsconfig.json の strictでfalseにすることで無指定のanyをエラーにする
* nullの代入許可はstrictNullChecks でやっている
* declaration で型宣言ファイルを出力する
  * ライブラリ開発時やproject referencesで使う
* アサーション
  `let strl: number = (<string>some).length`, `let strls: number = (some as string).length`
* 型定義
  * let a1: boolean[] 
  * let a2: (string | number)[]
