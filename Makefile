
CXX=c++

BUILD_DIR_ROOT=$(PWD)
BUILD_PATH=$(BUILD_DIR_ROOT)/.obj
TARGET_PATH=$(BUILD_DIR_ROOT)/bin

INC_PATH = \
	-I$(THIRDPART)/include	\

LIB_PATH = \
	-L$(THIRDPART)/lib -luv \

IVY_COMPILE_OPT=-std=gnu++11 -g -g3 -fno-strict-aliasing -Wall -Werror $(INC_PATH)
IVY_LINK_OPT=-lpthread $(LIB_PATH)
IVY_DEBUG_OPT=

TARGET_PROJECTS := \
	TestServer\
	TestClient\

DEP_LIBS := \
	base

DEP_SCRIPT := \
	proto

ALLTARGET := $(DEP_LIBS) $(TARGET_PROJECTS)

$(DEP_LIBS): $(DEP_SCRIPT)
	@$(MAKE) -C $@ CXX=$(CXX) \
		IVY_COMPILE_OPT='$(IVY_COMPILE_OPT) $(IVY_DEBUG_OPT) -D_QA_DEBUG' \
		IVY_LINK_OPT='$(IVY_LINK_OPT)' \
		BUILD_DIR_ROOT='$(BUILD_DIR_ROOT)' \
		BUILD_PATH='$(BUILD_PATH)/$@' \
		SRC_PATH='$(BUILD_DIR_ROOT)/$@' \
		TARGET_PATH='$(TARGET_PATH)'\
		TARGET_NAME='$@';

$(TARGET_PROJECTS): $(DEP_LIBS)
	@if [ ! -d "$(TARGET_PATH)" ]; then mkdir -pv $(TARGET_PATH); fi
	@$(MAKE) -C $@ CXX=$(CXX) \
		IVY_COMPILE_OPT='$(IVY_COMPILE_OPT) $(IVY_DEBUG_OPT) -D_QA_DEBUG' \
		IVY_LINK_OPT='$(IVY_LINK_OPT)' \
		BUILD_DIR_ROOT='$(BUILD_DIR_ROOT)' \
		BUILD_PATH='$(BUILD_PATH)/$@' \
		SRC_PATH='$(BUILD_DIR_ROOT)/$@' \
		TARGET_PATH='$(TARGET_PATH)'\
		TARGET_NAME='$@'

proto:
	@echo "test shell cmd"

test:
	@echo $(BUILD_PATH)

clean:
