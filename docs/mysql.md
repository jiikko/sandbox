# MySQL
## クエリログを出力する
* トランザクションのデバッグする時にコネクションIDが表示されているので時系列がわかりやすい
* mysql シェルからパスとONを設定すればプロセスの再起動なしに有効になる

```
SET GLOBAL general_log = 'ON';
SET GLOBAL general_log_file = '/tmp/mysql_query.log';
```
### 出力例1
```
Time                 Id Command    Argument
170207 10:54:37     2 Query     SELECT  `users`.* FROM `users`  ORDER BY `users`.`id` DESC LIMIT 1
170207 10:54:39     4 Quit
170207 10:55:00     2 Query     SELECT  `parents`.* FROM `parents` WHERE `parents`.`id` = 1 LIMIT 1
                    2 Query     BEGIN
                    2 Query     SELECT  `experiences`.* FROM `experiences` WHERE `experiences`.`parent_id` = 1 AND `experiences`.`id` = 1  ORDER BY `experiences`.`id` DESC LIMIT 1 FOR UPDATE
170207 10:55:07     5 Connect   root@localhost on outing_development
                    5 Query     SET NAMES utf8mb4 COLLATE utf8mb4_general_ci,  @@SESSION.sql_auto_is_null = 0, @@SESSION.wait_timeout = 2147483, @@SESSION.sql_mode = 'STRICT_ALL_TABLES'
                    5 Query     SELECT  `parents`.* FROM `parents` WHERE `parents`.`id` = 1 LIMIT 1
                    5 Query     BEGIN
                    5 Query     SELECT  `experiences`.* FROM `experiences` WHERE `experiences`.`parent_id` = 1 AND `experiences`.`id` = 1  ORDER BY `experiences`.`id` DESC LIMIT 1 FOR UPDATE
170207 10:55:11     2 Query     SELECT  `memory_photos`.* FROM `memory_photos` WHERE (memory_photos.position IS NOT NULL) AND `memory_photos`.`experience_id` = 1  ORDER BY memory_photos.position DESC LIMIT 1
                    2 Query     INSERT INTO `memory_photos` (`photo_file_name`, `photo_content_type`, `photo_file_size`, `photo_updated_at`, `experience_id`, `created_at`, `updated_at`, `position`) VALUES ('dummy.gif', 'image/gif', 43, '2017-02-07 01:55:10', 1, '2017-02-07 01:55:11', '2017-02-07 01:55:11', 7)
                    2 Query     COMMIT
                    5 Query     SELECT  `memory_photos`.* FROM `memory_photos` WHERE (memory_photos.position IS NOT NULL) AND `memory_photos`.`experience_id` = 1  ORDER BY memory_photos.position DESC LIMIT 1
                    5 Query     INSERT INTO `memory_photos` (`photo_file_name`, `photo_content_type`, `photo_file_size`, `photo_updated_at`, `experience_id`, `created_at`, `updated_at`, `position`) VALUES ('dummy.gif', 'image/gif', 43, '2017-02-07 01:55:11', 1, '2017-02-07 01:55:11', '2017-02-07 01:55:11', 8)
                    5 Query     COMMIT
```

### 出力例2
```
170207 10:57:16     2 Query     BEGIN
                    2 Query     SELECT  `parents`.* FROM `parents` WHERE `parents`.`id` = 1 LIMIT 1
                    2 Query     SELECT  `experiences`.* FROM `experiences` WHERE `experiences`.`parent_id` = 1 AND `experiences`.`id` = 1  ORDER BY `experiences`.`id` DESC LIMIT 1 FOR UPDATE
170207 10:57:21     5 Query     BEGIN
                    5 Query     SELECT  `parents`.* FROM `parents` WHERE `parents`.`id` = 1 LIMIT 1
                    5 Query     SELECT  `experiences`.* FROM `experiences` WHERE `experiences`.`parent_id` = 1 AND `experiences`.`id` = 1  ORDER BY `experiences`.`id` DESC LIMIT 1 FOR UPDATE
170207 10:57:26     2 Query     SELECT  `memory_photos`.* FROM `memory_photos` WHERE (memory_photos.position IS NOT NULL) AND `memory_photos`.`experience_id` = 1  ORDER BY memory_photos.position DESC LIMIT 1
                    2 Query     INSERT INTO `memory_photos` (`photo_file_name`, `photo_content_type`, `photo_file_size`, `photo_updated_at`, `experience_id`, `created_at`, `updated_at`, `position`) VALUES ('dummy.gif', 'image/gif', 43, '2017-02-07 01:57:26', 1, '2017-02-07 01:57:26', '2017-02-07 01:57:26', 9)
                    2 Query     COMMIT
                    5 Query     SELECT  `memory_photos`.* FROM `memory_photos` WHERE (memory_photos.position IS NOT NULL) AND `memory_photos`.`experience_id` = 1  ORDER BY memory_photos.position DESC LIMIT 1
                    5 Query     INSERT INTO `memory_photos` (`photo_file_name`, `photo_content_type`, `photo_file_size`, `photo_updated_at`, `experience_id`, `created_at`, `updated_at`, `position`) VALUES ('dummy.gif', 'image/gif', 43, '2017-02-07 01:57:26', 1, '2017-02-07 01:57:26', '2017-02-07 01:57:26', 9)
                    5 Query     COMMIT
```
