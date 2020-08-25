#!/bin/sh
# gdb-6.4.sh by Dan Peori (danpeori@oopo.net)

 ## Download the source code.
 wget --continue ftp://ftp.gnu.org/pub/gnu/gdb/gdb-6.4a.tar.bz2 || { exit 1; }

 ## Unpack the source code.
 rm -Rf gdb-6.4 && tar xfvj gdb-6.4a.tar.bz2 || { exit 1; }

 ## Enter the source directory and patch the source code.
 cd gdb-6.4 && cat ../../patches/gdb-6.4-PSP.patch | patch -p1 || { exit 1; }

 ## Create and enter the build directory.
 mkdir build-psp && cd build-psp || { exit 1; }

 ## Configure the build.
 CC=gcc-9 CXX=gcc-9 CFLAGS="-g -O2 -Wno-error=unused-but-set-variable -Wno-error=implicit-fallthrough= -Wno-error=unused-value -Wno-error=cast-function-type -Wno-error=format-overflow= -Wno-error=pointer-compare -std=gnu89 -D_FORTIFY_SOURCE=0" ../configure --prefix="$PSPDEV" --target="psp" --disable-nls || { exit 1; }

 ## Compile and install.
 make clean && make -j 4 MAKEINFO=true && make install MAKEINFO=true && make clean || { exit 1; }
