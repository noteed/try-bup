docker run -v `pwd`:/source -t -i images.reesd.com/noteed/bup sh /source/script.sh

Creating /.bup...

    Initialized empty Git repository in /.bup/

/.bup content:

    total 40
    drwxr-xr-x  7 root root 4096 Jul 29 21:31 .
    drwxr-xr-x 91 root root 4096 Jul 29 21:31 ..
    -rw-r--r--  1 root root   23 Jul 29 21:31 HEAD
    drwxr-xr-x  2 root root 4096 Jul 29 21:31 branches
    -rw-r--r--  1 root root  116 Jul 29 21:31 config
    -rw-r--r--  1 root root   73 Jul 29 21:31 description
    drwxr-xr-x  2 root root 4096 Jul 29 21:31 hooks
    drwxr-xr-x  2 root root 4096 Jul 29 21:31 info
    drwxr-xr-x  4 root root 4096 Jul 29 21:31 objects
    drwxr-xr-x  4 root root 4096 Jul 29 21:31 refs

Creating /repo/.git...

    Initialized empty Git repository in /repo/.git/

/repo/.git content:

    total 40
    drwxr-xr-x 7 root root 4096 Jul 29 21:31 .
    drwxr-xr-x 3 root root 4096 Jul 29 21:31 ..
    -rw-r--r-- 1 root root   23 Jul 29 21:31 HEAD
    drwxr-xr-x 2 root root 4096 Jul 29 21:31 branches
    -rw-r--r-- 1 root root   92 Jul 29 21:31 config
    -rw-r--r-- 1 root root   73 Jul 29 21:31 description
    drwxr-xr-x 2 root root 4096 Jul 29 21:31 hooks
    drwxr-xr-x 2 root root 4096 Jul 29 21:31 info
    drwxr-xr-x 4 root root 4096 Jul 29 21:31 objects
    drwxr-xr-x 4 root root 4096 Jul 29 21:31 refs

Differences between /git-initial and /bup-initial:

    diff -r -u /git-initial/config /bup-initial/config
    --- /git-initial/config	2014-07-29 21:31:52.881564160 +0000
    +++ /bup-initial/config	2014-07-29 21:31:52.837564161 +0000
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
    >bup: 0.01kbytes in 0.20 secs = 0.06 kbytes/sec

Adding hello world to Git...
Note that we run 'git gc' to create a packfile (so we can compare with
Bup).

    [master (root-commit) 34ed4b3] Initial-commit
     1 file changed, 1 insertion(+)
     create mode 100644 data

Differences between Git and Bup:

    Only in /git-hello-world: COMMIT_EDITMSG
    diff -r -u /git-hello-world/config /bup-hello-world/config
    --- /git-hello-world/config	2014-07-29 21:31:52.881564160 +0000
    +++ /bup-hello-world/config	2014-07-29 21:31:52.837564161 +0000
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
    --- /git-hello-world/logs/refs/heads/master	2014-07-29 21:31:53.257564151 +0000
    +++ /bup-hello-world/logs/refs/heads/master	2014-07-29 21:31:53.177564153 +0000
    @@ -1 +1 @@
    -0000000000000000000000000000000000000000 34ed4b352069e273d3727a9bdfa2980ba1b3afbf Your Name <you@example.com> 1406669513 +0000	commit (initial): Initial-commit
    +0000000000000000000000000000000000000000 d76212eb0ae6ae08ae8b05eded499467d8e49dc0 Your Name <you@example.com> 1406669513 +0000
    Only in /git-hello-world/objects/info: packs
    Only in /bup-hello-world/objects/pack: bup.bloom
    Only in /git-hello-world/objects/pack: pack-029e7398e0e127da720191e3a98e4c3eb4e806d5.idx
    Only in /git-hello-world/objects/pack: pack-029e7398e0e127da720191e3a98e4c3eb4e806d5.pack
    Only in /bup-hello-world/objects/pack: pack-6e435d67bf81c28f565c63a4ee5f3cb36a7e38a1.idx
    Only in /bup-hello-world/objects/pack: pack-6e435d67bf81c28f565c63a4ee5f3cb36a7e38a1.pack
    Only in /git-hello-world: packed-refs
    Only in /bup-hello-world/refs/heads: master

Running `git cat-file -p master^{tree}` for Bup...

    100644 blob 3b18e512dba79e4c8300dd08aeb37f8e728b8dad	data

And for Git...

    100644 blob 3b18e512dba79e4c8300dd08aeb37f8e728b8dad	data

Running `git verify-pack` for Bup...

    3b18e512dba79e4c8300dd08aeb37f8e728b8dad blob   12 21 12
    f97405d5cd704d755d4a228c09ad5cf4529a9431 tree   32 43 33
    d76212eb0ae6ae08ae8b05eded499467d8e49dc0 commit 235 170 76
    non delta: 3 objects
    /bup-hello-world/objects/pack/pack-6e435d67bf81c28f565c63a4ee5f3cb36a7e38a1.pack: ok

And for Git...

    34ed4b352069e273d3727a9bdfa2980ba1b3afbf commit 169 122 12
    f97405d5cd704d755d4a228c09ad5cf4529a9431 tree   32 43 134
    3b18e512dba79e4c8300dd08aeb37f8e728b8dad blob   12 21 177
    non delta: 3 objects
    /git-hello-world/objects/pack/pack-029e7398e0e127da720191e3a98e4c3eb4e806d5.pack: ok

Normally, the packfiles contain the same thing: an identical blob, an
identical tree, and a commit that differs because of its commit message.

Indeed, if we look at the commit object in Bup...

    commit d76212eb0ae6ae08ae8b05eded499467d8e49dc0
    Author: root <root@bd686a690a7e>
    Date:   Tue Jul 29 21:31:52 2014 +0000

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

    commit 34ed4b352069e273d3727a9bdfa2980ba1b3afbf
    Author: Your Name <you@example.com>
    Date:   Tue Jul 29 21:31:53 2014 +0000

        Initial-commit

    diff --git a/data b/data
    new file mode 100644
    index 0000000..3b18e51
    --- /dev/null
    +++ b/data
    @@ -0,0 +1 @@
    +hello world

We can see they're the same.

## New data

Here we see that using `bup split` again replaces the previous data.

    >>
    >bup: 0.01kbytes in 0.18 secs = 0.06 kbytes/sec
    commit 3f0efd896af56caa4619c388c611f07d9a9c5d2b
    Author: root <root@bd686a690a7e>
    Date:   Tue Jul 29 21:31:54 2014 +0000

        bup split

        Generated by command:
        ['/usr/lib/bup/cmd/bup-split', '-n', 'master', '-vv']

    diff --git a/data b/data
    index 3b18e51..2e2359e 100644
    --- a/data
    +++ b/data
    @@ -1 +1 @@
    -hello world
    +Bup is nice

## Chunks

We `bup split` some additional data...

    >>>>
    >bup: 9.00kbytes in 0.19 secs = 47.75 kbytes/sec
    /.bup/objects/pack
    |-- bup.bloom
    |-- pack-3963107ba7db6fe1512519ce6d8c6738e5d2df77.idx
    |-- pack-3963107ba7db6fe1512519ce6d8c6738e5d2df77.pack
    |-- pack-6e435d67bf81c28f565c63a4ee5f3cb36a7e38a1.idx
    |-- pack-6e435d67bf81c28f565c63a4ee5f3cb36a7e38a1.pack
    |-- pack-9ea447f500b2c45399eaa1bda548afedaa74e97d.idx
    `-- pack-9ea447f500b2c45399eaa1bda548afedaa74e97d.pack

    0 directories, 7 files
    3033d7e0acbd13d37ef2bf945ebcc5cbdf83959d blob   4494 4508 12
    f010aee1a5cdef308b0549ec707a428fcdcb5e2b blob   4722 4736 4520
    7158ae478d8d164b141010de3e413ee88ca14243 tree   64 71 9256
    5d186ca8ca46661e419fc1510926fbba55474dbe tree   35 44 9327
    4b8288a59906b8d6da5a50ae45cea810a759f546 commit 283 200 9371
    non delta: 5 objects
    /.bup/objects/pack/pack-9ea447f500b2c45399eaa1bda548afedaa74e97d.pack: ok
    commit 4b8288a59906b8d6da5a50ae45cea810a759f546
    Author: root <root@bd686a690a7e>
    Date:   Tue Jul 29 21:31:55 2014 +0000

        bup split

        Generated by command:
        ['/usr/lib/bup/cmd/bup-split', '-n', 'master', '-vv']

    diff --git a/data b/data
    deleted file mode 100644
    index 2e2359e..0000000
    --- a/data
    +++ /dev/null
    @@ -1 +0,0 @@
    -Bup is nice
    diff --git a/data.bup/0000 b/data.bup/0000
    new file mode 100644
    index 0000000..3033d7e
    Binary files /dev/null and b/data.bup/0000 differ
    diff --git a/data.bup/118e b/data.bup/118e
    new file mode 100644
    index 0000000..f010aee
    Binary files /dev/null and b/data.bup/118e differ
