#!/bin/sh

(git branch -D d/11111-upgrade4.2-release)
git checkout master
git checkout -b d/11111-upgrade4.2-release

/bin/sh <<< $(ruby -e '%w(d/17796-upgrade-rails4.2              \
                          d/17796-upgrade-rails4.2-deliver_now2 \
                          d/17796-upgrade-rails4.2-where-not    \
                       ).each { |b| puts "git merge #{b}" }')
