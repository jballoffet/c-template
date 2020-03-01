/*!
 * @file   test_bar.c
 * @brief  Example test file
 * @author Javier Balloffet <javier.balloffet@gmail.com>
 * @date   Feb 29, 2020
 *
 * Example test file, part of the C Project Template. Use makefile to build.
 */
#include "bar.h"
#include "unity.h"
#include "unity_fixture.h"

TEST_GROUP(bar);

TEST_SETUP(bar) {}

TEST_TEAR_DOWN(bar) {}

TEST(bar, test_bar_function_double) {
  TEST_ASSERT_EQUAL_INT32(0, bar_function_double(0));
  TEST_ASSERT_EQUAL_INT32(2, bar_function_double(1));
  TEST_ASSERT_EQUAL_INT32(4, bar_function_double(2));
  TEST_ASSERT_EQUAL_INT32(-2, bar_function_double(-1));
  TEST_ASSERT_EQUAL_INT32(-4, bar_function_double(-2));
}

TEST(bar, test_bar_function_abs) {
  TEST_ASSERT_EQUAL_INT32(1, bar_function_abs(-1));
  TEST_ASSERT_EQUAL_INT32(1, bar_function_abs(1));
  TEST_ASSERT_EQUAL_INT32(0, bar_function_abs(0));
}

TEST_GROUP_RUNNER(bar) {
  RUN_TEST_CASE(bar, test_bar_function_double);
  RUN_TEST_CASE(bar, test_bar_function_abs);
}
