# ssh 接続先のサーバーで nohup ジョブを走らせるときは 標準入出力をすべて切っておかないと期待通りにsshを抜けられない

nohup bash -c 'sleep 10; touch one; touch 3; touch two' >/dev/null 2>/dev/null &

cmd=$(cat << EOH
sleep 1
touch aaa
sleep 1
touch bbb
EOH
)
nohup bash <<< "$cmd" >/dev/null 2>/dev/null &
