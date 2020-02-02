/**
 * \file            test_foo.c
 * \brief           Example test file
 * \author          Javier Balloffet <javier.balloffet@gmail.com>
 * \date            Jan 13, 2020
 * \details         Use makefile to build
 */

#include "unity.h"
#include "unity_fixture.h"
#include "foo.h"

TEST_GROUP(foo);

TEST_SETUP(foo) {}

TEST_TEAR_DOWN(foo) {}

TEST(foo, test_bar) {
  TEST_ASSERT_EQUAL_INT32(0, bar(0));
}

TEST_GROUP_RUNNER(foo) {
  RUN_TEST_CASE(foo, test_bar);
}
