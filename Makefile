################################################################
# AUTHOR INFORMATION                                           #
################################################################

AUTHOR   = "JavierBalloffet"
CLASS    = "R1042"
EXERCISE = "1_1"
YEAR     = "2020"

################################################################
# SOURCES, HEADERS, OBJECTS, LIBRARIES AND EXECUTABLES         #
################################################################

BIN_DIR            = bin
BUILD_DIR          = build
INC_DIR            = include
LIB_DIR            = lib
SRC_DIR            = src
TEST_DIR           = test

APP_SOURCES        = $(shell find $(SRC_DIR) -name '*.c')
APP_HEADERS        = $(shell find $(SRC_DIR) -name '*.h')
APP_OBJS           = $(patsubst %.c, $(BUILD_DIR)/%.o, $(APP_SOURCES))
APP_EXEC           = app.out

TEST_SRC_DIR       = $(TEST_DIR)/src
TEST_SOURCES       = $(shell find $(TEST_SRC_DIR) -name '*.c')
TEST_OBJS          = $(patsubst %.c, $(BUILD_DIR)/%.o, $(TEST_SOURCES))
TEST_UNITY_SRC_DIR = $(TEST_DIR)/unity/src
TEST_UNITY_INC_DIR = $(TEST_DIR)/unity/include
TEST_UNITY_SOURCES = $(shell find $(TEST_UNITY_SRC_DIR) -name '*.c')
TEST_UNITY_OBJS    = $(patsubst %.c, $(BUILD_DIR)/%.o, $(TEST_UNITY_SOURCES))
TEST_APP_SOURCES   = $(filter-out $(SRC_DIR)/main.c, $(APP_SOURCES))
TEST_APP_OBJS      = $(patsubst %.c, $(BUILD_DIR)/%_cov.o, $(TEST_APP_SOURCES))
TEST_EXEC          = test.out

################################################################
# COMPILER AND ARGUMENTS                                       #
################################################################

ifeq ($(COMPILER), clang)
  $(info CC = clang)
  CC = clang
else
  CC = gcc
endif

CFLAGS        = -c -Wall -I$(SRC_DIR) -I$(TEST_UNITY_INC_DIR) -I$(INC_DIR)
EXTRA_CFLAGS  =
LDFLAGS       = -L$(LIB_DIR) -lbaz

ifeq ($(DEBUG), on)
  EXTRA_CFLAGS += -g -O0 -DDEBUG
endif

ifeq ($(COVERAGE), on)
  COVERAGE_CFLAGS  = -ftest-coverage -fprofile-arcs
  COVERAGE_LDFLAGS = -lgcov --coverage
endif

################################################################
# TAR FILE INFORMATION                                         #
################################################################

FILE_NAME = $(AUTHOR)-$(CLASS)-$(EXERCISE)-$(YEAR).tar.gz

################################################################
# TEXT EDITOR                                                  #
################################################################

TEXT_EDITOR = code

################################################################
# DOCUMENTATION                                                #
################################################################

DOC_GEN  = doxygen
DOC_FILE = Doxyfile
DOC_DIR  = doc

################################################################
# OTHER TOOLS                                                  #
################################################################

FORMAT_TOOL            = clang-format
FORMAT_FLAGS           = -style=file -i -fallback-style=none

STATIC_ANALYSIS_TOOL   = clang-tidy

DYNAMIC_ANALYSIS_TOOL  = valgrind
DYNAMIC_ANALYSIS_FLAGS = --tool=memcheck --leak-check=full --track-fds=yes --trace-children=yes --error-exitcode=1

################################################################
# MAKE TARGETS                                                 #
################################################################

.PHONY: all test clean compress edit doc run format tidy memcheck help

all: $(APP_EXEC)

$(APP_EXEC): $(APP_OBJS)
	@echo '[LD] Linking C executable $@'
	@mkdir -p $(BIN_DIR)
	$(CC) $(APP_OBJS) $(LDFLAGS) -o $(BIN_DIR)/$@
	@echo 'Built target $@'

test: $(TEST_EXEC)
	@echo '[RUN] Running unit tests'
	@./$(BIN_DIR)/$(TEST_EXEC)

$(TEST_EXEC): $(TEST_APP_OBJS) $(TEST_OBJS) $(TEST_UNITY_OBJS)
	@echo '[LD] Linking C executable $@'
	@mkdir -p $(BIN_DIR)
	@$(CC) $(TEST_APP_OBJS) $(TEST_OBJS) $(TEST_UNITY_OBJS) $(LDFLAGS) $(COVERAGE_LDFLAGS) -o $(BIN_DIR)/$@
	@echo 'Built target $@'

$(BUILD_DIR)/%.o: %.c Makefile
	@echo '[CC] Compiling C object $@'
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@

$(BUILD_DIR)/%_cov.o: %.c Makefile
	@echo '[CC] Compiling C object $@'
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(COVERAGE_CFLAGS) $< -o $@

clean:
	@echo '[RM] Cleaning workspace'
	@rm -rf $(BUILD_DIR) $(BIN_DIR) $(DOC_DIR)

compress:
	@echo '[TAR] Packing workspace'
	@tar -zcvf $(FILE_NAME) $(SRC_DIR) $(TEST_SRC_DIR) Makefile $(DOC_FILE)

edit:
	@echo '[EDIT] Editing workspace'
	@$(TEXT_EDITOR) .

doc:
	@echo '[DOC] Generating documentation'
	@mkdir -p $(DOC_DIR)
	@$(DOC_GEN) $(DOC_FILE)

run:
	@echo '[RUN] Running application'
	@./$(BIN_DIR)/$(EXEC)

format:
	@echo '[FORMAT] Formatting source code'
	@$(FORMAT_TOOL) $(FORMAT_FLAGS) $(APP_SOURCES) $(APP_HEADERS) $(TEST_SOURCES)

tidy:
	@echo '[TIDY] Running ClangTidy for static analysis'
	@$(STATIC_ANALYSIS_TOOL) $(APP_SOURCES) $(APP_HEADERS) $(TEST_SOURCES) -- -I$(SRC_DIR) -I$(TEST_UNITY_INC_DIR) -I$(INC_DIR)

memcheck: $(TEST_EXEC)
	@echo '[MEMCHECK] Running Valgrind for dynamic analysis'
	@$(DYNAMIC_ANALYSIS_TOOL) $(DYNAMIC_ANALYSIS_FLAGS) ./$(BIN_DIR)/$(TEST_EXEC)

help:
	@echo ''
	@echo '********************************************************'
	@echo '  Uso:'
	@echo '    make all:       Compiles and links the application'
	@echo '    make test:      Runs unit tests'
	@echo '    make clean:     Removes objects and executable'
	@echo '    make compress:  Generates .tar.gz file'
	@echo '    make edit:      Opens code files with text editor'
	@echo '    make doc:       Generates code documentation'
	@echo '    make run:       Runs executable'
	@echo '    make format:    Formats source code'
	@echo '    make tidy:      Performs static analysis'
	@echo '    make memcheck:  Performs dynamic analysis'
	@echo '    make help:      Shows help'
	@echo '********************************************************'
	@echo ''
