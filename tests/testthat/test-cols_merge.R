context("Ensuring that the `cols_merge*()` functions work as expected")

# Create a shortened version of `mtcars`
mtcars_short <- mtcars[1:5, ]

# Create a table with rownames and four columns of values
tbl <-
  dplyr::tribble(
    ~col_1, ~col_2, ~col_3, ~col_4,
     767.6,  928.1,  382.0,  674.5,
     403.3,  461.5,   15.1,  242.8,
     686.4,   54.1,  282.7,   56.3,
     662.6,  148.8,  984.6,  928.1,
     198.5,   65.1,  127.4,  219.3,
     132.1,  118.1,   91.2,  874.3,
     349.7,  307.1,  566.7,  542.9,
      63.7,  504.3,  152.0,  724.5,
     105.4,  729.8,  962.4,  336.4,
     924.2,  424.6,  740.8,  104.2)

# Function to skip tests if Suggested packages not available on system
check_suggests <- function() {
  skip_if_not_installed("rvest")
  skip_if_not_installed("xml2")
}

test_that("the function `cols_merge()` works correctly", {

  # Check that specific suggested packages are available
  check_suggests()

  # Create a `tbl_html` object with `gt()`; merge two columns
  # with a `pattern`
  tbl_html <-
    gt(mtcars_short) %>%
      cols_merge(
        col_1 = "drat",
        col_2 = "wt",
        pattern = "{1} ({2})")

  # Expect that merging statements are stored in `col_merge`
  attr(tbl_html, "col_merge", exact = TRUE)$pattern %>%
    expect_equal("{1} ({2})")

  attr(tbl_html, "col_merge", exact = TRUE)$sep %>%
    expect_equal("")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1 %>%
    names() %>%
    expect_equal("wt")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1 %>%
    unname() %>%
    expect_equal("drat")

  # Create a `tbl_html` object with `gt()`; merge two columns
  # with a `pattern` and use the `vars()` helper
  tbl_html <-
    gt(mtcars_short) %>%
    cols_merge(
      col_1 = vars(drat),
      col_2 = vars(wt),
      pattern = "{1} ({2})")

  # Expect that merging statements are stored in `col_merge`
  attr(tbl_html, "col_merge", exact = TRUE)$pattern %>%
    expect_equal("{1} ({2})")

  attr(tbl_html, "col_merge", exact = TRUE)$sep %>%
    expect_equal("")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1 %>%
    names() %>%
    expect_equal("wt")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1 %>%
    unname() %>%
    expect_equal("drat")

  # Create a `tbl_html` object with `gt()`; merge two columns, twice,
  # with two different `pattern`s; use the `vars()` helper
  tbl_html <-
    gt(mtcars_short) %>%
    cols_merge(
      col_1 = vars(drat),
      col_2 = vars(wt),
      pattern = "{1} ({2})") %>%
    cols_merge(
      col_1 = vars(gear),
      col_2 = vars(carb),
      pattern = "{1}-{2}")

  # Expect that merging statements are stored in `col_merge`
  attr(tbl_html, "col_merge", exact = TRUE)$pattern[[1]] %>%
    expect_equal("{1} ({2})")

  attr(tbl_html, "col_merge", exact = TRUE)$sep[[1]] %>%
    expect_equal("")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1[1] %>%
    names() %>%
    expect_equal("wt")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1[1] %>%
    unname() %>%
    expect_equal("drat")

  attr(tbl_html, "col_merge", exact = TRUE)$pattern[[2]] %>%
    expect_equal("{1}-{2}")

  attr(tbl_html, "col_merge", exact = TRUE)$sep[[2]] %>%
    expect_equal("")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1[2] %>%
    names() %>%
    expect_equal("carb")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1[2] %>%
    unname() %>%
    expect_equal("gear")
})

test_that("the `cols_merge_uncert()` function works correctly", {

  # Check that specific suggested packages are available
  check_suggests()

  # Create a `tbl_html` object with `gt()`; merge two columns
  # with `cols_merge_uncert()`
  tbl_html <-
    gt(tbl) %>%
    cols_merge_uncert(
      col_val = "col_1",
      col_uncert = "col_2")

  # Expect that merging statements are stored in `col_merge`
  attr(tbl_html, "col_merge", exact = TRUE)$pattern %>%
    expect_equal("{1} ± {2}")

  attr(tbl_html, "col_merge", exact = TRUE)$sep %>%
    expect_equal("")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1 %>%
    names() %>%
    expect_equal("col_2")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1 %>%
    unname() %>%
    expect_equal("col_1")

  # Create a `tbl_html` object with `gt()`; merge two columns
  # with `cols_merge_uncert()` and use the `vars()` helper
  tbl_html <-
    gt(tbl) %>%
    cols_merge_uncert(
      col_val = vars(col_1),
      col_uncert = vars(col_2))

  # Expect that merging statements are stored in `col_merge`
  attr(tbl_html, "col_merge", exact = TRUE)$pattern %>%
    expect_equal("{1} ± {2}")

  attr(tbl_html, "col_merge", exact = TRUE)$sep %>%
    expect_equal("")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1 %>%
    names() %>%
    expect_equal("col_2")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1 %>%
    unname() %>%
    expect_equal("col_1")

  # Create a `tbl_html` object with `gt()`; merge two columns, twice,
  # with `cols_merge_uncert()` and use the `vars()` helper
  tbl_html <-
    gt(tbl) %>%
    cols_merge_uncert(
      col_val = vars(col_1),
      col_uncert = vars(col_2)) %>%
    cols_merge_uncert(
      col_val = vars(col_3),
      col_uncert = vars(col_4))

  # Expect that merging statements are stored in `col_merge`
  attr(tbl_html, "col_merge", exact = TRUE)$pattern[[1]] %>%
    expect_equal("{1} ± {2}")

  attr(tbl_html, "col_merge", exact = TRUE)$sep[[1]] %>%
    expect_equal("")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1[1] %>%
    names() %>%
    expect_equal("col_2")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1[1] %>%
    unname() %>%
    expect_equal("col_1")

  attr(tbl_html, "col_merge", exact = TRUE)$pattern[[2]] %>%
    expect_equal("{1} ± {2}")

  attr(tbl_html, "col_merge", exact = TRUE)$sep[[2]] %>%
    expect_equal("")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1[2] %>%
    names() %>%
    expect_equal("col_4")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1[2] %>%
    unname() %>%
    expect_equal("col_3")
})

test_that("the `cols_merge_range()` function works correctly", {

  # Check that specific suggested packages are available
  check_suggests()

  # Create a `tbl_html` object with `gt()`; merge two columns
  # with `cols_merge_range()`
  tbl_html <-
    gt(tbl) %>%
    cols_merge_range(
      col_begin = "col_1",
      col_end = "col_2")

  # Expect that merging statements are stored in `col_merge`
  attr(tbl_html, "col_merge", exact = TRUE)$pattern %>%
    expect_equal("{1} {sep} {2}")

  attr(tbl_html, "col_merge", exact = TRUE)$sep %>%
    expect_equal("---")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1 %>%
    names() %>%
    expect_equal("col_2")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1 %>%
    unname() %>%
    expect_equal("col_1")

  # Create a `tbl_html` object with `gt()`; merge two columns
  # with `cols_merge_range()` and use the `vars()` helper
  tbl_html <-
    gt(tbl) %>%
    cols_merge_range(
      col_begin = vars(col_1),
      col_end = vars(col_2))

  # Expect that merging statements are stored in `col_merge`
  attr(tbl_html, "col_merge", exact = TRUE)$pattern %>%
    expect_equal("{1} {sep} {2}")

  attr(tbl_html, "col_merge", exact = TRUE)$sep %>%
    expect_equal("---")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1 %>%
    names() %>%
    expect_equal("col_2")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1 %>%
    unname() %>%
    expect_equal("col_1")

  # Create a `tbl_html` object with `gt()`; merge two columns, twice,
  # with `cols_merge_range()` and use the `vars()` helper
  tbl_html <-
    gt(tbl) %>%
    cols_merge_range(
      col_begin = vars(col_1),
      col_end = vars(col_2)) %>%
    cols_merge_range(
      col_begin = vars(col_3),
      col_end = vars(col_4))

  # Expect that merging statements are stored in `col_merge`
  attr(tbl_html, "col_merge", exact = TRUE)$pattern[[1]] %>%
    expect_equal("{1} {sep} {2}")

  attr(tbl_html, "col_merge", exact = TRUE)$sep[[1]] %>%
    expect_equal("---")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1[1] %>%
    names() %>%
    expect_equal("col_2")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1[1] %>%
    unname() %>%
    expect_equal("col_1")

  attr(tbl_html, "col_merge", exact = TRUE)$pattern[[2]] %>%
    expect_equal("{1} {sep} {2}")

  attr(tbl_html, "col_merge", exact = TRUE)$sep[[2]] %>%
    expect_equal("---")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1[2] %>%
    names() %>%
    expect_equal("col_4")

  attr(tbl_html, "col_merge", exact = TRUE)$col_1[2] %>%
    unname() %>%
    expect_equal("col_3")
})
