# XSSスキャン
* 使うツール
  * https://github.com/stamparm/DSXS
  * wget
    * http://stackoverflow.com/questions/2804467/spider-a-website-and-return-urls-only
* DSXS は1URLに対してスキャンするだけなので、スキャン対象のURLをwgetで収集する

```
$ wget --spider --force-html --http-user=$ba_name --http-passwd=$ba_password -r -l2 http://xss.net 2>&1  | grep '^--' | awk '{ print $3 }'  | grep -vE '\.\(css\|js\|png\|gif\|jpg\)$'  > urls.m3u
$ cat urls.m3u | grep \? | grep -v -E \(listing_click\|system\) | sort | uniq | ruby -r uri -n -e "while gets; puts URI.decode(\$_); end" > list
$ for url in `cat list`; do echo "[start] $url"; python dsxs.py -u $url; done > output
```
