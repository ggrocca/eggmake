# EggMake

[//]: # (A lightweight, automated build system based on GNU make. Just define your flags and sources and compile using make, without having to write a custom makefile.)

EggMake is a GNU make library that implements a lightweight build system for C/C++ software development. The long term goal is to get rid of all the complexity and hassle that sometimes comes with tools such as qmake, CMake, SCons, and automake/autoconf, for the compilation of small or specialized projects. The build system relies on GNU make only, and strives to be fast, easy and comfortable to use.

In the simplest case, it's enough to write a `Makefile` that:

* Defines some variables. The most important one is:  
`SOURCES = my_main.cpp your_module.cpp <...>`

* Includes the EggMake library, using the line `include ./eggmakelib/engine.mk`)

* And then, everything works. Type `make` and compile your project.

Essentially, EggMake offers a general, fully-featured Makefile with a lot of automatic features and customizable options. All the complex details of implementing a non-recursive, modern, make-based build system are already figured out and hidden away.


## Status

This is alpha software - it's more of a proof-of-concept that anything else. It should work fine for building experimental and specialized software projects in academic environments, though, where you usually have very small teams doing experimental work that changes fast. In fact, most of its features have been developed with this use case in mind - it should be very easy for each developer/researcher to customize his build and commit everything to a common repository without breaking the work of other co-developers. However, as more complex features are added (e.g. for taking care of testing, distribution and installation), there is no reason for EggMake not being able to scale to bigger, more production-like projects.


## Prerequisites and installation

The only requisites are GNU Make (see Paul's first [rule of Makefiles](http://make.mad-scientist.net/papers/rules-of-makefiles/)) and a working posix shell. Use a fairly recent version of GNU Make. Oldest version that I am currently testing with is 4.1. Anything below 3.81 won't work for sure. Be aware that some features are tested only for gcc and llvm compilers. Any compiler whose interface is compatible to gcc's should work.

Clone the repository:
```
git clone https://github.com/ggrocca/eggmake.git eggmake.git
```
and copy the files inside the eggmakelib directory to any destination you want. My suggestion is to copy eggmakelib to the root of your project:
```
cp -R eggmake.git/eggmakelib /path/to/your/project/
```
Nothing changes on your system, and any hack you might add to the library remains private to the current project.

Consider adding the `eggmakelib` directory to your version controlled repository, for any project that you want to use it on. It's quite small, and your users will download everything they need to compile the code when they clone the repo. If you later work on a hack or bugfix to eggmakelib that you want to send back here (that would be very much appreciated), just make a `diff -ru` patch between your directory and the cloned EggMake repo. Add the patch to your repo, and make a pull request.

Alternatively, you might considers places in your home directory such as `~/lib/eggmakelib`, or `~/.eggmakelib` (if you prefer an hidden directory). You could install system-wide to `/usr/local/share` or `/opt/local/share`, but I would consider this to be overkill.


## Write your makefile

Copy the file `examples/reference/Makefile` to the directory where you need your compilation target to be.
```
cp eggmake.git/examples/reference/Makefile /path/to/your/project/
```

Set the following things:

* `TARGET`, the name of your executable

* `SOURCES`, with all the names of your C++ and C modules that need to be compiled (in all the directories they are to be found in).

* If your sources are to be found in directories different from the working where the makefile is, add them to `VPATH`. Do not add directory names to `SOURCES`.

* Optionally, add the right directives to the right variables, such as `FLAGS`, `DEFINES`, `INCLUDES`, `LDFLAGS` (see supported variables, with comments, in `examples/reference/Makefile`).

* Finally, include the eggmake library: `include ./eggmakelib/engine.mk`.

* Compile by calling the command `make`.

For more advanced features:

* Consult comments and explanations inside the reference makefile `examples/reference/Makefile` and/or the other examples for more advanced functionality (each example is a project stub with source that compiles).

* `examples/reference/` is an almost empty project, but the makefile contains every usable variable and feature, commented out and explained.

* `examples/flags` is a simple project that sets and personalizes different compilation flags depending on different conditions.

* `examples/multitarget` shows how to build multiple binaries in the same directory.

* `examples/autogencode` contains a working example with automatic code generation (both headers only, and headers and sources).

* `examples/mixedccpp` contains a working example that mixes C and C++ code (and different C++ modules with different files extensions, too).


## Features

The most important one is that __everything is implemented in less than a three hundred lines__ (with comments), and that the only thing that is needed to understand them is the GNU Make manual (and/or the countless stack overflow answers on make). Beside that:

* __Automatic generation of dependencies__. This happens automatically.

* __Easy configuration of custom compilation flags, used by different types of targets__. Commands `make` or `make all` get you a release mode compilation that uses only the standard compilation flags that you define. Currently implemented custom targets are: `make debug` (debugging flags), `make trace` (statically compiled verbose tracing output), `make static` (a statically linked binary), and combinations of them (`debugtrace staticdebug statictrace staticdebugtrace`). It's up to you to fill in the right flags for compiling in these modes for your project, if you care about using them (see the reference Makefile for the appropriate variable names, which are by the way quite intuitive).

* __Easy customization of the previously defined compilation flags depending on the current environment and system__ (operating system, hostname, username, etc). See commented out `System-dependent configuration` and `User-dependent configuration` sections in the reference Makefile. These are just suggestions, you can modify the compilation flags using any custom check you want by calling out arbitrary shell commands and by reading environment variables. See the `examples/flags` example.

* __Support for building multiple binaries per directory__ (for example, a util directory inside your repository that contains code for several smaller utilities). This can be done by writing a master `Makefile` which defines all the executable names (`TARGETS= <first-target> <second target> <...>`) and includes `./engine/multitarget.mk`, and by writing secondary makefiles named `Makefile.<name-of-first-target>`, `Makefile.<name-of-second-target>`, `Makefile.<...>`, one for each executable. The command `make` compiles all the targets in release mode, `make debug` all the targets in debug mode, and so on. If you want to compile a single executable, you can (intuitively) do that by using the commands `make <name-of-target>` (release mode), `make <name-of-target> debug` (debug mode), and on and on. See the `examples/multitarget` example.
 
* __This is still is a standard makefile__. Add to your makefile anything that works inside makefiles - conditionals, hacks, additional rules, calls to the shell, whatever. Just remember to include the eggmake library in the last line.
 
* __Almost no dependencies__. It should work on any OS capable of running GNU Make and a posix shell. Currently tested on: MacOSX (gnu make installed via ports, or via brew), and Arch Linux.

* __No need to clean everything when you change the Makefile__. The build depends on the makefile itself, to avoid annoying issues that could happen when you change it (this can be disabled, optionally).

* __No need to clean everything when you change the target__. The build also depends dynamically on the target type given on the command line. If the compilation command line suddenly changes from release to debug, or the other way around, everything is recompiled, to avoid fastidious bugs (again, this can be disabled).

* __Currently supported languages: C and C++__. Other languages should be quite easy to add though. If there's a language you might like to see supported, open an issue and give me info on which default compiler might be added, about its command line usage, default file extensions of sources, etc. For instance, it would be nice to have Objective C support...

* __Support for automatic code generation with arbitrary methods__. Write custom rules that generates `.c` and `.h` files according to what you need, add the names of generated files to variable `AUTO_SOURCES` and `AUTO_HEADERS`, and you're good to go. See the `autogencode` example.

* __Projects that mix linking of both C and C++ code at the same time are supported__. C and C++ have language specific flags that you can add; the general flags are used for both. Files with `.c` extension are always considered C files and compiled as such. Files with extensions `.cpp .cxx .c++ .cc .C` are considered C++ sources. Header files may have any extension (or no extension at all). Remember to wrap your C headers inside an `extern "C" { ... }` directive, if `__cplusplus` is defined. See the `mixedccpp` example.


## Why, and why not

This could be the right build system if one or more of the following points apply:

* You're working on a demo or proof-of-concept that needs rapid development and is often refactored.

* Your project is small to medium sized.

* You want a simple and reliable build system that is easy to understand, easy to hack, tinkerable with, and has (almost) no external dependencies.

* You want direct and immediate control over what flags, include and linking directives are feeded to the compiler.

* Long story short, if you want a build system that shuts up, does what it's told, has no special needs, and it's fast.

On the other hand, avoid it (at least for now) if:

* Your project has a lot of dependencies, and you want to make sure they are all checked and fulfilled, on many different environments.

* You have a lot of users, and they expect to find standard `configure && make && make install` commands.



## Warnings, credits, references.

Use this at your peril! It's alpha software. A build system can introduce subtle bugs inside the software it builds - or at least byzantinely cooperate to the bug-producing efforts. It launches unchecked file removal commands inside your build directory every time the `clean` target is used. Backup often and use a modern version control software.

Keep in mind that right now every compilation directory is a monad - if your project builds a lot of executables inside different directories, it's up to you to go inside each directory and compile what's there. But, every executable knows exactly what it needs to achieve its compilation. This is good, because the problem of determination of dependencies becomes local to the target, and its object files can be made private. This incredibly simplifies development in fast-changing environments. The drawback is that every object file is recompiled _N_ times, one for each _Nth_ executable that depends on it.

I freely admit that this is just a packaging of a collection of hacks that I developed and/or collected over the years. Credit goes to a lot of people and resources I cannot remember, and to the stackoverflow community. Everything started a lot of time ago, by reading the now classic [recursive make considered harmful](http://aegis.sourceforge.net/auug97.pdf), by Peter Miller.

Other resources:

* The [Official GNU Make docs](https://www.gnu.org/software/make/).
* The [SO makefile tag](http://stackoverflow.com/questions/tagged/makefile), [SO make tag](http://stackoverflow.com/questions/tagged/make), and related tags.
* See [Non recursive make, by Emile van Bergen](http://evbergen.home.xs4all.nl/nonrecursive-make.html).
* Read [anything written by Paul D. Smith](http://make.mad-scientist.net/papers/).

Although I use several ideas of his, I did not use the [autodeps technique by Tom Tromey](http://make.mad-scientist.net/papers/advanced-auto-dependency-generation/), which involves computing dependencies during compilation and not before. My catch was that I could not make it work with automatic generation of headers - maybe I'm missing something. I also failed to encounter the problems he mentions about computing dependencies before compilation and automatic code generation... YMMV.

Similar efforts:

* [boilermake on github](https://github.com/dmoulding/boilermake/)
* [nonrec-make on github](https://github.com/aostruszka/nonrec-make/)

I believe that a lot of developers, projects and shops wrote similar build systems for their own projects in the past. Modern GNU Make now should have all the features that are needed for developing a general build system that is fast, customizable, easy to use, and mantained as a separate, standalone project.

Make has disadvantages too. See [What's Wrong With GNU Make](http://www.conifersystems.com/whitepapers/gnu-make/), a white paper about what is wrong with the make language in general (despite referring to the GNU implementation, the criticism applies to the language as a whole). My personal opinion is that most of the points made in the article can be solved or mitigated by avoiding writing custom makefiles, and doing the right things once and for all in a make library, as this project tries to do. The fact is, most other build system usually just build a Makefile on unix systems, and add their own complexity on top of that, which is slow, cumbersome, and a source of problems. I am not aware of any build system that avoids make altogether and is as fast, portable and full featured as GNU Make is. The day that such a beast will be born, and offers a clean functional language that has none of the quirks of make's language, make will finally stop being used for new projects (and will still remain supported until the end of history anyway, given how many existing projects rely on it - but that's another story). A very interesting project seems to be [tup](http://gittup.org/tup/), but I don't know if it's ready for prime time yet.

Constructive feedback and criticism is appreciated. The make code I wrote and hacked together is certainly not the best you can find. It should work, though, and if it does not and you care enough, please send me a bug report.


## To be done

Things that will be hopefully added sooner rather than later, plus other random ideas:

* Compilation of libraries (.a archives, dynamically loaded libraries - .so/dylib/dll etc).

* Support for Windows, and in general a more systematic way of checking the operating system, its version, and the underlying hardware architecture. Drop the requisite for a POSIX shell, or at least provide an alternative for widely used operating systems that don't have one.

* Building all targets inside subdirectories from parent directories (ideally, a single make command in the root dir should recompile everything).

* An option for sharing object files between executables. This would mean a faster compilation when producing a full binary release.

* Implementation of customary `install` and `dist` targets.

* Support the creation of custom targets for the cross compilation of different architectures.

* Optionally support build directories private to the target type (e.g. `build.target.debug` for debugging, etc), to avoid recompilation of all object files when going back and forth between different types of builds.

* Support for `test` targets, for simpler development of unit tests, etc.

Check the `TODO.org` file for more details. If the most important among these new features are added, eggmake could (maybe) be used in big projects too.
