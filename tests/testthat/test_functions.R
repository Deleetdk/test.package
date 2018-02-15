context("test")

print_function <- function(x) print(x)


# version 1 ---------------------------------------------------------------

test_that("inner_v1", {
  expect_equal(inner_func1("print_function"), "hello")
})

test_that("outer_v1", {
  expect_equal(outer_func1("print_function"), "hello")
})


# version 2 ---------------------------------------------------------------

test_that("inner_v2",{
  expect_equal(inner_func2("print_function"), "hello")
})

test_that("outer_v2",{
  expect_equal(outer_func2("print_function"), "hello")
})

test_that("inner_v2b",{
  expect_equal(inner_func2b("print_function"), "hello")
})


# version 3 ---------------------------------------------------------------

test_that("inner_v3",{
  expect_equal(inner_func3("print_function"), "hello")
})

test_that("outer_v3",{
  expect_equal(outer_func3("print_function"), "hello")
})
