#include "unity.h"
#include "unity_fixture.h"
#include "foo.h"

TEST_GROUP(foo);

TEST_SETUP(foo) {}

TEST_TEAR_DOWN(foo) {}

TEST(foo, test_bar) {
  TEST_ASSERT_EQUAL_INT32(0, bar());
}

TEST_GROUP_RUNNER(foo) {
  RUN_TEST_CASE(foo, test_bar);
}
