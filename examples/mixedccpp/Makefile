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
CXX_EXTENSIONS := cc cpp cxx c++

## Names of files to compile, without path. add C++ sources and C
## sources to the right variable. Warning: you cannot have files with
## the same names in different directories, because the names of
## object files will conflict.
# CPPSOURCES = file1.cc file2.cc
# CSOURCES = file1.c file2.c
SOURCES = cobject.c ccobject.cc cppobject.cpp main.cpp



#####################
### Compilation flags

## generic compilation configuration, to be used for both C++ and C on
## every OS.

override FLAGS += -Wall
override DEBUG_FLAGS += -g

## Language dependent configuration. Ignore this section if your
## project use C++ only or C only without mixing the two. When using
## both languages, the C++ compiler is the one called in the linking
## phase.

# # C specific conf
# override CFLAGS +=
# override CINCLUDES +=
# override CDEFINES +=
override CFLAGS += -std=c99
override CINCLUDES +=
override CDEFINES +=

# # C++ specific conf
# override CXXFLAGS +=
# override CXXINCLUDES +=
# override CXXDEFINES +=
override CXXFLAGS += -std=c++11
override CXXINCLUDES +=
override CXXDEFINES +=



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



############################################
## include eggmake compilation functionality.
include ../../eggmakelib/engine.mk
############################################
