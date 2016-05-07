# samba
```
sudo apt-get install samba
```

## 設定ファイル
sudo vi /etc/samba/smb.conf
```
[pi]
path = /home/pi/var/
read only = no
```

## ユーザ作成
```
sudo smbpasswd -a pi
```
