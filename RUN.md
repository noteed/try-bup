docker run -v `pwd`:/source -t -i images.reesd.com/noteed/bup sh /source/script.sh

Creating /.bup...

    Initialized empty Git repository in /.bup/

/.bup content:

    total 40
    drwxr-xr-x  7 root root 4096 May 12 20:09 .
    drwxr-xr-x 86 root root 4096 May 12 20:09 ..
    -rw-r--r--  1 root root   23 May 12 20:09 HEAD
    drwxr-xr-x  2 root root 4096 May 12 20:09 branches
    -rw-r--r--  1 root root  116 May 12 20:09 config
    -rw-r--r--  1 root root   73 May 12 20:09 description
    drwxr-xr-x  2 root root 4096 May 12 20:09 hooks
    drwxr-xr-x  2 root root 4096 May 12 20:09 info
    drwxr-xr-x  4 root root 4096 May 12 20:09 objects
    drwxr-xr-x  4 root root 4096 May 12 20:09 refs

Creating /repo/.git...

    Initialized empty Git repository in /repo/.git/

/repo/.git content:

    total 40
    drwxr-xr-x 7 root root 4096 May 12 20:09 .
    drwxr-xr-x 3 root root 4096 May 12 20:09 ..
    -rw-r--r-- 1 root root   23 May 12 20:09 HEAD
    drwxr-xr-x 2 root root 4096 May 12 20:09 branches
    -rw-r--r-- 1 root root   92 May 12 20:09 config
    -rw-r--r-- 1 root root   73 May 12 20:09 description
    drwxr-xr-x 2 root root 4096 May 12 20:09 hooks
    drwxr-xr-x 2 root root 4096 May 12 20:09 info
    drwxr-xr-x 4 root root 4096 May 12 20:09 objects
    drwxr-xr-x 4 root root 4096 May 12 20:09 refs

Differences between /git-initial and /bup-initial:
    diff -r -u /git-initial/config /bup-initial/config
    --- /git-initial/config	2014-05-12 20:09:52.426385767 +0000
    +++ /bup-initial/config	2014-05-12 20:09:52.402385766 +0000
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
    >bup: 0.01kbytes in 0.19 secs = 0.06 kbytes/sec

Adding hello world to Git...
Note that we run 'git gc' to create a packfile (so we can compare with
Bup).

    [master (root-commit) 8063bda] Initial-commit
     1 file changed, 1 insertion(+)
     create mode 100644 data
Counting objects: 3, done.
Writing objects:  33% (1/3)   Writing objects:  66% (2/3)   Writing objects: 100% (3/3)   Writing objects: 100% (3/3), done.
Total 3 (delta 0), reused 0 (delta 0)

Differences between Git and Bup:

    Only in /git-hello-world: COMMIT_EDITMSG
    diff -r -u /git-hello-world/config /bup-hello-world/config
    --- /git-hello-world/config	2014-05-12 20:09:52.426385767 +0000
    +++ /bup-hello-world/config	2014-05-12 20:09:52.402385766 +0000
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
    --- /git-hello-world/logs/refs/heads/master	2014-05-12 20:09:52.774385774 +0000
    +++ /bup-hello-world/logs/refs/heads/master	2014-05-12 20:09:52.714385772 +0000
    @@ -1 +1 @@
    -0000000000000000000000000000000000000000 8063bdad85ed40c7afead0b8517fff93e19e1eed Your Name <you@example.com> 1399925392 +0000	commit (initial): Initial-commit
    +0000000000000000000000000000000000000000 a7bf384dc8ad970890912b9c700d49aaecfcb8c7 Your Name <you@example.com> 1399925392 +0000
    Only in /git-hello-world/objects/info: packs
    Only in /bup-hello-world/objects/pack: bup.bloom
    Only in /bup-hello-world/objects/pack: pack-7894d8202c50141d6bd28f9915cad18a2e98d781.idx
    Only in /bup-hello-world/objects/pack: pack-7894d8202c50141d6bd28f9915cad18a2e98d781.pack
    Only in /git-hello-world/objects/pack: pack-8aee6a9c06b2b989f3edcb32a36a6e49052ee20a.idx
    Only in /git-hello-world/objects/pack: pack-8aee6a9c06b2b989f3edcb32a36a6e49052ee20a.pack
    Only in /git-hello-world: packed-refs
    Only in /bup-hello-world/refs/heads: master

Running `git cat-file -p master^{tree}` for Bup...

    100644 blob 3b18e512dba79e4c8300dd08aeb37f8e728b8dad	data

And for Git...

    100644 blob 3b18e512dba79e4c8300dd08aeb37f8e728b8dad	data

Running `git verify-pack` for Bup...

    3b18e512dba79e4c8300dd08aeb37f8e728b8dad blob   12 21 12
    f97405d5cd704d755d4a228c09ad5cf4529a9431 tree   32 43 33
    a7bf384dc8ad970890912b9c700d49aaecfcb8c7 commit 235 168 76
    non delta: 3 objects
    /bup-hello-world/objects/pack/pack-7894d8202c50141d6bd28f9915cad18a2e98d781.pack: ok

And for Git...

    8063bdad85ed40c7afead0b8517fff93e19e1eed commit 169 122 12
    f97405d5cd704d755d4a228c09ad5cf4529a9431 tree   32 43 134
    3b18e512dba79e4c8300dd08aeb37f8e728b8dad blob   12 21 177
    non delta: 3 objects
    /git-hello-world/objects/pack/pack-8aee6a9c06b2b989f3edcb32a36a6e49052ee20a.pack: ok

Normally, the packfiles contain the same thing: an identical blob, an
identical tree, and a commit that differs because of its commit message.

Indeed, if we look at the commit object in Bup...

    commit a7bf384dc8ad970890912b9c700d49aaecfcb8c7
    Author: root <root@af0203e183b1>
    Date:   Mon May 12 20:09:52 2014 +0000
    
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

    commit 8063bdad85ed40c7afead0b8517fff93e19e1eed
    Author: Your Name <you@example.com>
    Date:   Mon May 12 20:09:52 2014 +0000
    
        Initial-commit
    
    diff --git a/data b/data
    new file mode 100644
    index 0000000..3b18e51
    --- /dev/null
    +++ b/data
    @@ -0,0 +1 @@
    +hello world

We can see they're the same.
