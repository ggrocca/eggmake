###///  -- eggMake --  \\\###
###\\\ Example project ///###


##################################
### Project configuration section.

## executable name
# TARGET = exe
TARGET := target.out

## Directory where build junk goes. Comment this line out or leave
## empty if you want to build in the working directory.
# BUILD_DIR = build-dir
BUILD_DIR := build

## Additional directories for source files
# VPATH = add/dir1 ../add/dir2 ../../etc/
VPATH =

## Directory for external libraries
## not used outside the configuration section and provided for your
## convenience when defining INCLUDES and LDFLAGS. Define as many as
## such variables as you need.
# BASELIBS_DIR = ../../external/libs/dir
BASELIBS_DIR =

## C, CXX compiler
# CXXC = g++
# CC = gcc
CXXC = g++
CC = gcc

## file extensions for C++ files, their objects and dependencies (e.g:
## .cpp/.dpp/.opp, or .cc/.dd/.oo or whatever you like; remember that
## .c, .d and .o are always used for C files).
# CPP_EXT = cc
# DEP_EXT = dd
# OBJ_EXT = oo
CPP_EXT = cc
DEP_EXT = dd
OBJ_EXT = oo

## Names of files to compile, without path. add C++ sources and C
## sources to the right variable. Warning: you cannot have files with
## the same names in different directories, because the names of
## object files will conflict.
# CPPSOURCES = file1.cc file2.cc
# CSOURCES = file1.c file2.c
CPPSOURCES = 
CSOURCES = main.c


#####################
### Compilation flags

## generic compilation configuration, to be used for both C++ and C on
## every OS.

## FLAGS are always used, while DEBUG_FLAGS are used instead of
## RELEASE flags when "make debug" is used.

## STATIC_LDFLAGS are used instead of LDFLAGS if "make static" is
## used.

## TRACE_FLAGS work as secondary DEBUG_FLAGS for static compilation of
## additional verbosity or messages in your program, which can be
## added indipendently of debug symbols - useful if you have to debug
## bugs that happen in release mode but not in debug mode.

## Available targets offer all the combinations of debug, trace,and static:
## "debug trace debugtrace static staticdebug statictrace staticdebugtrace"

# override FLAGS +=
# override DEBUG_FLAGS +=
# override TRACE_FLAGS +=
# override RELEASE_FLAGS +=
# override STATIC_FLAGS +=
# override INCLUDES +=
# override DEFINES +=
# override LDFLAGS +=
# override STATIC_LDFLAGS +=
# override FRAMEWORKS +=

override FLAGS += 
override DEBUG_FLAGS +=
override TRACE_FLAGS +=
override RELEASE_FLAGS +=
override STATIC_FLAGS +=
override INCLUDES +=
override DEFINES +=
override LDFLAGS +=
override STATIC_LDFLAGS +=
override FRAMEWORKS +=


## Language dependent configuration. Ignore this section if your
## project use C++ only or C only without mixing the two. When using
## both languages, the C++ compiler is the one called in the linking
## phase.

# # C specific conf
# override CFLAGS +=
# override CINCLUDES +=
# override CDEFINES +=
override CFLAGS +=
override CINCLUDES +=
override CDEFINES +=

# # C++ specific conf
# override CXXFLAGS +=
# override CXXINCLUDES +=
# override CXXDEFINES +=
override CXXFLAGS +=
override CXXINCLUDES +=
override CXXDEFINES +=




###################################
### System-dependent configuration. 

## Here add system-dependent settings to previous variables, using the
## syntax `override +=' if you want to add things, ` override =' if
## you want to replace them. A simple mechanism with uname is
## currently used. Generic is used as a catch-all implementation,
## currently targeting linux.

# # recognition
# UNAME := $(shell uname -s)
# GENERIC = true

# # MACOSX
# ifeq ($(UNAME),Darwin)
# override VAR += whatever
# GENERIC = false
# endif
# # MACOSX

# # eventually add here other specific OSes, remembering to set
# # `GENERIC = false' once you're done

# # generic UNIX
# ifeq ($(GENERIC),true)
# override VAR += whatever
# endif
# # generic UNIX




#################################
### User-specific configuration.

## Add user-specific configurations in multideveloper settings.
## There's a different syntax for testing a single username vs testing
## multiple usernames all at once.

# # Testing for a single username
# ifeq ($(shell whoami),jane)
# override VAR += whatever
# endif

# # Testing for multiple usernames: 
# ifneq (,$(filter $(shell whoami),alice bob))
# override VAR += whatever
# endif




###############################
### General Makefile behaviour.

# # If the makefile changes, everything is rebuilt from scratch.
# MAKEFILE_FORCEBUILD := true
MAKEFILE_FORCEBUILD := true

# # If the make goal changes, everything is rebuilt from scratch.
# NEW_TARGET_FORCEBUILD := true
# NEW_TARGET_FORCEBUILD_FILE := .file_old_goal
NEW_TARGET_FORCEBUILD := true
NEW_TARGET_FORCEBUILD_FILE := $(BUILD_DIR)/.make_previous_goal



#############################
### Automatic code generation

# # C/C++ automatically generated source and header files.
# AUTO_CPPSOURCES := 
# AUTO_CSOURCES := 
# AUTO_HEADERS := 
AUTO_CPPSOURCES := 
AUTO_CSOURCES := 
AUTO_HEADERS := 

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


############################################
## include eggmake compilation functionality.
include ../../eggmakelib/engine.mk
############################################
