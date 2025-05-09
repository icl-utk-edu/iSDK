#!/bin/bash --login

set -e
set +x
trap 'echo "# $BASH_COMMAND"' DEBUG

unset USER
export HOME=`pwd`

[ -z "$SPACK" ] && SPACK=https://github.com/spack/spack
git clone $SPACK
source spack/share/spack/setup-env.sh

spack config add "config:install_tree:padded_length:128"
CACHE=/tmp/github/buildcache
mkdir -p $CACHE
spack mirror add --unsigned mycache file://$CACHE

if ! spack COMPILER info $COMPILER; then
   C_PKG=${COMPILER/oneapi/intel-oneapi-compilers}
   spack load --first $C_PKG || spack install $C_PKG
   spack load --first $C_PKG
   spack compiler find
fi
spack env activate -V --temp
spack add $SPEC %$COMPILER
spack add $C_PKG
spack install --fail-fast --no-cache --overwrite -y --fresh
spack buildcache push --unsigned file://$CACHE



