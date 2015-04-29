#!/bin/bash  

repo=$1
project_name=`echo $repo | sed -E 's/.*\/(.*)\.git/\1/'`
project_name=`echo $project_name | sed -E 's/\-/_/'`
project_name=`echo $project_name | tr '[:upper:]' '[:lower:]'`

echo "git url:      $repo"
echo "project name: $project_name"
echo ""

if [ -d $project_name ]
then
  echo "FATAL: directory $project_name already exists"
  exit 1
fi

echo "cloning base project"
git clone git@github.com:daftlabs/wordpress-base.git $project_name --recursive
cd $project_name

echo "cloning setting origin to $repo"
git remote set-url origin $repo 

echo "updating everything"
LC_ALL=C find . -type f -not -empty -not -path './.git*' -exec sed -i '' "s/wordpress\-base/$project_name/g" {} +
#@TODO: do we even need this for WordPress?
mv cookbooks/wordpress cookbooks/$project_name

echo "creating inital commit"
git checkout --orphan newmaster
git rm -f install.sh
git rm -f README.md
git add .
git commit -m "inital commit"

git branch -D master
git checkout -b master
git branch -D newmaster

git push origin master

vagrant up
