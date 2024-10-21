CXX = g++
CXXFLAGS = --std=c++2a -Wall -Wextra -O3

SOURCES_DIR = src
UNITTEST_DIR = unittest

BUILD_DIR = build
SOURCES = $(wildcard $(SOURCES_DIR)/*.cpp)

MAIN = $(SOURCES_DIR)/main.cpp
PLAYERS = $(wildcard $(SOURCES_DIR)/player/*.cpp)
UNITTESTS = $(wildcard $(UNITTEST_DIR)/*.cpp)
STATE_SOURCE = $(SOURCES_DIR)/state/state.cpp
POLICY_DIR = $(SOURCES_DIR)/policy

TARGET_PLAYER = $(PLAYERS:$(SOURCES_DIR)/player/%.cpp=%)
TARGET_MAIN = main
TARGET_OTHER = selfplay benchmark
TARGET_UNITTEST = $(UNITTESTS:$(UNITTEST_DIR)/%.cpp=%)
OTHER = action state gamelog.txt


.PHONY: all clean
all: |$(BUILD_DIR) $(TARGET_MAIN) $(TARGET_PLAYER) $(TARGET_UNITTEST)
player: |$(BUILD_DIR) $(TARGET_PLAYER)

# make build dir if it doesn't exist
$(BUILD_DIR):
	mkdir "$(BUILD_DIR)"
	mkdir "$(UNITTEST_DIR)/build"

# build target
ifeq ($(OS), Windows_NT)
$(TARGET_PLAYER): % : $(SOURCES_DIR)/player/%.cpp
	$(CXX) $(CXXFLAGS) -o $(BUILD_DIR)/player_$@.exe $(STATE_SOURCE) $(POLICY_DIR)/$@.cpp $< 
$(TARGET_MAIN): % : $(SOURCES_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -o $(BUILD_DIR)/$@.exe $< 
$(TARGET_OTHER): %: $(SOURCES_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -o $(BUILD_DIR)/$@.exe $(STATE_SOURCE) $(POLICY_DIR)/*.cpp $<
$(TARGET_UNITTEST): %: $(UNITTEST_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -o $(UNITTEST_DIR)/build/$@.exe $(STATE_SOURCE) $(POLICY_DIR)/*.cpp $<
else
$(TARGET_PLAYER): % : $(SOURCES_DIR)/player/%.cpp
	$(CXX) $(CXXFLAGS) -o $(BUILD_DIR)/player_$@ $(STATE_SOURCE) $(POLICY_DIR)/$@.cpp $< 
$(TARGET_MAIN): % : $(SOURCES_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -o $(BUILD_DIR)/$@ $< 
$(TARGET_OTHER): %: $(SOURCES_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -o $(BUILD_DIR)/$@ $(STATE_SOURCE) $(POLICY_DIR)/*.cpp $<
$(TARGET_UNITTEST): %: $(UNITTEST_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -o $(UNITTEST_DIR)/build/$@ $(STATE_SOURCE) $(POLICY_DIR)/*.cpp $<
endif
