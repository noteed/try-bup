#! /bin/bash

git config --global user.name "Your Name"
git config --global user.email you@example.com

indent() {
  $@ 2>&1 | sed "s/^/    /"
}

cd /

echo
echo Creating /.bup...
echo
indent bup init
echo
echo /.bup content:
echo
indent ls -la /.bup

cp -a /.bup /bup-initial

echo
echo Creating /repo/.git...
echo
mkdir /repo
cd /repo
indent git init
cd /
echo
echo /repo/.git content:
echo
indent ls -la /repo/.git

cp -a /repo/.git /git-initial

echo
echo Differences between /git-initial and /bup-initial:
echo
indent diff -r -u /git-initial /bup-initial
echo
echo "Note that beside .bup being a bare repository, they are identical:"
echo "pack.indexVersion defaults to 2 since Git 1.5.2 (and is necessary to"
echo "handle packs large than 4GB; see man git-config)."

echo
echo Adding hello world to Bup...
echo
echo hello world | indent bup split -n master -vv
cp -a /.bup /bup-hello-world
echo
echo Adding hello world to Git...
echo "Note that we run 'git gc' to create a packfile (so we can compare with"
echo "Bup)."
echo
cd /repo
echo hello world > data
git add data
indent git commit -m Initial-commit
indent git gc
cd /
cp -a /repo/.git /git-hello-world
echo
echo Differences between Git and Bup:
echo
indent diff -r -u /git-hello-world /bup-hello-world

echo
echo 'Running `git cat-file -p master^{tree}` for Bup...'
echo
export GIT_DIR=/.bup
indent git cat-file -p master^{tree}
echo
echo And for Git...
echo
export GIT_DIR=/repo/.git
indent git cat-file -p master^{tree}

echo
echo 'Running `git verify-pack` for Bup...'
echo
indent git verify-pack -v \
  /bup-hello-world/objects/pack/pack-*.idx
echo
echo And for Git...
echo
indent git verify-pack -v \
  /git-hello-world/objects/pack/pack-*.idx

echo
echo Normally, the packfiles contain the same thing: an identical blob, an
echo identical tree, and a commit that differs because of its commit message.

echo
echo Indeed, if we look at the commit object in Bup...
echo
COMMIT_ID=$(git verify-pack -v \
  /bup-hello-world/objects/pack/pack-*.idx \
  | grep commit | cut -f 1 -d ' ')
export GIT_DIR=/bup-hello-world
indent git show $COMMIT_ID

echo
echo And the one in Git...
echo
COMMIT_ID=$(git verify-pack -v \
  /git-hello-world/objects/pack/pack-*.idx \
  | grep commit | cut -f 1 -d ' ')
export GIT_DIR=/git-hello-world
indent git show $COMMIT_ID
echo
echo "We can see they're the same."
