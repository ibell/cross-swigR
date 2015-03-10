
# Cross-compiling swig (is this strictly necessary?)
# export CXX=i686-w64-mingw32-g++
# export CC=i686-w64-mingw32-gcc
# git clone https://github.com/swig/swig.git
# cd swig
# wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.35.tar.gz
# Tools/pcre-build.sh #
# ./autogen.sh
# ./configure LDFLAGS="-static-libgcc -static-libstdc++ -static"
# make
# wine swig.exe -version

swig -version
swig -r example.i
# from the mingw-x64-tools package
gendef "/home/ian/.wine/drive_c/Program Files/R/R-3.1.3/bin/i386/R.dll" - > exports.def
i686-w64-mingw32-dlltool -d exports.def -l libR.a
i686-w64-mingw32-gcc example_wrap.c example.c -I"/home/ian/.wine/drive_c/Program Files/R/R-3.1.3/include/" -L. -lR -shared -o example.dll

