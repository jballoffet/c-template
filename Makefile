################################################################
# AUTHOR INFORMATION                                           #
################################################################

AUTHOR      	= "JavierBalloffet"
CLASS       	= "R1042"
EXERCISE      	= "1_1"
YEAR        	= "2020"

################################################################
# SOURCES, HEADERS, OBJECTS, LIBRARIES AND EXECUTABLES         #
################################################################

BIN_DIR     		= bin
BUILD_DIR   		= build
INC_DIR				= include
LIB_DIR         	= lib
SRC_DIR      		= src
TEST_DIR			= test

APP_BUILD_DIR   	= $(BUILD_DIR)/$(SRC_DIR)
APP_SOURCES    		= $(shell find $(SRC_DIR) -name '*.c')
APP_HEADERS    		= $(shell find $(SRC_DIR) -name '*.h')
APP_OBJS       		= $(patsubst %.c, $(APP_BUILD_DIR)/%.o, $(APP_SOURCES))
APP_LIB_SOURCES		= $(filter-out $(SRC_DIR)/main.c, $(APP_SOURCES))
APP_LIB_OBJS		= $(patsubst %.c, $(APP_BUILD_DIR)/%.o, $(APP_LIB_SOURCES))
APP_EXEC       		= app.out

TEST_BUILD_DIR 		= $(BUILD_DIR)/$(TEST_DIR)
TEST_SRC_DIR   		= $(TEST_DIR)/src
TEST_SOURCES  		= $(shell find $(TEST_SRC_DIR) -name '*.c')
TEST_OBJS      		= $(patsubst %.c, $(TEST_BUILD_DIR)/%.o, $(TEST_SOURCES))
TEST_UNITY_SRC_DIR	= $(TEST_DIR)/unity/src
TEST_UNITY_INC_DIR	= $(TEST_DIR)/unity/include
TEST_UNITY_SOURCES  = $(shell find $(TEST_UNITY_SRC_DIR) -name '*.c')
TEST_UNITY_OBJS    	= $(patsubst %.c, $(TEST_BUILD_DIR)/%.o, $(TEST_UNITY_SOURCES))
TEST_EXEC      		= test.out

################################################################
# COMPILER AND ARGUMENTS                                       #
################################################################

CC          	= gcc
CFLAGS      	= -c -Wall -I$(SRC_DIR) -I$(TEST_UNITY_INC_DIR) -I$(INC_DIR)
EXTRA_CFLAGS    =
LDFLAGS     	= -L$(LIB_DIR) -lbaz
EXTRA_LDFLAGS   = -lgcov --coverage

################################################################
# TAR FILE INFORMATION                                         #
################################################################

FILE_NAME   	= $(AUTHOR)-$(CLASS)-$(EXERCISE)-$(YEAR).tar.gz

################################################################
# TEXT EDITOR                                                  #
################################################################

TEXT_EDITOR 	= code

################################################################
# DOCUMENTATION                                                #
################################################################

DOC_GEN     	= doxygen
DOC_FILE    	= Doxyfile
DOC_DIR     	= doxy

################################################################
# MAKE TARGETS                                                 #
################################################################

.PHONY: all test clean compress edit doc run help

all: $(APP_EXEC)

$(APP_EXEC): $(APP_OBJS)
	@echo '[LD] Linking C executable $@'
	@mkdir -p $(BIN_DIR)
	@$(CC) $(APP_OBJS) $(LDFLAGS) -o $(BIN_DIR)/$@
	@echo 'Built target $@'

test: EXTRA_CFLAGS = -ftest-coverage -fprofile-arcs
test: $(TEST_EXEC)
	@./$(BIN_DIR)/$(TEST_EXEC)

$(TEST_EXEC): $(APP_LIB_OBJS) $(TEST_OBJS) $(TEST_UNITY_OBJS)
	@echo '[LD] Linking C executable $@'
	@mkdir -p $(BIN_DIR)
	@$(CC) $(APP_LIB_OBJS) $(TEST_OBJS) $(TEST_UNITY_OBJS) $(LDFLAGS) $(EXTRA_LDFLAGS) -o $(BIN_DIR)/$@
	@echo 'Built target $@'

$(APP_BUILD_DIR)/%.o: %.c Makefile
	@echo '[CC] Compiling C object $@'
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@

$(TEST_BUILD_DIR)/%.o: %.c Makefile
	@echo '[CC] Compiling C object $@'
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) $< -o $@

clean:
	@echo '[RM] Cleaning workspace'
	@rm -rf $(BUILD_DIR) $(BIN_DIR) $(DOC_DIR)

compress:
	@echo '[TAR] Packing workspace'
	@tar -zcvf $(FILE_NAME) $(SRC_DIR) $(TEST_DIR) Makefile $(DOC_FILE)

edit:
	@echo '[EDIT] Editing workspace'
	@$(TEXT_EDITOR) .

doc:
	@echo '[DOC] Generating documentation'
	@$(DOC_GEN) $(DOC_FILE)

run:
	@echo '[RUN] Running application'
	@./$(BIN_DIR)/$(EXEC)

help:
	@echo ''
	@echo '*****************************************************'
	@echo '  Uso:'
	@echo '    make all:       Compiles and links the application'
	@echo '    make test:      Runs unit tests'
	@echo '    make clean:     Removes objects and executable'
	@echo '    make compress:  Generates .tar.gz file'
	@echo '    make edit:      Opens code files with text editor'
	@echo '    make doc:       Generates code documentation'
	@echo '    make run:       Runs executable'
	@echo '    make help:      Shows help'
	@echo '*****************************************************'
	@echo ''
