/*!
 * @file   main.c
 * @brief  Example main file
 * @author Javier Balloffet <javier.balloffet@gmail.com>
 * @date   Jan 13, 2020
 * 
 * Example main file, part of the C project template. Use makefile to build.
 */
#include <stdio.h>
#include "foo.h"
#include "baz.h"

/*!
 * @brief Entry point function.
 * 
 * @return The function returns 0 on success, and non-zero on failure.
 */
int main() {
  printf("Hello World!\n");
  printf("foo.c -> bar(): %d\n", bar(0));
  printf("libbaz.a -> qux(): %d\n", qux());
  return 0;
}
