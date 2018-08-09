CXXFLAGS = $(IVY_COMPILE_OPT)
TARGET= $(BUILD_PATH)/lib$(TARGET_NAME).a

OBJS=$(patsubst %.cpp, $(BUILD_PATH)/%.o, $(wildcard *.cpp))
DEPS = $(OBJS:$(BUILD_PATH)/%.o=$(BUILD_PATH)/.%.d)

all:$(TARGET)

-include $(DEPS)
$(DEPS): $(BUILD_PATH)/.%.d: ./%.cpp
	@if [ ! -d "$(dir $@)" ]; then mkdir -pv $(dir $@); fi
	@$(CXX) -M $(CXXFLAGS) $< > $@.$$$$; sed 's,\($*\)\.o[ :]*,$(BUILD_PATH)/\1.o $@ : ,g' < $@.$$$$ > $@; rm -f $@.$$$$

$(TARGET):$(OBJS)
	@rm -rf $(TARGET)
	@ar cru $(TARGET) $(OBJS)
	@ranlib $(TARGET)

$(OBJS): $(BUILD_PATH)/%.o:$(SRC_PATH)/%.cpp
	$(CXX) -c  $(CXXFLAGS) $< -o $@

clean:
	rm -rf $(BUILD_PATH) core* *~

.PHONY: all clean
