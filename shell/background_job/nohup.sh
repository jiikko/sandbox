# ssh 接続先のサーバーで nohup ジョブを走らせるときは 標準入出力をすべて切っておかないと期待通りにsshを抜けられない:(sleep 10; touch /tmp/test_qqq) &

echo 'create database outing_development;' | mysql -uroot
nohup $(mysqldump -uroot outing_production | mysql -uroot outing_development) >/dev/null 2>/dev/null &
