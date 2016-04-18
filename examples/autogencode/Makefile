##################################
### Project configuration section.

TARGET := example.out
BUILD_DIR := build

CXXC = g++
CPP_EXT = cc
DEP_EXT = dd
OBJ_EXT = oo

CPPSOURCES = main.cc


#####################
### Compilation flags

override FLAGS += 
override DEBUG_FLAGS += -g -Wall
override TRACE_FLAGS +=
override RELEASE_FLAGS +=
override STATIC_FLAGS +=
override INCLUDES += 
override DEFINES +=
override LDFLAGS +=
override STATIC_LDFLAGS +=
override FRAMEWORKS +=

override CFLAGS +=
override CINCLUDES +=
override CDEFINES +=

override CXXFLAGS += -std=c++11
override CXXINCLUDES +=
override CXXDEFINES +=


###############################
### General Makefile behaviour.

MAKEFILE_FORCEBUILD := true
NEW_TARGET_FORCEBUILD := true
NEW_TARGET_FORCEBUILD_FILE := $(BUILD_DIR)/.make_previous_goal



#############################
### Automatic code generation

## C/C++ automatically generated source and header files.
AUTO_CPPSOURCES := azang.tab.cc
AUTO_CSOURCES := 
AUTO_HEADERS := azang.tab.hh zving.auto.hh

# $@ : matching target
# $< : matching prerequisite
# $* : matched pattern (the part common to both target and prerequisite)
%.auto.hh : %.def
	cp $< $@

%.tab.hh : %.hh.sh
	./$< header

%.tab.cc : %.cc.sh
	./$< source



############################################
## include eggmake compilation functionality.
include ../../eggmakelib/engine.mk
############################################
