
iSDK: ICL Software Development Kit
--------------------------------------------------------------------------------

The iSDK (ICL Software Development Kit) combines the software projects of the Innovative
Computing Laboratory at the University of Tennessee, Knoxville into a unified environment
to facilitate use of the included projects in end-user applications and tools.  The iSDK
provides a number of tested and verified environments:

* GCC and Intel OneAPI compilers
* NVidia, AMD, and Intel GPU accelerators

The iSDK includes interoperability between the following projects:

* [MAGMA](https://icl.utk.edu/magma/)
* [SLATE](https://icl.utk.edu/slate/)
* [PAPI](https://icl.utk.edu/papi/)
* [Ginkgo](https://ginkgo-project.github.io/)
* [HeFFTe](https://icl.utk.edu/fft/)
* [PaRSEC](https://icl.utk.edu/parsec/)

How To Use
--------------------------------------------------------------------------------
The iSDK is distributed as a set of [Spack](https://github.com/spack/spack) environments
which contain a vetted set of ICL software versions and all required dependencies.
Start by setting up a Spack installation if you do not yet have one:

```bash
$ git clone https://github.com/spack/spack
$ source spack/share/spack/setup-env.sh
```

Then check out the iSDK git repository and create the iSDK envionment
based on your desired compiler and accelerator:

```
$ git clone https://github.com/icl-utk-edu/iSDK
$ spack env create iSDK iSDK/env-gcc-cuda.yaml
$ spack install
```

This will build and install the full environment from source code. If you wish to modify the
environment, you may do so before installing by using the spack utility.  For example, to remove the MAGMA 
package:

```
$ spack rm magma
```

If you make changes after installation, you will need to "concretize" the configuration again before re-installations:

```
$ spack concretize --force
$ spack install
```

Once the environment is installed and activated you can build your application code.

Contributing
--------------------------------------------------------------------------------

The iSDK welcomes contributions via git pull request to https://github.com/icl-utk-edu/iSDK .

License
--------------------------------------------------------------------------------

Copyright (c) 2017-2023, University of Tennessee. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.

* Neither the name of the University of Tennessee nor the
  names of its contributors may be used to endorse or promote products
  derived from this software without specific prior written permission.

**This software is provided by the copyright holders and contributors "as is" and
any express or implied warranties, including, but not limited to, the implied
warranties of merchantability and fitness for a particular purpose are
disclaimed. In no event shall the copyright holders or contributors be liable
for any direct, indirect, incidental, special, exemplary, or consequential
damages (including, but not limited to, procurement of substitute goods or
services; loss of use, data, or profits; or business interruption) however
caused and on any theory of liability, whether in contract, strict liability, or
tort (including negligence or otherwise) arising in any way out of the use of
this software, even if advised of the possibility of such damage.**
