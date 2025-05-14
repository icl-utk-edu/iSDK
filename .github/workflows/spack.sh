#!/bin/bash -e

set +x
trap 'echo "# $BASH_COMMAND"' DEBUG

unset USER
export HOME=`pwd`

[ -z "$SPACK" ] && SPACK=https://github.com/spack/spack
git clone $SPACK
source spack/share/spack/setup-env.sh

spack config add "packages:all:target:[x86_64]"
spack config add "packages:all:require:'%gcc'"
spack config add "config:install_tree:padded_length:128"
CACHE=/apps/spacks/buildcache/github
spack mirror add --unsigned mycache file://$CACHE

save_buildcache() {
  spack buildcache push --unsigned file://$CACHE
}
trap 'save_buildcache' EXIT

# Set up the compiler
C_PKG=${COMPILER/oneapi/intel-oneapi-compilers}
spack env activate --temp
spack add $C_PKG
spack install
spack load $C_PKG
spack compiler find
spack env deactivate
spack config change "packages:all:require:'%$COMPILER'"

# Install the main package
spack env create --without-view myenv
spack env activate myenv
spack add $SPEC
spack install --fail-fast --fresh --only=dependencies
spack install --no-cache --overwrite -y

spack load papi
papi_component_avail
