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

save_buildcache() {
  spack buildcache push --unsigned file://$CACHE
}
trap 'save_buildcache' ERR

# Set up the compiler
C_PKG=${COMPILER/oneapi/intel-oneapi-compilers}
spack env activate --temp
spack add $C_PKG
spack install
save_buildcache
spack load $C_PKG
spack compiler find
spack env deactivate

# Install the main package
spack env create --without-view myenv
spack env activate myenv
spack add $SPEC %$COMPILER
spack install --fail-fast --no-cache --overwrite -y --fresh
save_buildcache

