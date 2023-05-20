test_that("keys", {
    aa <- length(keys(HPO.db))
    expect_true(aa > 0)
})
