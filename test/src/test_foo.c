/*!
 * @file   test_foo.c
 * @brief  Example test file
 * @author Javier Balloffet <javier.balloffet@gmail.com>
 * @date   Jan 13, 2020
 *
 * Example test file, part of the C Project Template. Use makefile to build.
 */
#include "foo.h"
#include "unity.h"
#include "unity_fixture.h"

TEST_GROUP(foo);

TEST_SETUP(foo) {}

TEST_TEAR_DOWN(foo) {}

TEST(foo, test_foo_function) {
  TEST_ASSERT_EQUAL_INT32(0, foo_function(0));
  TEST_ASSERT_EQUAL_INT32(1, foo_function(1));
  TEST_ASSERT_EQUAL_INT32(-1, foo_function(-1));
}

TEST_GROUP_RUNNER(foo) { RUN_TEST_CASE(foo, test_foo_function); }
