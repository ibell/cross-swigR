Cross-compiling R extensions for windows using MinGW and swig from linux

It is quite painful to compile R extensions on windows, so here is an example of cross-compiling a simple example for windows from linux

Pre-requisites:

* MinGW packages in synaptic
* mingw-w64-tools (needed for gendef)

Setup before running script
* Install wine
* Install R into your wine installation using the graphical installer
* Install swig (might want to build from source, the one in default repos is quite old)

The build.sh script in this repo has the contents summarized below

N.B., you'll have to change the paths, everything is hardcoded here

N.B., By default mingw builds a 32-bit dll, which can be changed by setting ``-m64`` compiler flag to get 64-bit build if desired.  Paths should of course also be updated.

* Generate the swig wrapper code in example_wrap.c
```
swig -r example.i
```
* Generate a .def file with the exports from the windows DLL
```
gendef "/home/ian/.wine/drive_c/Program Files/R/R-3.1.3/bin/i386/R.dll" - > exports.def
```
* Build an import library for the R DLL using dlltool
```
i686-w64-mingw32-dlltool -d exports.def -l libR.a
```
* Finally, compile everything into a windows DLL
```
i686-w64-mingw32-gcc example_wrap.c example.c -I"/home/ian/.wine/drive_c/Program Files/R/R-3.1.3/include/" -L. -lR -shared -o example.dll
```
* Once that is all done, you can run the test script in wine
```
wine "/home/ian/.wine/drive_c/Program Files/R/R-3.1.3/bin/i386/R.exe" -f runme.R
```
I found that running the script made the stdin of the console stop working for some reason.  Closing the console seemed the only solution
