### Copyright (c) 2016 Luigi Rocca <luigi.rocca (@T) ge.imati.cnr.it>
### Released under the MIT License.

###///   -- -- -- -- -- eggMake -- -- -- -- --   \\\###
###    Library - compilation of a single target.    ###
###\\\   -- -- -- -- -- ------- -- -- -- -- --   ///###


### Non-file phony targets
.PHONY : all clean debug trace debugtrace static staticdebug statictrace staticdebugtrace


### Use release flags for `make', debug flags for `make debug' and
### tracing flags for "make trace".
all: override FLAGS += $(RELEASE_FLAGS)
debug: override FLAGS += $(DEBUG_FLAGS)
trace: override FLAGS += $(TRACE_FLAGS)
debugtrace: override FLAGS += $(DEBUG_FLAGS) $(TRACE_FLAGS)
static: override FLAGS += $(RELEASE_FLAGS) $(STATIC_FLAGS)
staticdebug: override FLAGS+= $(DEBUG_FLAGS) $(STATIC_FLAGS)
statictrace: override FLAGS+= $(TRACE_FLAGS) $(STATIC_FLAGS)
staticdebugtrace: override FLAGS+= $(DEBUG_FLAGS) $(TRACE_FLAGS) $(STATIC_FLAGS)

FINAL_LDFLAGS =
all: override FINAL_LDFLAGS += $(LDFLAGS)
debug: override FINAL_LDFLAGS += $(LDFLAGS)
trace: override FINAL_LDFLAGS += $(LDFLAGS)
debugtrace: override FINAL_LDFLAGS += $(LDFLAGS)
static: override FINAL_LDFLAGS += $(STATIC_LDFLAGS)
staticdebug: override FINAL_LDFLAGS += $(STATIC_LDFLAGS)
statictrace: override FINAL_LDFLAGS += $(STATIC_LDFLAGS)
staticdebugtrace: override FINAL_LDFLAGS += $(STATIC_LDFLAGS)


### Add custom headers defines, if any.
## Warning: a deprecated feature that is not particularly
## useful. Instead of doing this, just add -DMY_HEADER_IS_PRESENT to
## compiler directives conditionally on the environment
## (user/hostname/os, whatever), and do things in code depending on
## the given define (even including an untracked file).
lc = $(subst A,a,$(subst B,b,$(subst C,c,$(subst D,d,$(subst E,e,$(subst F,f,$(subst G,g,$(subst H,h,$(subst I,i,$(subst J,j,$(subst K,k,$(subst L,l,$(subst M,m,$(subst N,n,$(subst O,o,$(subst P,p,$(subst Q,q,$(subst R,r,$(subst S,s,$(subst T,t,$(subst U,u,$(subst V,v,$(subst W,w,$(subst X,x,$(subst Y,y,$(subst Z,z,$1))))))))))))))))))))))))))
uc = $(subst a,A,$(subst b,B,$(subst c,C,$(subst d,D,$(subst e,E,$(subst f,F,$(subst g,G,$(subst h,H,$(subst i,I,$(subst j,J,$(subst k,K,$(subst l,L,$(subst m,M,$(subst n,N,$(subst o,O,$(subst p,P,$(subst q,Q,$(subst r,R,$(subst s,S,$(subst t,T,$(subst u,U,$(subst v,V,$(subst w,W,$(subst x,X,$(subst y,Y,$(subst z,Z,$1))))))))))))))))))))))))))

ifneq ($(strip $(CUSTOM_HEADERS)),)
override FLAGS += $(addsuffix _DEFINE, $(addprefix -DEGGMAKE_, $(call uc, $(basename $(notdir $(CUSTOM_HEADERS))))))
endif


### Add specific language flags to general ones.
override CFLAGS += $(FLAGS)
override CINCLUDES += $(INCLUDES)
override CDEFINES += $(DEFINES)
override CXXFLAGS += $(FLAGS)
override CXXINCLUDES += $(INCLUDES)
override CXXDEFINES += $(DEFINES)


### Add automatically generated sources to the project sources
override SOURCES += $(AUTO_SOURCES)
# override CPPSOURCES += $(AUTO_CPPSOURCES)
# override CSOURCES += $(AUTO_CSOURCES)


### Use C++ as a linker if there are C++ sources.
# CXX_FILTER := $(addprefix "%.", $(CXX_EXTENSIONS)) 
ifeq ($(strip $(filter %.cpp %.c++ %.cxx %.cc %.C, $(SOURCES)) ), )
LD = $(CC)
else
LD = $(CXXC)
endif
# $(warning !!! LD)
# $(warning $(LD))


### Set the list of modules to be compiled.
#ALL_EXTENSIONS := $(addprefix ".", $(CXX_EXTENSIONS)) .c
#OBJECTS := $(foreach ext, $(ALL_EXTENSIONS),   )
OBJECTS :=
OBJECTS += $(patsubst %.cpp, %.opp, $(filter %.cpp, $(SOURCES)) )
OBJECTS += $(patsubst %.c++, %.o++, $(filter %.c++, $(SOURCES)) )
OBJECTS += $(patsubst %.cxx, %.oxx, $(filter %.cxx, $(SOURCES)) )
OBJECTS += $(patsubst %.cc, %.oo, $(filter %.cc, $(SOURCES)) )
OBJECTS += $(patsubst %.C, %.O, $(filter %.C, $(SOURCES)) )
OBJECTS += $(patsubst %.c, %.o, $(filter %.c, $(SOURCES)) )
DEPS := 
DEPS += $(patsubst %.cpp, %.dpp, $(filter %.cpp, $(SOURCES)) )
DEPS += $(patsubst %.c++, %.d++, $(filter %.c++, $(SOURCES)) )
DEPS += $(patsubst %.cxx, %.dxx, $(filter %.cxx, $(SOURCES)) )
DEPS += $(patsubst %.cc, %.dd, $(filter %.cc, $(SOURCES)) )
DEPS += $(patsubst %.C, %.D, $(filter %.C, $(SOURCES)) )
DEPS += $(patsubst %.c, %.d, $(filter %.c, $(SOURCES)) )
# $(warning $(SOURCES))
# $(warning !!! OBJECTS)
# $(warning $(OBJECTS))
# $(warning !!! DEPS)
# $(warning $(DEPS))
# # old version
# override OBJECTS := $(CPPSOURCES:.$(CPP_EXT)=.$(OBJ_EXT))
# override DEPS := $(CPPSOURCES:.$(CPP_EXT)=.$(DEP_EXT))
# override OBJECTS += $(CSOURCES:.c=.o)
# override DEPS += $(CSOURCES:.c=.d)



### Build directory management.

# if build dir is non-empty:
ifneq ($(strip $(BUILD_DIR)),)
# add trailing slash and escaped trailing slash.
BUILD_DIR_SLASH = $(BUILD_DIR)/
#BUILD_DIR_SLASH_SED = $(BUILD_DIR)\/
# create it if not existent.
ifneq ($(MAKECMDGOALS),clean)
$(shell if [ ! -d $(BUILD_DIR) ]; then mkdir $(BUILD_DIR); fi)
endif
endif
# prepend its name to targets.
override BUILD_DEPS := $(addprefix $(BUILD_DIR_SLASH), $(DEPS))
override BUILD_OBJECTS := $(addprefix $(BUILD_DIR_SLASH), $(OBJECTS))



### Rebuild everything from scratch if current make command is
### different from the previous one.

ifeq ($(NEW_TARGET_FORCEBUILD), true)
#$(warning NEW_TARGET_FORCEBUILD)

ifeq ($(MAKECMDGOALS),)
NEWGOAL := all
else
NEWGOAL := $(MAKECMDGOALS)
endif
OLDGOAL := $(shell if [ -f $(NEW_TARGET_FORCEBUILD_FILE) ]; then cat $(NEW_TARGET_FORCEBUILD_FILE); else echo __empty__; fi)
#$(warning $(OLDGOAL))
#$(warning $(NEWGOAL))
dummy := $(shell echo $(NEWGOAL) > $(NEW_TARGET_FORCEBUILD_FILE))

ifneq ($(NEWGOAL),clean)
ifneq ($(OLDGOAL),clean)
ifneq ($(MAKECMDGOALS),$(OLDGOAL))
ifneq ($(NEWGOAL), $(OLDGOAL))

#$(warning DELETE)
#$(warning $(RM) $(BUILD_OBJECTS) $(BUILD_DEPS) $(TARGET))
dummy := $(shell $(RM) $(BUILD_OBJECTS) $(BUILD_DEPS) $(TARGET) $(AUTO_SOURCES) $(AUTO_HEADERS))

endif
endif
endif
endif

endif



### Standard goals supported by eggmake:
all : $(TARGET)
debug : $(TARGET)
trace : $(TARGET)
debugtrace : $(TARGET)
static: $(TARGET)
staticdebug: $(TARGET)
statictrace: $(TARGET)
staticdebugtrace: $(TARGET)


### Remove all compilation files.
clean :
ifneq ($(NEW_TARGET_FORCEBUILD_FILE),)
	-$(RM) $(NEW_TARGET_FORCEBUILD_FILE)
endif
# Warning, the following clean command is repeated in new_target_forcerebuild section.
	-$(RM) $(BUILD_OBJECTS) $(BUILD_DEPS) $(TARGET) $(AUTO_SOURCES) $(AUTO_HEADERS)
ifneq ($(strip $(BUILD_DIR)),)
	-$(RM) -r $(BUILD_DIR)
endif


### Add the makefile itself as a build dependency.
MAKEFILENAME := $(firstword $(MAKEFILE_LIST))
ifeq ($(MAKEFILE_FORCEBUILD),true)
$(BUILD_DEPS) $(BUILD_OBJECTS) : $(MAKEFILENAME)
endif


### Include dependencies, but only if we're not cleaning.
ifneq ($(MAKECMDGOALS),clean)
-include $(BUILD_DEPS)
endif


### Program linking:
$(TARGET) : $(BUILD_OBJECTS)
	$(strip $(LD) $^ $(FRAMEWORKS) -o $@ $(FINAL_LDFLAGS))


### Implicit rules for objects and dependencies, C language.
$(BUILD_DIR_SLASH)%.o: %.c
	$(strip $(CC) $(CDEFINES) $(CFLAGS) $(CINCLUDES) -c $< -o $@)

$(BUILD_DIR_SLASH)%.d: %.c
	$(strip $(CC) -MM -MP -MG -MF $@ -MT $(BUILD_DIR_SLASH)$*.o -MT $@ $(CDEFINES) $(CFLAGS) $(CINCLUDES) $<)
#	$(CC) -MM $(CDEFINES) $(CFLAGS) $(CINCLUDES) $< | sed 's/\($(subst /,\/,$*)\)\.o[ :]*/$(BUILD_DIR_SLASH_SED)\1.o $(subst /,\/,$@) : /g' > $@;


### Implicit rules for objects and dependencies, C++ language.
$(BUILD_DIR_SLASH)%.opp: %.cpp
	$(strip $(CXXC) $(CXXDEFINES) $(CXXFLAGS) $(CXXINCLUDES) -c $< -o $@)
$(BUILD_DIR_SLASH)%.oxx: %.cxx
	$(strip $(CXXC) $(CXXDEFINES) $(CXXFLAGS) $(CXXINCLUDES) -c $< -o $@)
$(BUILD_DIR_SLASH)%.o++: %.++
	$(strip $(CXXC) $(CXXDEFINES) $(CXXFLAGS) $(CXXINCLUDES) -c $< -o $@)
$(BUILD_DIR_SLASH)%.oo: %.cc
	$(strip $(CXXC) $(CXXDEFINES) $(CXXFLAGS) $(CXXINCLUDES) -c $< -o $@)
$(BUILD_DIR_SLASH)%.O: %.C
	$(strip $(CXXC) $(CXXDEFINES) $(CXXFLAGS) $(CXXINCLUDES) -c $< -o $@)

$(BUILD_DIR_SLASH)%.$.dpp: %.cpp
	$(strip $(CXXC) -MM -MP -MG -MF $@ -MT $(BUILD_DIR_SLASH)$*.opp -MT $@ $(CXXDEFINES) $(CXXFLAGS) $(CXXINCLUDES) $<)
$(BUILD_DIR_SLASH)%.$.dxx: %.cxx
	$(strip $(CXXC) -MM -MP -MG -MF $@ -MT $(BUILD_DIR_SLASH)$*.oxx -MT $@ $(CXXDEFINES) $(CXXFLAGS) $(CXXINCLUDES) $<)
$(BUILD_DIR_SLASH)%.$.d++: %.c++
	$(strip $(CXXC) -MM -MP -MG -MF $@ -MT $(BUILD_DIR_SLASH)$*.o++ -MT $@ $(CXXDEFINES) $(CXXFLAGS) $(CXXINCLUDES) $<)
$(BUILD_DIR_SLASH)%.$.dd: %.cc
	$(strip $(CXXC) -MM -MP -MG -MF $@ -MT $(BUILD_DIR_SLASH)$*.oo -MT $@ $(CXXDEFINES) $(CXXFLAGS) $(CXXINCLUDES) $<)
$(BUILD_DIR_SLASH)%.$.D: %.C
	$(strip $(CXXC) -MM -MP -MG -MF $@ -MT $(BUILD_DIR_SLASH)$*.O -MT $@ $(CXXDEFINES) $(CXXFLAGS) $(CXXINCLUDES) $<)



# ### Implicit rules for objects and dependencies, C++ language.
# ### Foreach version, still broken
# $(BUILD_DIR_SLASH)%.$(OBJ_EXT): %.$(CPP_EXT)
# 	$(CXXC) $(CXXDEFINES) $(CXXFLAGS) $(CXXINCLUDES) -c $< -o $@  

# $(BUILD_DIR_SLASH)%.$(DEP_EXT): %.$(CPP_EXT)
# 	$(CXXC) -MM -MP -MG -MF $@ -MT $(BUILD_DIR_SLASH)$*.$(OBJ_EXT) -MT $@ $(CXXDEFINES) $(CXXFLAGS) $(CXXINCLUDES) $<
# #	$(CXXC) -MM $(CXXDEFINES) $(CXXFLAGS) $(CXXINCLUDES) $< | sed 's/\($(subst /,\/,$*)\)\.o[ :]*/$(BUILD_DIR_SLASH_SED)\1.$(OBJ_EXT) $(subst /,\/,$@) : /g' > $@;


# ### Implicit rules for objects and dependencies, C++ language.
# ### Old version.
# define CXXRULES

# OBJ_EXT = $(subst c,o,$(1)) 
# DEP_EXT = $(subst c,d,$(1)) 

# $(BUILD_DIR_SLASH)%.$(OBJ_EXT): %.$(1)
# 	$(CXXC) $(CXXDEFINES) $(CXXFLAGS) $(CXXINCLUDES) -c $< -o $@  

# $(BUILD_DIR_SLASH)%.$(DEP_EXT): %.$(1)
# 	$(CXXC) -MM -MP -MG -MF $@ -MT $(BUILD_DIR_SLASH)$*.$(OBJ_EXT) -MT $@ 

# endef

# $(warning $(CXX_EXTENSIONS))
# $(warning $(CXXRULES))
# $(warning $(foreach ext, $(CXX_EXTENSIONS), $(eval $(call CXXRULES, $(ext))) ) )


# ### debugging facilities
# comment out to debug the makefile
# all: myprint
# myprint:
# ### debug print
#	echo $(OBJECTS)
#	echo $(DEPS)
# $(warning $(MAKEFILENAME))
# $(error error)

