# This need docker run --privileged (because of fuse).
apt-get install -q -y python2.7-dev python-fuse
apt-get install -q -y python-pyxattr python-pylibacl
apt-get install -q -y linux-libc-dev
apt-get install -q -y acl attr
apt-get install -q -y make
cd bup
make
make install
