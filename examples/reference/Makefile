###///  -- eggMake --  \\\###
###\\\ Example project ///###


##################################
### Project configuration section.

## executable or library name (the proper extension is appended to the
## library name depending on the target library type, static or dynamic)
# egg_TARGET := exe
# egg_TARGET := lib
egg_TARGET := target.out

## Names of files to compile, without path. Warning: you cannot have
## files with the same names in different directories, because the
## names of object files will conflict.
# egg_SOURCES = file1.c file2.cc file3.cpp
egg_SOURCES := main.c

## Directories where source files outside the working directory can be
## found. Search is not recursive. Relative paths start from the
## working directory.
# egg_SOURCE_PATH := add/dir1 ../add/dir2 ../../etc/
egg_SOURCE_PATH :=

## Add all the software modules inside given directories. The search
## is not recursive, and there is no need to add these directories to
## the variable egg_SOURCE_PATH).
# egg_DIR_SOURCES := add/dir1 ../add/dir2 ../../etc/

## Select the type of project. Available choices: executable, both a static library and a dynamic library, a dynamic library only or a static library only. Default value: executable.
# egg_TARGET_TYPE := executable
# egg_TARGET_TYPE := library
# egg_TARGET_TYPE := dynamic-library
# egg_TARGET_TYPE := static-library

## Directory where build junk goes. Explicitly declare this variable
## empty if you want to build in the working directory. Default
## value(if not declared): build.<target_name>
# egg_BUILD_DIR := your_build_dir_name.$(egg_TARGET)
# egg_BUILD_DIR :=

## select the C and C++ compilers. Eggmake uses the default variable
## names set by make; overwrite them if you need to use a different
## compiler.
# CXX =
# CC =

## select the extension for dynamic and static library targets, and
## the standard prefix for library names. Defaults: .so, .a, .lib
# egg_STATIC_LIB_E := a
# egg_DYNAMIC_LIB_E := so
# egg_LIB_PREFIX := lib

#####################
### Compilation flags

## Available targets are:
## release, debug, trace, static
## And various combinations of them:
## tracerelease, tracedebug, staticdebug, staticrelease, statictrace, statictracerelease, statictracedebug

## egg_FLAGS are always used.
## egg_RELEASE_FLAGS are used in release mode.
## egg_DEBUG_FLAGS are used in the debug mode.
## egg_TRACE_FLAGS are used in trace mode.
## egg_STATIC_FLAGS are used in static mode.

## trace flags work as secondary debug flags to allow static
## compilation of additional verbosity or messages in your program,
## which can be added indipendently of debug symbols - useful if you
## have to debug bugs that happen in release mode but not in debug
## mode, as it sometimes happens in parallel programs.

## egg_LDFLAGS are flags to the linker
## egg_LDLIBS are for defining libraries (-l</path> or <lib.a>)
## egg_STATIC_LDFLAGS are used instead of egg_LDFLAGS in static mode
## egg_STATIC_LDLIBS := are used instead of egg_LDLIBS in static mode


# # flags to the compiler/preprocessor.
# # Eggmake also reads standard CPPFLAGS var.
# egg_FLAGS := -Wall
# egg_RELEASE_FLAGS := -O3
# egg_DEBUG_FLAGS := -g
# egg_TRACE_FLAGS := -DVERBOSE_TRACE
# egg_STATIC_FLAGS := -Duse_static_lib_opt
egg_FLAGS := 
egg_RELEASE_FLAGS := 
egg_DEBUG_FLAGS :=
egg_TRACE_FLAGS :=
egg_STATIC_FLAGS :=


# # Language dependent flags.
# # Eggmake also reads standard CFLAGS and CXXFLAGS vars.
# egg_CFLAGS := -stdc99
# egg_CXXFLAGS := -stdc++11
egg_CFLAGS :=
egg_CXXFLAGS :=
## Ignore this section if your project use C++ only or C only without
## mixing the two. When using both languages, the C++ compiler is the
## one called in the linking phase.


# # flags to the linker.
# # Eggmake also reads standard LDFLAGS and LDLIBS vars.
# egg_LDFLAGS := -L../path/to/dir/with/libs
# egg_LDLIBS := -lyourlib
# egg_STATIC_LDFLAGS := -static
# egg_STATIC_LDLIBS := path/to/file.a
# egg_FRAMEWORKS := -framework GLUT -framework OpenGL
egg_LDFLAGS :=
egg_LDLIBS :=
egg_STATIC_LDFLAGS :=
egg_STATIC_LDLIBS :=
egg_FRAMEWORKS :=


###########################################
### Archiver for static library compilation

# # Archiver utility. Eggmake uses the default variable name provided by make.
# AR =

# # Flags to the archiver utility. Eggmake reads the standard ARFLAGS if you don't provide any.
# egg_ARFLAGS :=


###################################
### System-dependent configuration. 

## Here add system-dependent settings to previous variables, using the
## syntax `+=' if you want to add things, `=' if you want to replace
## them. A simple mechanism with uname is currently used. Generic is
## used as a generic catch-all implementation for UNIX-like systems.

# # recognition
# UNAME := $(shell uname -s)
# GENERIC = true

# # MACOSX
# ifeq ($(UNAME),Darwin)
# egg_VAR += whatever
# GENERIC = false
# endif
# # MACOSX

# # eventually add here other specific OSes, remembering to set
# # `GENERIC = false' once you're done

# # generic UNIX
# ifeq ($(GENERIC),true)
# egg_VAR += whatever
# endif
# # generic UNIX



#################################
### User-specific configuration.

## Add user-specific configurations in multideveloper settings.
## There's a different syntax for testing a single username vs testing
## multiple usernames all at once.

# # Testing for a single username
# ifeq ($(shell whoami),jane)
# egg_VAR += whatever
# endif

# # Testing for multiple usernames: 
# ifneq (,$(filter $(shell whoami),alice bob))
# egg_VAR += whatever
# endif



#############################
### Automatic code generation

## C/C++ automatically generated source and header files. Tell eggmake
## the names of files tht will be generated (so eggmake knows that
## they can be cleaned, for example), and devise appropriate rules to
## generate them.

# egg_AUTO_SOURCES := 
# egg_AUTO_HEADERS := 
egg_AUTO_SOURCES := 
egg_AUTO_HEADERS := 

# # Custom rules for code generation
# %.auto.hh : %.def
# 	cp $< $@
# %.tab.hh : %.hh.sh
# 	./$< header
# %.tab.cc : %.cc.sh
# 	./$< source

## Cheat sheet for automatic variables inside rules:
## $@ -> matching target
## $< -> matching prerequisite
## $* -> matched pattern (the part common to both target and prerequisite)



###############################
### General Makefile behaviour.

## By default, If the makefile changes, everything is rebuilt from
## scratch. Disable this by setting the following variable to false.
# egg_MAKEFILE_FORCEBUILD := false

## By default, if the make goal changes, everything is rebuilt from
## scratch. Disable this by setting the following variable to false.
# egg_CMDGOAL_FORCEBUILD := false

## set a custom file for keeping track of the previous goal if the
## previous option is enabled. Default value:
## $(egg_BUILD_DIR)/.eggmake_previous_goal
# egg_CMDGOAL_FORCEBUILD_FILE = $(egg_BUILD_DIR)/your_file_name_here.



############################################
## include eggmake compilation functionality.
include ../../eggmakelib/engine.mk
############################################
