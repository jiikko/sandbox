#!/bin/sh

git checkout master
git branch -D d/11111-upgrade4.2-release
git checkout master
git checkout -b d/11111-upgrade4.2-release

if [[ $(git branch | grep \* | grep master) ]]; then
  echo 'stop!!!!! because current is mastter'
else
  git merge d/17796-upgrade-rails4.2
  git merge d/17796-upgrade-rails4.2-deliver_now2
  git merge d/17796-upgrade-rails4.2-where-not
fi
