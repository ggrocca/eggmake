###///  -- eggMake --  \\\###
###\\\ Example project ///###


##################################
### Project configuration section.

## executable name
TARGET := target.out

## Directory where build junk goes. Comment this line out or leave
## empty if you want to build in the working directory.
BUILD_DIR := build

## Additional directories for source files
VPATH =


## Names of files to compile, without path.
CSOURCES = main.c

## Compile flags
override FLAGS += -DFLAGS__
override DEBUG_FLAGS += -DDEBUG_FLAGS__
override TRACE_FLAGS +=
override RELEASE_FLAGS +=
override STATIC_FLAGS +=
override INCLUDES +=
override DEFINES +=
override LDFLAGS +=
override STATIC_LDFLAGS +=
override FRAMEWORKS +=



###############################
### General Makefile behaviour.

## If the makefile changes, everything is rebuilt from scratch.
# MAKEFILE_FORCEBUILD := true
MAKEFILE_FORCEBUILD := true

## If the make goal changes, everything is rebuilt from scratch.
# NEW_TARGET_FORCEBUILD := true
# NEW_TARGET_FORCEBUILD_FILE := .file_old_goal
NEW_TARGET_FORCEBUILD := true
NEW_TARGET_FORCEBUILD_FILE := $(BUILD_DIR)/.make_previous_goal



############################################
## include eggmake compilation functionality.
include ../../eggmakelib/engine.mk
############################################
