###///    -- eggMake --    \\\###
###\\\ MultiTarget Example ///###


# List of targets to be built. Write a makefile for each <target>,
# with name Makefile.<target>, defining the ingredients and options
# for making it.
TARGETS := first_target.out second_target.out
# In this case, Makefile.first_target.out and Makefile.second_target.out


### Compile in the usual way:

# `$ make` makes all targets
# `$ make <target_name_1> <target_name_2>` makes the specified targets.

### specific goal qualifiers (debug, trace, static, etc) can be used
### on both all targets and specific targets:

# `$ make debug`
# `$ make <target_name> debug`


# avoid anoying message lines about directory changes.
NO_PRINT_DIR := true

###########################################
# include eggmake multitarget functionality.
include ../../eggmakelib/multitarget.mk
###########################################
