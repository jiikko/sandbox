# 前提知識
## ハードウェア
### PSW
* プロセッサステータスワードという16ビットのレジスタを持つ
* モード00はカーネルモードを表し、11はユーザモードを表す
  * システムコールの処理などはプロセッサがユーザモードからカーネルモードに切り替わってから処理を行う
  * カーネルモードとユーザモードはアドレス空間が独立しているので、それらの間でデータをやりとりするときなどに、現在のモード情報と以前のモード情報が必要になる
    * PSWはプロセッサが命令を実行するとその結果が自動的に反映される

### 汎用レジスタ
* PDP-11/40には、r0からr7までの8個の汎用レジスタがある
  * r6だけはユーザモード用とカーネルモード用に2つある
  PDWの現在のモードが切り替わるとr6もハードウェア的に切り替わる
* レジスタ用途
  * r0, r1
    * 計算用、関数の戻り値
  * r2, r3, r4
    * ローカル処理
  * r5
    * フレームポインタ、環境ポインタ
    * 環境ポインタとも呼ばれる
  * r6(sp)
    * スタックポインタ
    * 各プロセスが持つスタックの先頭を表す
  * r7(pc)
    * プログラムカウンタ
    * プロセッサはr7で示されたメモリアドレスから命令を読み込み、命令を解釈して、その命令を処理する
      * 処理を行うとr7は次の命令アドレスまで進める

# プロセス
* 一意のIDをもつ
  * pid
* プロセス自体の機械語やプロセス内で使用する変数を格納・参照するために、メモリもしくはディスクを使用する

## プロセスの状態
* 実行状態
  * プロセスにCPU使用権が割当充てられ、CPUを使って命令を実行しちる状態。
* 実行可能状態
  * CPUを使う条件は揃っているが、他のプロセスがCPUを使用中のためにCPUが割り当てられていない状態。
*  待ち状態
  * 入出力待ち状態。

### スワッピング
* プロセスのデータ領域がスワップ領域を行き来することをスワッピングという
  * メモリが足りなくなったり、優先度の低いと判断されたらメモリ上のプロセスのデータ領域をディスクに書き出す。
    * スワップアウト
  * 実行可能になったらメモリに戻す
    * スワップイン
* ディスクに書き出すことは遅いのでボトルネックになりがち。
* メモリを追加するとスワップの頻度が少なくなってスループットがあがる。

## プロセスの実体
* プロセスは仮想アドレス空間を割り当てられて、ポインタや各種メタデータ(後述)はproc構造体、user構造体に記録している
* proc構造体は常に参照され続けるのでメモリに常駐している
  * debianだと /proc で参照できる(謎
* user構造体はスワッピングによってディスクにいくことがある

## proc構造体
* 1インスタンスは、1プロセスとなっていて、カーネルから必要とされる情報を格納している
* メンバ
  * 実行優先度
  * 受信したシグナル
  * ユーザーID
  * CPUを使用した時間
  * プロセスID
  * 親プロセスID
  * 割り当てられたメモリの物理アドレス
  * 割り当てられたメモリのサイズ
  * etc...

## user構造体
* メンバ
  * 実行ユーザID
  * 実行グループID
  * プロセスがオープンしているファイル
  * ユーザモードとしてCPUを使用した時間
  * カーネルモードとしてCPUを使用した時間
  * 子プロセスがユーザモードとしてCPUを使用した時間
  * 子プロセスがカーネルモードとしてCPUを使用した時間
  * etc...

## 1プロセスが使用するメモリ
* テキストセグメント
  * 読み取り専用。プログラムの命令列である機械語が格納される
  * プログラムが複数実行される場合は、プロセス間で共有される。
  * JITはここの領域を書き換えて最適化を行なっている
* データセグメント
  * 変数などが格納される
  * 複数のプロセス間で共有されない
  * データセグメントは下記3要素で構成される
      * PPDA(PerProcDataArea)
        * カーネルスタック領域はカーネル処理の作業領域として使用される。プロセスごとにカーネルモード用の作業領域が設けられている
      * データ領域
        * プロセスが動的にメモリ領域を管理するヒープ領域
      * スタック領域
        * 関数の引数やローカルデータなどを一時的に格納する領域
        * バッファオーバーランで利用される場所

## 仮想アドレス空間
図が欲しい
* 仮想アドレス空間
  * 16bitの仮想アドレス
  * 64Kバイト
    * 1プロセスの上限
* 物理アドレス空間
  * 18bitの物理アドレス
  * 256Kバイト

### メリット
* 物理アドレスのどこにいるのか考えなくていい
  * スワッピング処理が起きても仮想アドレスは変わらない
    * 物理アドレスは変わっている
* アクセス制限ができる
  * 物理アドレスを指定できてると参照されてしまう
  * 割り当てられていない領域にアクセスするとMMU(メモリマネジメントユニット)が例外を発生される
* メモリの使用効率を高める
  * 仮想アドレス空間上は、連続して確保しているが物理アドレス空間では断片化している、ということができる
    * プロセスが連続したメモリ容量を必要とする場合があるらしいです

# 参考書籍
* オペレーティングシステム入門 古市英治著
* はじめてのOSコードリーディング

完
