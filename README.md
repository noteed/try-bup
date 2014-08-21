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
