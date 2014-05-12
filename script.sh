#! /bin/bash

cd /

echo
echo Creating /.bup...
bup init
echo
echo /.bup content:
ls -la /.bup

cp -a /.bup /bup-initial

echo
echo Creating /repo/.git...
mkdir /repo
cd /repo
git init
cd /
echo
echo /repo/.git content:
ls -la /repo/.git

cp -a /repo/.git /git-initial

echo
echo Differences between /git-initial and /bup-initial:
diff -r -u /git-initial /bup-initial
echo
echo "Note that beside .bup being a bare repository, they are identical:"
echo "pack.indexVersion defaults to 2 since Git 1.5.2 (and is necessary to"
echo "handle packs large than 4GB; see man git-config)."
