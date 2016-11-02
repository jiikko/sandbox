# Tiny Core Linux
## mruby をコンパイルできるようにする
```shell
tce-load -wil git
tce-load -wil compiletc
tce-load -wil ruby
git clone https://github.com/hone/mruby-cli.git
```

```
docker@default:~/mruby-cli$ rake
rake
CC    mruby/src/vm.c -> mruby/build/host/src/vm.o
/home/docker/mruby-cli/mruby/src/vm.c:9:18: fatal error: math.h: No such file or directory
compilation terminated.
/home/docker/mruby-cli/mruby/src/vm.c:9:18: fatal error: math.h: No such file or directory
compilation terminated.
rake aborted!
Command failed with status (1): [gcc -g -std=gnu99 -O3 -Wall -Werror-implic...]
/home/docker/mruby-cli/mruby/tasks/mruby_build_commands.rake:31:in `_run'
/home/docker/mruby-cli/mruby/tasks/mruby_build_commands.rake:36:in `rescue in _run'
/home/docker/mruby-cli/mruby/tasks/mruby_build_commands.rake:32:in `_run'
/home/docker/mruby-cli/mruby/tasks/mruby_build_commands.rake:88:in `run'
/home/docker/mruby-cli/mruby/tasks/mruby_build_commands.rake:112:in `block (2 levels) in define_rules'
Command failed with status (1): ["gcc" -g -std=gnu99 -O3 -Wall -Werror-impl...]
/home/docker/mruby-cli/mruby/tasks/mruby_build_commands.rake:33:in `_run'
/home/docker/mruby-cli/mruby/tasks/mruby_build_commands.rake:88:in `run'
/home/docker/mruby-cli/mruby/tasks/mruby_build_commands.rake:112:in `block (2 levels) in define_rules'
Tasks: TOP => default => all => /home/docker/mruby-cli/mruby/build/host/lib/libmruby.flags.mak => /home/docker/mruby-cli/mruby/build/host/lib/libmruby.a => /home/docker/mruby-cli/mruby/build/host/src/vm.o
(See full trace by running task with --trace)
```
http://forum.tinycorelinux.net/index.php?topic=8950.0
