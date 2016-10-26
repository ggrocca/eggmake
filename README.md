# EggMake

[//]: # (A lightweight, automated build system based on GNU make. Just define your flags and sources and compile using make, without having to write a custom makefile.)

EggMake is a GNU make library that implements a lightweight build system for C/C++ software development. Main features:

* Automatic generation of dependencies.

* Easy setting of source files (add single files or whole directories depending on your needs), compiler flags and directives.

* Everything can be customized depending on the system and environment.

* Generate executables (default) or static and dynamic libraries.

* Multiple targets available for configuration in addition to `all` and `clean` (`release`, `debug`, `static`, etc).


In the simplest case, it's enough to write a `Makefile` that:

* Defines all the source files that your project depends on

		egg_SOURCES := my_main.cpp your_module.cpp <...>

* Includes the EggMake library

		include ./eggmakelib/engine.mk

* And then, everything works. Type `make` and compile your project.

Essentially, EggMake offers a general, fully-featured Makefile with a lot of automatic features and customizable options. Many complex details involved in implementing a non-recursive, modern, make-based build system are already figured out and hidden away inside the library.

## Goals and status

The long term goal is to get rid of all the complexity and hassle that sometimes comes with tools such as qmake, CMake, SCons, and automake/autoconf, for the compilation of small or specialized projects. The build system relies on GNU make only, and strives to be fast, easy and comfortable to use.

This is alpha software; it's a rough proof-of-concept more than anything else. It should work fine for building experimental and specialized software projects in research environments, though, where you usually have very small teams doing fast-changing work. In fact, most of its features have been developed with this use case in mind. It should be very easy for each developer/researcher to customize his build and commit everything to a common repository without breaking the work of other co-developers. However, as more complex features are added (e.g. for taking care of testing, distribution and installation), there is no reason for EggMake not being able to scale to bigger, more production-like projects.


## Prerequisites and installation

The only requisites are GNU Make (see Paul's first [rule of Makefiles](http://make.mad-scientist.net/papers/rules-of-makefiles/)) and a working posix shell. Use a fairly recent version of GNU Make. Oldest version that I am currently testing with is 4.1. Anything below 3.81 won't work for sure. Be aware that some features are tested only for gcc and llvm compilers. Any compiler whose interface is compatible to gcc's should work. Automatic generation of dependencies needs compiler options `-MM -MP -MG -MF -MT` to work.

Clone the repository:

```
$ git clone https://github.com/ggrocca/eggmake.git eggmake.git
```

and copy the files inside the eggmakelib directory to any destination you want. My suggestion is to copy eggmakelib to the root of your project:

```
$ cp -R eggmake.git/eggmakelib /path/to/your/project/
```

Nothing changes on your system, and any hack you might add to the library remains private to the current project.

Consider adding the `eggmakelib` directory to your version controlled repository, for any project that you want to use it on. It's quite small, and your users will download everything they need to compile the code when they clone the repo. If you later work on a hack or bugfix to eggmakelib that you want to send back here (that would be very much appreciated), just make a `diff -ru` patch between your directory and the cloned EggMake repo. Add the patch to your repo, and make a pull request.

Alternatively, you might considers places in your home directory such as `~/lib/eggmakelib`, or `~/.eggmakelib` (if you prefer an hidden directory). You could install system-wide to `/usr/local/share` or `/opt/local/share`, but I would consider this to be overkill.


## Write your makefile

Copy the file `examples/reference/Makefile` to the directory where you need your compilation target to be.

```
$ cp eggmake.git/examples/reference/Makefile /path/to/your/project/
```


Set the following things:

* `egg_TARGET`, the name of your executable:

		egg_TARGET := programexe.out

* `egg_SOURCES`, with all the names of your C++ and C modules that need to be compiled (in all the directories they are to be found in):

		egg_SOURCES := main.cpp module.cpp again_cpluplus.cc and_plain_C_too.c

* If your sources are to be found in directories different from the working directory where the makefile is, add them to `egg_SOURCE_PATH`. Do not add directory names to `SOURCES`. There is no need to add the working directory, and relative paths start from there. For example:

		egg_SOURCE_PATH := common_modules/ features/baz/ features/foo/
		<...>
		egg_SOURCE_PATH += ../../veryfar/tree/with/othercode

* You can also use the variable `egg_DIR_SOURCES` to add to your project all the source files contained in the given directories, automatically:

		egg_DIR_SOURCES := add/dir1 ../add/dir2 ../../etc/

* Optionally, customize your preprocessor and compiler flags. See a very rough example in `examples/flags/Makefile`). `egg_FLAGS` flags are always used, and you can add there any custom directive, include or define:

		MY_DEFINES := -DAZANG -DZVING
		MY_INCLUDES := -I/usr/include/
		egg_FLAGS := -Wall $(MY_DEFINES) $(MY_INCLUDES)
EggMake also adds any flag you might define with customary `CPPFLAGS` (preprocessor flags), `CFLAGS` (C specific) or `CXXFLAGS` (C++ specific) variables in your command line or environment.

* Optionally, customize your linking flags:

		egg_LDFLAGS := -L/opt/local/lib
		egg_LDLIBS := -loptlib
EggMake also adds any flag that you might define inside standard `LDFLAGS` and `LDLIBS` variables in your command line, or in your environment.

* Finally, include the eggmake library:

		include ./eggmakelib/engine.mk

* Compile by calling the command `make`.

For more advanced features:

* Consult comments and explanations inside the reference makefile `examples/reference/Makefile` and/or the other examples for more advanced functionality (each example is a project stub with source that compiles).

* `examples/reference/` is an almost empty project, but the makefile contains every usable variable and feature, commented out and explained.

* `examples/flags` is a simple project that sets and personalizes different compilation flags depending on different conditions.

* `examples/multitarget` shows how to build multiple binaries in the same directory.

* `examples/autogencode` contains a working example with automatic code generation (both headers only, and headers and sources).

* `examples/mixedccpp` contains a working example that mixes C and C++ code (and different C++ modules with different files extensions, too).

* `examples/libraries` shows how to compile static and dynamic libraries as targets.

* `examples/dirsource` shows how to add all the source code file contained in a directory automatically.



## Features

The most important one is that __everything is implemented in less than four hundred lines__ (with comments), and that the only thing that is needed to understand them is the GNU Make manual (and/or the countless stack overflow answers on make). Beside that...

#### Automatic features

Things that work out of the box:

* __Automatic generation of dependencies__. It always happens, no question asked.

* __No need to clean everything when you change the Makefile__. The build depends on the makefile itself, to avoid annoying issues that could happen when you change it (this can be disabled by setting `egg_MAKEFILE_FORCEBUILD := false`).

* __No need to clean everything when you change the target__. The build depends dynamically on the previous make command line. If, for example, the compilation command line suddenly changes from release to debug or the other way around, everything is recompiled, to avoid fastidious bugs (this can be disabled by setting `egg_CMDGOAL_FORCEBUILD := false`).


#### Advanced features

Additional things you can do:

* __Easy configuration of custom compilation flags, used by different types of targets__. Commands `make` or `make all` get you a barebone compilation that uses only the standard compilation flags that you define. Currently implemented custom targets are: `release` (for final optimization flags), `debug` (debugging flags), `make trace` (statically compiled verbose tracing output), `make static` (a statically linked binary), and combinations of them (`tracerelease`, `tracedebug`, `staticrelease`, `staticdebug`, `statictrace`, `statictracerelease`, `statictracedebug`). It's up to you to fill in the right flags for compiling these modes for your project, if you care about using them. The corresponding flag names are quite intuitive:

		### compilation flags
		egg_COMMON_FLAGS := -Wall            # Used in all cases
		egg_RELEASE_FLAGS := -O3
		egg_DEBUG_FLAGS := -g
		egg_TRACE_FLAGS := -DVERBOSE_TRACE
		egg_STATIC_FLAGS := -Dstatic_lib_opt
		egg_CFLAGS := -std=c99               # plain C only
		egg_CXXFLAGS := -std=c++11           # C++ only
		
		### Linker flags
		egg_LDFLAGS := -L/opt/local/lib
		egg_LDLIBS :=  -lanotherlib
		egg_STATIC_LDFLAGS := -L/path/to
		egg_STATIC_LDLIBS := staticlib.a
		egg_FRAMEWORKS := -framework frame

* __Compile libraries, either static, dynamic, or both at once__. Do this by setting the `egg_TARGET_TYPE` variable. For static libraries, control the parameters to the archiver using `egg_ARFLAGS`; for dynamic libraries, use the `egg_LDFLAGS` and `egg_LDLIBS`. Common parameters for object compilation can be added to usual variables, such as `egg_FLAGS`. See the `libraries` example in the examples directory.

		egg_TARGET_TYPE := library             # Both static and dynamic.
		egg_TARGET_TYPE := dynamic-library     # Dynamic only.
		egg_TARGET_TYPE := static-library      # Static only.

		egg_ARFLAGS := rcs
		egg_LDFLAGS := -shared
		egg_LDLIBS  := -lotherlibs
		egg_FLAGS   += -fPIC

* __Adding all the software modules contained in a specific directory automatically__. If there are directories containing a lot of files that need to be compiled, the list of files often becomes a burden to maintain. With eggmake it's possible to add them all using only the directory names, with the `egg_DIR_SOURCES` variable. Only C and C++ files with known extensions will be added (`.c .cpp .cxx .c++ .cc .C`). The search is not recursive: subdirectories must be added separately. See the `dirsources` example in the examples directory.

		egg_DIR_SOURCES := one_dir other_dir one_dir/nested_dir ../../far_away_dir
		egg_DIR_SOURCES += .     # the working directory can be added too!

* __Projects that mix linking of both C and C++ code at the same time are supported__. C and C++ have language specific flags that you can add (`egg_CFLAGS` and `egg_CXXFLAGS`); the general flags are used for both. Files with `.c` extension are always considered C files and compiled as such. Files with extensions `.cpp .cxx .c++ .cc .C` are considered C++ sources. Header files may have any extension (or no extension at all). Remember to wrap your C headers inside an `extern "C" { ... }` directive, if `__cplusplus` is defined. See the `mixedccpp` example.

* __Easy customization of the previously defined compilation flags depending on the current environment and system__ (operating system, hostname, username, etc). See commented out `System-dependent configuration` and `User-dependent configuration` sections in the reference Makefile. These are just suggestions, you can modify the compilation flags using any custom check you want by calling out arbitrary shell commands and by reading environment variables. For example:

		ifeq ($(shell uname -s),Darwin)
		egg_FRAMEWORKS += -framework another
		endif
		
		ifeq ($(shell whoami),jane)
		egg_FLAGS += -DHEY_JANE_IS_HERE
		endif

* __Support for building multiple binaries per directory__ (for example, a util directory inside your repository that contains code for several smaller utilities). This can be done by writing a master `Makefile` which defines all the executable names (`egg_TARGET_LIST= <first-target> <second target> <...>`) and includes `./eggmakelib/multitarget.mk`, and by writing secondary makefiles named `Makefile.<name-of-first-target>`, `Makefile.<name-of-second-target>`, `Makefile.<...>`, one for each executable. The command `make` compiles all the targets in release mode, `make debug` all the targets in debug mode, and so on. If you want to compile a single executable, you can (intuitively) do that by using the commands `make <name-of-target>` (release mode), `make <name-of-target> debug` (debug mode), and on and on. See the `examples/multitarget` example.

* __Support for automatic code generation with arbitrary methods__. Write custom rules that generate `.c` and `.h` (or `.cpp` and `.hpp`, you name it) files according to what you need, add the names of generated files to variable `egg_AUTO_SOURCES` and `egg_AUTO_HEADERS` (so that the chain of dependencies and the clean targets can be properly filled up), and you're good to go. See the `autogencode` example.


#### That's (almost) it

Other characteristics:

* __This is still is a standard makefile__. Add to your makefile anything that works inside makefiles - conditionals, hacks, additional rules, calls to the shell, whatever. Just remember to include the eggmake library in the last line.
 
* __Almost no dependencies__. It should work on any OS capable of running GNU Make, a posix shell, a modern compiler. Currently tested on: MacOSX (gnu make installed via ports, or via brew), and Arch Linux.

* __Currently supported languages: C and C++__. Other languages should be quite easy to add though. If there's a language you might like to see supported, open an issue and give me info on which default compiler might be added, about its command line usage, default file extensions of sources, etc. For instance, it would be nice to have Objective C support...


## Why, and why not

This could be the right build system if one or more of the following points apply:

* You're working on a demo or proof-of-concept that needs rapid development and is often refactored.

* Your project is small to medium sized.

* You want a simple and reliable build system that is easy to understand, easy to hack, tinkerable with, and has (almost) no external dependencies.

* You want direct and immediate control over what flags, include and linking directives are feeded to the compiler.

* Long story short, if you want a build system that shuts up, does what it's told, has no special needs, and it's fast.

On the other hand, avoid it (at least for now) if:

* Your project has a lot of dependencies, and you want to make sure they are all checked and fulfilled, on many different environments.

* You need targets for testing and installation.

* You have a lot of users, and they expect to find standard `configure && make && make install` commands.



## Warnings, credits, references.

Use this at your peril! It's alpha software. A build system can introduce subtle bugs inside the software it builds - or at least byzantinely cooperate to the bug-producing efforts. It launches unchecked file removal commands inside your build directory every time the `clean` target is used. Backup often and use a modern version control software.

Keep in mind that right now every compilation directory is a monad - if your project builds a lot of executables inside different directories, it's up to you to go inside each directory and compile what's there. But, every executable knows exactly what it needs to achieve its compilation. This is good, because the problem of determination of dependencies becomes local to the target, and its object files become private. This incredibly simplifies development in fast-changing environments. The drawback is that every object file is recompiled _N_ times, one for each _Nth_ executable that depends on it (when you recompile everything from scratch in a complex build tree that generates a lot of different executables).

I freely admit that this is just a packaging of a collection of hacks that I developed and/or collected over the years. Credit goes to a lot of people and resources I cannot remember, and to the stackoverflow community. Everything started a lot of time ago, by reading the now classic [recursive make considered harmful](http://aegis.sourceforge.net/auug97.pdf), by Peter Miller.

Other resources:

* The [Official GNU Make docs](https://www.gnu.org/software/make/).
* The Stack Overflow [makefile tag](http://stackoverflow.com/questions/tagged/makefile), [make tag](http://stackoverflow.com/questions/tagged/make), and tags related to them.
* See [Non recursive make, by Emile van Bergen](http://evbergen.home.xs4all.nl/nonrecursive-make.html).
* Read [anything written by Paul D. Smith](http://make.mad-scientist.net/papers/).

Although I use several ideas of his, I did not use the [autodeps technique by Tom Tromey](http://make.mad-scientist.net/papers/advanced-auto-dependency-generation/), which involves computing dependencies during compilation and not before. My catch was that I could not make it work with automatic generation of headers - maybe I'm missing something. I also failed to encounter the problems he mentions about computing dependencies before compilation and automatic code generation... YMMV.

Similar efforts:

* [boilermake on github](https://github.com/dmoulding/boilermake/)
* [nonrec-make on github](https://github.com/aostruszka/nonrec-make/)
* The build system of [embox](https://github.com/embox/embox) (under [embox/mk/](https://github.com/embox/embox/tree/master/mk)). The extended function syntax written using make itself described [here](http://stackoverflow.com/a/10884025) by the author seems interesting.

I believe that a lot of developers, projects and shops wrote similar build systems for their own projects in the past. Modern GNU Make now should have all the features that are needed for developing a general build system that is fast, customizable, easy to use, and mantained as a separate, standalone project.

Make has disadvantages too. See [What's Wrong With GNU Make](http://www.conifersystems.com/whitepapers/gnu-make/), a white paper about what is wrong with the make language in general (despite referring to the GNU implementation, the criticism applies to the language as a whole). My personal opinion is that most of the points made in the article can be solved or mitigated by avoiding writing custom makefiles, and doing the right things once and for all in a make library, as this project tries to do. Most other build system usually just build a Makefile on unix systems and add their own complexity on top of that, which is slow, cumbersome, and a source of problems. I am not aware of any build system that avoids make altogether and is as fast, portable, universally tested and full featured as GNU Make is. The day that such a beast will be born, and offers a clean functional language that has none of the quirks of make's language, make will finally stop being used for new projects (and will still remain supported until the end of history anyway, given how many existing projects rely on it - but that's another story). A very interesting project seems to be [tup](http://gittup.org/tup/), but I don't know if it's ready for prime time yet.

Constructive feedback and criticism is appreciated. The make code I wrote and hacked together is certainly very far from the best examples you can find. It should work as intended, though, and if it does not and you care enough, please send me a bug report.


## To be done

Things that will be hopefully added sooner rather than later, plus other random ideas:

* Support for Windows, and in general a more systematic way of checking the operating system, its version, and the underlying hardware architecture. Drop the requisite for a POSIX shell, or at least provide an alternative for widely used operating systems that don't have one.

* Provide fallback mechanisms and/or disable automatic generation of dependencies if the compiler does not support it.

* Building all targets inside subdirectories from parent directories (ideally, a single make command in the root dir should recompile everything).

* An option for sharing object files between executables. This would mean a faster compilation when producing a full binary release from the root directory.

* Support the creation of custom targets in general, with a specific attention to the support of custom cross compilation cases. Remove the currently supported targets and their combinations (which is an ugly hack to say the least), and leave the creation of custom targets of this sort outside the library.

* Optionally support build directories private to the target type (e.g. `build.target.debug` for debugging, etc), to avoid recompilation of all object files when going back and forth between different types of builds.

* Implementation of customary `install` and `dist` targets.

* Support for `test` targets, for simpler development of unit tests, etc.

Check the `TODO.org` file for more details. If the most important among these new features are added, eggmake could (maybe) be used in bigger projects too.
