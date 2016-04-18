### Copyright (c) 2016 Luigi Rocca <luigi.rocca (@T) ge.imati.cnr.it>
### Released under the MIT License.

###///  -- -- -- -- -- eggMake -- -- -- -- --  \\\###
###    Library - support for multiple targets.    ###
###\\\  -- -- -- -- -- ------- -- -- -- -- --  ///###


PHONY_TARGETS := all clean debug trace debugtrace static staticdebug statictrace staticdebugtrace

.PHONY : $(PHONY_TARGETS) $(TARGETS)

all: $(TARGETS)

#$(warning $(MAKECMDGOALS))

ifneq ($(filter clean, $(MAKECMDGOALS)),)
PASSTARGET := clean
ifeq ($(words $(MAKECMDGOALS)),1)
clean : $(TARGETS)
endif
endif

ifneq ($(filter debug, $(MAKECMDGOALS)),)
PASSTARGET := debug
ifeq ($(words $(MAKECMDGOALS)),1)
debug : $(TARGETS)
endif
endif

ifneq ($(filter trace, $(MAKECMDGOALS)),)
PASSTARGET := trace
ifeq ($(words $(MAKECMDGOALS)),1)
trace : $(TARGETS)
endif
endif

ifneq ($(filter debugtrace, $(MAKECMDGOALS)),)
PASSTARGET := debugtrace
ifeq ($(words $(MAKECMDGOALS)),1)
debugtrace : $(TARGETS)
endif
endif

ifneq ($(filter static, $(MAKECMDGOALS)),)
PASSTARGET := static
ifeq ($(words $(MAKECMDGOALS)),1)
static : $(TARGETS)
endif
endif

ifneq ($(filter staticdebug, $(MAKECMDGOALS)),)
PASSTARGET := staticdebug
ifeq ($(words $(MAKECMDGOALS)),1)
staticdebug : $(TARGETS)
endif
endif

ifneq ($(filter statictrace, $(MAKECMDGOALS)),)
PASSTARGET := statictrace
ifeq ($(words $(MAKECMDGOALS)),1)
statictrace : $(TARGETS)
endif
endif

ifneq ($(filter staticdebugtrace, $(MAKECMDGOALS)),)
PASSTARGET := staticdebugtrace
ifeq ($(words $(MAKECMDGOALS)),1)
staticdebugtrace : $(TARGETS)
endif
endif

ifeq ($(NO_PRINT_DIR),true)
NO_PRINT_DIR_OPT=--no-print-directory
else
NO_PRINT_DIR_OPT=
endif

$(TARGETS):
	@$(MAKE) $(NO_PRINT_DIR_OPT) -f Makefile.$@ $(PASSTARGET)


$(PHONY_TARGETS):
	@echo nothing > /dev/null
