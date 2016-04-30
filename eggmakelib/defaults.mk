define egglib_SET_DEFAULT = 
$(if $(filter $(origin $(1)),undefined),$(eval $(1) := $(2)))
endef

$(call egglib_SET_DEFAULT,egg_TARGET,target.out)
$(call egglib_SET_DEFAULT,egg_BUILD_DIR,build.$(egg_TARGET))
$(call egglib_SET_DEFAULT,egg_MAKEFILE_FORCEBUILD,true)
$(call egglib_SET_DEFAULT,egg_CMDGOAL_FORCEBUILD,true)
$(call egglib_SET_DEFAULT,egg_CMDGOAL_FORCEBUILD_FILE,$(if $(egg_BUILD_DIR),$(egg_BUILD_DIR)/.eggmake_previous_goal,.eggmake_previous_goal))
