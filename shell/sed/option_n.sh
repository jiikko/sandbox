#/bin/sh


# -n      By default, each line of input is echoed to the standard output after all of the commands have been applied to it.  The -n option suppresses this behavior.
# -n オプションを追加してpフラグを付けると、マッチした行のみを出力する。

# 出力なし
sed -n 's|\([0-9]*\)|xxx|' sample_texts/filelist.txt

# あり
sed -n 's|\([0-9]*\)|x|p' sample_texts/filelist.txt
