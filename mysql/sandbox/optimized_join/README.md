# 結合オプティマイザ
* 結合するときにコストのかからないものを選ぶ。
* 結合する順序を逆にするとバックトラックと読みなおしが少なくなる。
* クエリプラン候補の検索空間が多い場合は計算が間に合わないのでオプティマイザは諦める。
* n個のテーブル結合ではnの階乗の組み合わせを調べることになる。

実践MySQLハイパフォーマンス第三版 P232より