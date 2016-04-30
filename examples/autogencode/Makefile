egg_TARGET := example.out
egg_SOURCES = main.cc

override egg_DEBUG_FLAGS += -g -Wall
override egg_CXXFLAGS += -std=c++11

egg_AUTO_SOURCES := azang.tab.cc
egg_AUTO_HEADERS := azang.tab.hh zving.auto.hh

# $@ : matching target
# $< : matching prerequisite
# $* : matched pattern (the part common to both target and prerequisite)
%.auto.hh : %.def
	cp $< $@

%.tab.hh : %.hh.sh
	./$< header

%.tab.cc : %.cc.sh
	./$< source

include ../../eggmakelib/engine.mk
