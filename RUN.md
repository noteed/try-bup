docker run -v `pwd`:/source -t -i images.reesd.com/noteed/bup sh /source/script.sh

Creating /.bup...

    Initialized empty Git repository in /.bup/

/.bup content:

    total 40
    drwxr-xr-x  7 root root 4096 May 12 20:16 .
    drwxr-xr-x 86 root root 4096 May 12 20:16 ..
    -rw-r--r--  1 root root   23 May 12 20:16 HEAD
    drwxr-xr-x  2 root root 4096 May 12 20:16 branches
    -rw-r--r--  1 root root  116 May 12 20:16 config
    -rw-r--r--  1 root root   73 May 12 20:16 description
    drwxr-xr-x  2 root root 4096 May 12 20:16 hooks
    drwxr-xr-x  2 root root 4096 May 12 20:16 info
    drwxr-xr-x  4 root root 4096 May 12 20:16 objects
    drwxr-xr-x  4 root root 4096 May 12 20:16 refs

Creating /repo/.git...

    Initialized empty Git repository in /repo/.git/

/repo/.git content:

    total 40
    drwxr-xr-x 7 root root 4096 May 12 20:16 .
    drwxr-xr-x 3 root root 4096 May 12 20:16 ..
    -rw-r--r-- 1 root root   23 May 12 20:16 HEAD
    drwxr-xr-x 2 root root 4096 May 12 20:16 branches
    -rw-r--r-- 1 root root   92 May 12 20:16 config
    -rw-r--r-- 1 root root   73 May 12 20:16 description
    drwxr-xr-x 2 root root 4096 May 12 20:16 hooks
    drwxr-xr-x 2 root root 4096 May 12 20:16 info
    drwxr-xr-x 4 root root 4096 May 12 20:16 objects
    drwxr-xr-x 4 root root 4096 May 12 20:16 refs

Differences between /git-initial and /bup-initial:

    diff -r -u /git-initial/config /bup-initial/config
    --- /git-initial/config	2014-05-12 20:16:15.342393497 +0000
    +++ /bup-initial/config	2014-05-12 20:16:15.322393497 +0000
    @@ -1,5 +1,7 @@
     [core]
     	repositoryformatversion = 0
     	filemode = true
    -	bare = false
    -	logallrefupdates = true
    +	bare = true
    +	logAllRefUpdates = true
    +[pack]
    +	indexVersion = 2

Note that beside .bup being a bare repository, they are identical:
pack.indexVersion defaults to 2 since Git 1.5.2 (and is necessary to
handle packs large than 4GB; see man git-config).

Adding hello world to Bup...

    >>
    >bup: 0.01kbytes in 0.17 secs = 0.07 kbytes/sec

Adding hello world to Git...
Note that we run 'git gc' to create a packfile (so we can compare with
Bup).

    [master (root-commit) e9d0549] Initial-commit
     1 file changed, 1 insertion(+)
     create mode 100644 data

Differences between Git and Bup:

    Only in /git-hello-world: COMMIT_EDITMSG
    diff -r -u /git-hello-world/config /bup-hello-world/config
    --- /git-hello-world/config	2014-05-12 20:16:15.342393497 +0000
    +++ /bup-hello-world/config	2014-05-12 20:16:15.322393497 +0000
    @@ -1,5 +1,7 @@
     [core]
     	repositoryformatversion = 0
     	filemode = true
    -	bare = false
    -	logallrefupdates = true
    +	bare = true
    +	logAllRefUpdates = true
    +[pack]
    +	indexVersion = 2
    Only in /git-hello-world: index
    Only in /git-hello-world/info: refs
    Only in /git-hello-world/logs: HEAD
    diff -r -u /git-hello-world/logs/refs/heads/master /bup-hello-world/logs/refs/heads/master
    --- /git-hello-world/logs/refs/heads/master	2014-05-12 20:16:15.658393503 +0000
    +++ /bup-hello-world/logs/refs/heads/master	2014-05-12 20:16:15.590393502 +0000
    @@ -1 +1 @@
    -0000000000000000000000000000000000000000 e9d0549f97e21935ab2d7e2e28927fe21b883faa Your Name <you@example.com> 1399925775 +0000	commit (initial): Initial-commit
    +0000000000000000000000000000000000000000 e6dbe444849401513d1f0729e7a7e5f7379c9334 Your Name <you@example.com> 1399925775 +0000
    Only in /git-hello-world/objects/info: packs
    Only in /bup-hello-world/objects/pack: bup.bloom
    Only in /git-hello-world/objects/pack: pack-9ba9fd4fdbf9d4923c91df24c5aaec458ac1ef37.idx
    Only in /git-hello-world/objects/pack: pack-9ba9fd4fdbf9d4923c91df24c5aaec458ac1ef37.pack
    Only in /bup-hello-world/objects/pack: pack-f052aec81c0d17a3ef24bef9f38cbbf7923fb012.idx
    Only in /bup-hello-world/objects/pack: pack-f052aec81c0d17a3ef24bef9f38cbbf7923fb012.pack
    Only in /git-hello-world: packed-refs
    Only in /bup-hello-world/refs/heads: master

Running `git cat-file -p master^{tree}` for Bup...

    100644 blob 3b18e512dba79e4c8300dd08aeb37f8e728b8dad	data

And for Git...

    100644 blob 3b18e512dba79e4c8300dd08aeb37f8e728b8dad	data

Running `git verify-pack` for Bup...

    3b18e512dba79e4c8300dd08aeb37f8e728b8dad blob   12 21 12
    f97405d5cd704d755d4a228c09ad5cf4529a9431 tree   32 43 33
    e6dbe444849401513d1f0729e7a7e5f7379c9334 commit 235 169 76
    non delta: 3 objects
    /bup-hello-world/objects/pack/pack-f052aec81c0d17a3ef24bef9f38cbbf7923fb012.pack: ok

And for Git...

    e9d0549f97e21935ab2d7e2e28927fe21b883faa commit 169 122 12
    f97405d5cd704d755d4a228c09ad5cf4529a9431 tree   32 43 134
    3b18e512dba79e4c8300dd08aeb37f8e728b8dad blob   12 21 177
    non delta: 3 objects
    /git-hello-world/objects/pack/pack-9ba9fd4fdbf9d4923c91df24c5aaec458ac1ef37.pack: ok

Normally, the packfiles contain the same thing: an identical blob, an
identical tree, and a commit that differs because of its commit message.

Indeed, if we look at the commit object in Bup...

    commit e6dbe444849401513d1f0729e7a7e5f7379c9334
    Author: root <root@92875c0de8c1>
    Date:   Mon May 12 20:16:15 2014 +0000
    
        bup split
        
        Generated by command:
        ['/usr/lib/bup/cmd/bup-split', '-n', 'master', '-vv']
    
    diff --git a/data b/data
    new file mode 100644
    index 0000000..3b18e51
    --- /dev/null
    +++ b/data
    @@ -0,0 +1 @@
    +hello world

And the one in Git...

    commit e9d0549f97e21935ab2d7e2e28927fe21b883faa
    Author: Your Name <you@example.com>
    Date:   Mon May 12 20:16:15 2014 +0000
    
        Initial-commit
    
    diff --git a/data b/data
    new file mode 100644
    index 0000000..3b18e51
    --- /dev/null
    +++ b/data
    @@ -0,0 +1 @@
    +hello world

We can see they're the same.
