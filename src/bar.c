/*!
 * @file   bar.c
 * @brief  Example source file
 * @author Javier Balloffet <javier.balloffet@gmail.com>
 * @date   Feb 29, 2020
 *
 * Example source file, part of the C Project Template. Use makefile to build.
 */
#include "bar.h"

int bar_function_double(int number) { return number * 2; }

int bar_function_abs(int number) {
  if (number < 0) {
    return number * (-1);
  }
  return number;
}
