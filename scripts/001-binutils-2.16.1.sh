#!/bin/sh
# binutils-2.16.1.sh by Dan Peori (danpeori@oopo.net)

 ## Download the source code.
 wget --continue https://ftp.gnu.org/pub/gnu/binutils/binutils-2.16.1.tar.bz2 || { exit 1; }

 ## Unpack the source code.
 rm -Rf binutils-2.16.1 && tar xfvj binutils-2.16.1.tar.bz2 || { exit 1; }

 ## Enter the source directory and patch the source code.
 cd binutils-2.16.1 && cat ../../patches/binutils-2.16.1-PSP.patch | patch -p1 || { exit 1; }

 ## Create and enter the build directory.
 mkdir build-psp && cd build-psp || { exit 1; }

 ## Configure the build.
 CFLAGS="-O2 -D_FORTIFY_SOURCE=0 -DSTDC_HEADERS" ../configure --prefix="$PSPDEV" --target="psp" --enable-install-libbfd || { exit 1; }

 ## gmake is used on OSX; on others we don't use it
 if [[ x`uname` == x"Darwin" ]]; then MAKE=gmake; else MAKE=make; fi

 ## Compile and install.
 make clean && $MAKE -j 4 --eval="%.o: %.m" && make install MAKEINFO=true && make clean || { exit 1; }
