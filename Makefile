################################################################
# AUTHOR INFORMATION                                           #
################################################################

AUTHOR      	= "JavierBalloffet"
CLASS       	= "R1042"
TP          	= "TP1"
YEAR        	= "2020"

################################################################
# COMPILER AND ARGUMENTS                                       #
################################################################

CC          	= gcc
CFLAGS      	= -c -Wall -Isrc -Itest/unity/include -Iinclude -ftest-coverage -fprofile-arcs
LDFLAGS     	= -Llib -lbaz -lgcov --coverage

################################################################
# SOURCES, HEADERS, OBJECTS AND EXECUTABLES                    #
################################################################

SRC_DIR     	= src
TEST_DIR    	= test
BUILD_DIR   	= build
BIN_DIR     	= bin

SOURCES     	= $(shell find $(SRC_DIR) -name '*.c')
OBJS        	= $(patsubst %.c, $(BUILD_DIR)/%.o, $(SOURCES))
HEADERS     	= $(shell find $(SRC_DIR) -name '*.h')
EXEC        	= app.out

TEST_SOURCES  	= $(shell find $(TEST_DIR) -name '*.c')
TEST_OBJS      	= $(patsubst %.c, $(BUILD_DIR)/%.o, $(TEST_SOURCES))
TEST_SRC_OBJS	= $(filter-out $(BUILD_DIR)/src/main.o, $(OBJS))
TEST_EXEC      	= test.out

################################################################
# TAR FILE INFORMATION                                         #
################################################################

FILE_NAME   	= $(AUTHOR)-$(CLASS)-$(TP)-$(YEAR).tar.gz

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

all: $(EXEC)

$(EXEC): $(OBJS)
	@echo ''
	@echo '*****************************************************'
	@echo '---> Linking...'
	mkdir -p $(BIN_DIR)
	$(CC) $(OBJS) $(LDFLAGS) -o $(BIN_DIR)/$@
	@echo '---> Linking Complete!'
	@echo '*****************************************************'
	@echo ''

test: $(TEST_EXEC)
	@echo ''
	@echo '*****************************************************'
	@echo '---> Running unit tests...'
	@./$(BIN_DIR)/$(TEST_EXEC)

$(TEST_EXEC): $(TEST_OBJS) $(TEST_SRC_OBJS)
	@echo ''
	@echo '*****************************************************'
	@echo '---> Linking...'
	mkdir -p $(BIN_DIR)
	$(CC) $(TEST_OBJS) $(TEST_SRC_OBJS) $(LDFLAGS) -o $(BIN_DIR)/$@
	@echo '---> Linking Complete!'
	@echo '*****************************************************'
	@echo ''

$(BUILD_DIR)/%.o: %.c Makefile
	@echo ''
	@echo '*****************************************************'
	@echo '---> Compiling...'
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $< -o $@
	@echo '---> Compiling Complete!'
	@echo '*****************************************************'
	@echo ''

clean:
	@echo ''
	@echo '*****************************************************'
	@echo '---> Cleaning...'
	rm -rf $(BUILD_DIR) $(BIN_DIR) $(DOC_DIR) *.gcov
	@echo '---> Cleaning Complete!'
	@echo '*****************************************************'
	@echo ''

compress: $(SRC_DIR) $(TEST_DIR)/ Makefile $(DOC_FILE)
	@echo ''
	@echo '*****************************************************'
	@echo '---> Packing...'
	tar -zcvf $(FILE_NAME) $(SRC_DIR) $(TEST_DIR) Makefile $(DOC_FILE)
	@echo '---> Packing Complete!'
	@echo '*****************************************************'
	@echo ''

edit:
	@echo ''
	@echo '*****************************************************'
	@echo '---> Editing...'
	$(TEXT_EDITOR) .

doc:
	@echo ''
	@echo '*****************************************************'
	@echo '---> Generating Code Documentation...'
	$(DOC_GEN) $(DOC_FILE)
	@echo '---> Generating Code Documentation Complete!'
	@echo '*****************************************************'
	@echo ''

run:
	@echo ''
	@echo '*****************************************************'
	@echo '---> Running...'
	./$(BIN_DIR)/$(EXEC)

coverage: test
	@echo ''
	@echo '*****************************************************'
	@echo '---> Computing test coverage...'
	gcov -o build/src --source-prefix src foo.c

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
