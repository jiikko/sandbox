let s = "jii" . "kko"
let a = split(s, "kk")
echo a

let list = [1, 2, 3]
echo list[0]


let dict = { 'a': 123, 'b': 987}
echo dict["a"]

let c = 0

if "2" " => true
  echo "true"
else
  echo "false"
endif

inoremap <C-j> <Down>
echo "ok"

" function!は再定義可能になる
function! Func(flg) " グローバルスコープの場合、関数名はアルファベットの大文字で始まる
  if a:flg         " 引数の参照は、a:引数名
    echo "akffkdo"
    return "aaaaaiiiiiiiia"
  else
    echo "kooooooooo"
    return "aaaaaa"
  endif
endfunction

" インサートモードでのマッピング
" inoremap
" inoremap <expr><C-e> neocomplcache#cancel_popup()

" alias的になるっぽい
" : でCCと入力すればよくなる
cmap CC set nu
cmap CN set nonu

" map コマンドモードのキーマップ
" imap 入力モードのキーマップ
" cmap コマンドラインにカーソルがあるときのキーマップ


" 現在時間を挿入する
map <F2> a<C-R>=strftime("%c")<CR><Esc>

"
" map <C-d> Func(3)
map <C-d> call Func(0)
" map <C-d> aakoji


function! Increment()
  " カレント行を数値と見なして、+1 する関数
  let line = str2nr(getline('.'), 10)
  " カレント行の取得(後述)
  let line += 1
  " カレント行の更新(後述)
  call setline('.', printf("%d", line))
endfunction


inoremap <expr> <C-L> ListItem()

func! ListItem()
  call cursor(line("."), 1)
  let split_text = split(getline(line(".") -1), '\.')

  if len(split_text) == 0
    return '1.' . "\n"
  end

  "TODO 次は前行が特定のフォーマット以外の時は1.から始めるようにする
  let next_num =  matchstr(split_text[0], '[0-9]*', 0) + 1
  if len(split_text) == 2
    return next_num . '.' . split_text[1] . "\n"
  elseif len(split_text) == 1
    return next_num . '.' . "\n"
  else
    return ''
  endif
endfunc


" ################
"  <expr> 引数を指定すると、引数が式 (スクリプト) として扱われます。マップが実行されたときに、式が評価され、その値が {rhs} として使われます
inoremap <expr> <C-P> SayHoi()
call cursor(line(".") + 1, col("."))
