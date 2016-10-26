###///    -- eggMake --    \\\###
###\\\ MultiTarget Example ///###


## List of targets to be built. Write a makefile for each <target>,
## with name Makefile.<target>, defining the ingredients and options
## for making it.

## In this case, Makefile.first_target.out and Makefile.second_target.out:
egg_TARGET_LIST := first_target second_target


## by default, eggmake avoids annoying message lines about directory
## changes when doing multitarget compilation. Set the following
## variable to false to disable this.
# egg_NO_PRINT_DIR := false


##########################
### Usage instructions ###
#########################

###### Compile:
### `$ make` makes all targets
### `$ make <target_name_1> <target_name_2>` makes the specified targets.

###### specific goal qualifiers (debug, trace, static, etc) can be
###### used on both all targets and specific targets:
# `$ make debug`
# `$ make <target_name> debug`



###########################################
# include eggmake multitarget functionality.
include ../../eggmakelib/multitarget.mk
###########################################
