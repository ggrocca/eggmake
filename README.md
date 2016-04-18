# EggMake

EggMake is a build system for __Guerrilla Software Development__, based on GNU Make. It's just a Makefile library. The long term goal is to get rid of all the complexity and hassle that usually comes with tools such as qmake, CMake, SCons, or, heaven forbids, automake/autoconf.

In the simplest case, it's enough to write a `Makefile` that:

* Defines some variables, the most important one being `CPPSOURCES = my_main.cpp your_module.cpp` (or `CSOURCES = main.c`).

* Includes the EggMake library, as in `include ./eggmake.lib/engine.mk`)

* And then, everything works. Type `make` and compile your project.

Basically, the build system is plain, old make. The library just implements a full-featured Makefile, offering a lot of automatic and/or optional features. There is nothing wrong and plenty of advantages to be had in building your project using make only.


## Prerequisites and installation

The only requisites are GNU Make (see Paul's first [rule of Makefiles](http://make.mad-scientist.net/papers/rules-of-makefiles/)) and a working posix shell. Use a fairly recent version of GNU Make. Oldest version that I am testing with is 4.1. Anything below 3.81 won't work for sure. Be aware that some features are tested only for gcc and llvm compilers. Any compiler whose interface is compatible to gcc's should work.

Clone the repository:
```
git clone https://github.com/ggrocca/eggmake.git eggmake.git
```
and copy the files inside the eggmakelib directory to wherever destination you want. My suggestion is to copy eggmakelib to the root of your project:
```
cp -R eggmake.git/eggmakelib /path/to/your/project/
```
Nothing changes on your system, and any hack you might add to the library remains private to the current project.

Alternatively, you might considers places in your home directory such as `~/lib/eggmakelib`, or `~/.eggmakelib` (if you prefer an hidden directory). You could install system-wide to `/usr/local/share` or `/opt/local/share`, but I would consider this to be overkill. After all, the build system is run by GNU make, and that is already installed.

Consider adding eggmakelib to your version controlled repository, for any project that you want to use it on. It's quite small, and your users will download everything they need to compile the code when they clone the repo. If you later work an hack or a bugfix to eggmakelib that you want to send back here (that would be very much appreciated), just make a `diff -ru` patch between your directory and the cloned EggMake repo. Add the patch to your repo, and make a pull request.


## Write your makefile

Copy the file `examples/Makefile.reference` to the directory where you need your compilation target to be.
```
cp eggmake.git/examples/reference/Makefile /path/to/your/project/
```

Set the following variables, and 

* `TARGET`, the name of your executable

* `CPPSOURCES` and/or `CSOURCES`, all the names of your C++ and C modules that need to be compiled (in all the directories they are to be found in).

* If your sources are to be found in directories different from the working where the makefile is, add them to `VPATH`. Do not add directory names to `CSOURCES` and `CPPSOURCES`.

* Optionally, add the right directives to the right variables, such as `FLAGS`, `DEFINES`, `INCLUDES`, `LDFLAGS` (see supported variables, with comments, in `examples/reference/Makefile`).

* Consult comments inside the reference makefile and/or the examples for more advanced functionality (each of them is a project stub that cleanly compiles).

* `examples/flags` is a simple project that sets and personalizes different compilation flags depending on different conditions.

* `examples/multitarget` builds multiple binaries in the same directory.

* `examples/autogencode` contains a working example with automatic code generation (both headers only, and headers and sources).

* That is all. Everything else is already set and/or commented out in the reference makefile, with detailed explanations.


## Features

The most important one is that everything is implemented in less than a three hundred lines (with comments), and that the only thing that is needed to understand them is the GNU Make manual (and/or the countless stack overflow answers on make). Beside that:

* Automatic generation of dependencies.

* Easy configuration of custom compilation flags, with different types of targets (currently: release, debug, trace, static linking, and combinations of them).

* Easy customization of compilation flags depending on system variables (OS, hostname, username, etc).

* Optional support for generation of multiple binaries per directory (for example, a util directory inside your repository that contains code for several smaller utilities).
 
* Add to your makefile anything that works inside makefiles - conditionals, hacks, additional rules, calls to the shell, whatever. Just remember to include the eggmake library in the last line.
 
* It should work on any OS capable of running GNU Make and a posix shell. Currently tested on: MacOSX (gnu make installed via ports, or via brew), and Arch Linux.

* The build depends on the makefile itself, to avoid annoying issues that could happen when you change it (this can be disabled, optionally).

* The build also depends dynamically on the given target. If the target is suddenly changed from release to debug, or the other way around, everything is recompiled, to avoid fastidious bugs (again, this can be disabled).

* Currently supported languages: C and C++. Other languages should be quite easy to add though.

* Projects that mix linking of both C and C++ code at the same time are supported. Flags specific to C and C++ are supported.

* Support for automatic code generation.

* Fast.


## Why should I care?

It's the build system for you if one or more of the following points apply:

* You're working on a demo or proof-of-concept that needs rapid development and it's often refactored.

* Your project is small to medium sized.

* You want a simple and reliable build system that is easy to understand, easy to hack, tinkerable with, and has (almost) no external dependencies.

* You want direct and immediate control over what flags, include and linking directives to feed to the compiler.

* Long story short, if you want a build system that shuts up, does what it's told, has no special needs, and it's fast.


## Warnings, credits, references.

Use this at your peril! It's alpha software. A build system can introduce subtle bugs inside the software it builds - or at least byzantinely cooperate to the bug-producing efforts. It launches unchecked file removal commands inside your build directory every time the `clean` target is used. Backup often and use a modern version control software.

Keep in mind that right now every compilation directory is a monad - it's up to you to go inside each directory and compile what's there. But, every executable knows exactly what does it need to achieve its compilation. This is good, because the problem of determination of dependencies becomes local to the target, and its object files can be made private. This incredibly simplifies development in fast-changing environments. The drawback is that every object file is recompiled __N__ times, for each __Nth__ executable that depends on it.

I freely admit that this is just a packaging of a collection of hacks that I developed and/or collected over the years. Credit goes to a lot of people and resources I cannot remember, and to the stackoverflow community. Everything started a lot of time ago, by reading the now classic [recursive make considered harmful](http://aegis.sourceforge.net/auug97.pdf), by Peter Miller.

Other resources:

* The [Official GNU Make docs](https://www.gnu.org/software/make/).
* The [SO makefile tag](http://stackoverflow.com/questions/tagged/makefile), [SO make tag](http://stackoverflow.com/questions/tagged/make), and related tags.
* See [Non recursive make, by Emile van Bergen](http://evbergen.home.xs4all.nl/nonrecursive-make.html).
* Read [Anything written by Paul D. Smith](http://make.mad-scientist.net/papers/).

Although I use several ideas of his, I did not use the [autodeps technique by Tom Tromey](http://make.mad-scientist.net/papers/advanced-auto-dependency-generation/), which involves computing dependencies during compilation and not before. My catch was that I could not make it work with automatic generation of headers - maybe I'm missing something. I also failed to encounter the problems he mention about computing dependencies before compilation and automatic code generation... YMMV.

Similar efforts:

* [boilermake on github](https://github.com/dmoulding/boilermake/)
* [nonrec-make on github](https://github.com/aostruszka/nonrec-make/)

I believe that a lot of developers, projects and shops wrote similar build systems for their own projects in the past. Modern GNU Make now should have all the features that are needed for developing a general build system that is fast, customizable, easy to use, and mantained as a separate, standalone project.

Make has disadvantages too. See [What's Wrong With GNU Make](http://www.conifersystems.com/whitepapers/gnu-make/), a white paper about what is wrong with the make language in general (despite referring to the GNU implementation, the criticism applies to the language as a whole). My personal opinion is that most of the points made in the article can be solved or mitigated by avoiding writing custom makefiles, and doing the right things once and for all in a make library, as this project tries to do. The fact is, most other build system usually just build a Makefile on unix systems, and add their own complexity on top of that, which is not cool and a source of problems. I am not aware of any build system that avoids make altogether and is as fast, portable and full featured as GNU Make is. The day that such a beast will be born, and offers a clean functional language that has none of the quirks of make's language, make will finally stop being used for new projects (and will still remain supported until the end of history anyway, given how many existing projects rely on it - but that's another story).

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

Check the `TODO.org` file for more details. If some of these features are added, eggmake could be used in big projects too.
