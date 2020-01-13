/**
 * \file            main.c
 * \brief           C Project Template
 * \author          Javier Balloffet <javier.balloffet@gmail.com>
 * \date            Jan 13, 2020
 * \details         Use makefile to build
 */

#include <stdio.h>
#include "foo.h"
#include "baz.h"

int main() {
  printf("foo.c -> bar(): %d\n", bar());
  printf("libbaz.a -> qux(): %d\n", qux());
  return 0;
}
