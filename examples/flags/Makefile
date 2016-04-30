egg_SOURCES = main.c

MY_DEFINES := -DAZANG -DZVING
MY_INCLUDES := -I/usr/include/

egg_FLAGS := -Wall $(MY_DEFINES) $(MY_INCLUDES)
egg_RELEASE_FLAGS := -O3
egg_DEBUG_FLAGS := -g 
egg_TRACE_FLAGS := -DVERBOSE_TRACE
egg_STATIC_FLAGS := -Duse_static_lib_opt
egg_CFLAGS := -std=c99
egg_CXXFLAGS := -std=c++11


egg_COMMON_FLAGS += -DCOMMON
egg_RELEASE_FLAGS += -DRELEASE
egg_DEBUG_FLAGS += -DDEBUG
egg_TRACE_FLAGS += -DVERBOSE_TRACE
egg_STATIC_FLAGS += -DSTATIC
egg_CFLAGS += -DPLAIN_C
egg_CXXFLAGS += -DCPLUSPLUS


include ../../eggmakelib/engine.mk

