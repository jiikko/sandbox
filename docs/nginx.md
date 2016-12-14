# NIGNX
## 変数をプリントでバッグする

```nginx
http {
    log_format debug_log_fmt "[DEBUG][$time_local] $file, $is_args, $args";
[...]
```

```
location ~* ^/s3_original/(.*)$ {
    set $file $1;
    access_log /opt/nginx/logs/access.log debug_log_fmt;
[...]
```
```
[DEBUG][28/Nov/2016:12:29:40 +0900] , ?, X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWPUIWJMU4TC6NGA%2F20161128%2Fap-northeast-1%2Fs3%2Faws4_request&X-Amz-Date=20161128T031616Z&X-Amz-Expires=1800&X-Amz-SignedHeaders=host&X-Amz-Signature=a12c1c1c5a57b948fbf08e85130c4999c9856bf38d7fcb1c7239898a1
```
