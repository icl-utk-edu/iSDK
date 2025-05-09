#!/bin/bash --login

set -e
set +x
trap 'echo "# $BASH_COMMAND"' DEBUG

unset USER
export HOME=`pwd`

[ -z "$SPACK" ] && SPACK=https://github.com/spack/spack
git clone $SPACK
source spack/share/spack/setup-env.sh

# Set up binary mirror
spack gpg trust $KEY.priv
spack gpg trust $KEY.pub
spack config add "config:install_tree:padded_length:128"
FINGER=`gpg --show-keys --with-fingerprint --with-colons $KEY.priv | grep fpr | sed s/fpr:*// | sed s/://`
[ -z "$FINGER" ] && exit 1
spack mirror add --scope=site --type=binary test \
   http://spack-cache.icl.utk.edu/cache/$FINGER

if ! spack COMPILER info $COMPILER; then
   C_PKG=${COMPILER/oneapi/intel-oneapi-compilers}
   spack load --first $C_PKG || spack install $C_PKG
   spack load --first $C_PKG
   spack compiler find
fi
spack env activate --temp
spack add $SPEC %$COMPILER
spack add $C_PKG
spack install --fail-fast --no-cache --overwrite -y --fresh
curl http://spack-cache.icl.utk.edu/client | perl


