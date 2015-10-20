# Exploring Bup

This is a Docker image to play with [Bup](https://github.com/bup/bup). The idea
is to

    > make run

in this repository to see how Bup compares to Git. See `RUN.md` for the output.

There also notes about Git.

## Notes

The command

    > echo hello | git hash-object --stdin -w
    ce013625030ba8dba906f756967f9e9ca394464a

creates the file (and nothing else) in the git object store:

    .git/objects/ce/013625030ba8dba906f756967f9e9ca394464a

The result of these two commands is the same:

    > cat .git/objects/ce/013625030ba8dba906f756967f9e9ca394464a | openssl zlib -d
    # Or, if your version of openssl doesn't have a zlib subcommand:
    > cat .git/objects/ce/013625030ba8dba906f756967f9e9ca394464a | zlib-flate -uncompress
    > printf 'blob 6\x00hello\n'

Thus `git hash-object -w` can be replaced by

    > printf 'blob 6\x00hello\n' | sha1sum
    ce013625030ba8dba906f756967f9e9ca394464a
    # Not exactly...
    > printf 'blob 6\x00hello\n' | openssl zlib > .git/objects/ce/013625030ba8dba906f756967f9e9ca394464a

but (using the original object):

    > cat .git/objects/ce/013625030ba8dba906f756967f9e9ca394464a | openssl zlib -d | openssl zlib > a
    > printf 'blob 6\x00hello\n' | openssl zlib > b
    > diff a b

    > cat .git/objects/ce/013625030ba8dba906f756967f9e9ca394464a > a
    > diff a b
    Binary files a and b differ

and

    > file a
    a: VAX COFF executable not stripped
    > file b
    b: data

The reason is that it seems Git and `openssl zlib` don't use the same
compression level (hence the two-byte headers are different).

    > printf 'blob 6\x00hello\n' | zlib-flate -compress > a
    > hexdump a
    0000000 9c78 ca4b 4fc9 3052 c863 cd48 c9c9 02e7
    0000010 1d00 04c5 0014
    0000015
    > hexdump .git/objects/ce/013625030ba8dba906f756967f9e9ca394464a
    0000000 0178 ca4b 4fc9 3052 c863 cd48 c9c9 02e7
    0000010 1d00 04c5 0014
    0000015
