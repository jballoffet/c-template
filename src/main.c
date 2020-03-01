/*!
 * @file   main.c
 * @brief  Example main file
 * @author Javier Balloffet <javier.balloffet@gmail.com>
 * @date   Jan 13, 2020
 *
 * Example main file, part of the C Project Template. Use makefile to build.
 */
#include <stdio.h>
#include "bar.h"
#include "baz.h"
#include "foo.h"

/*!
 * @brief Entry point function.
 *
 * @return Zero on success, and non-zero on failure.
 */
int main() {
  printf("Hello World!\n");
  printf("foo.c -> foo_function(0): %d\n", foo_function(0));
  printf("bar.c -> bar_function_abs(-1): %d\n", bar_function_abs(-1));
  printf("bar.c -> bar_function_double(1): %d\n", bar_function_double(1));
  printf("libbaz.a -> baz_function(): %d\n", baz_function());
  return 0;
}
