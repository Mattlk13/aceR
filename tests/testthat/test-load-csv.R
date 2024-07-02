context("load raw csv data")

test_that("ACE Explorer CSV loads in", {
  sample_brt = paste(aceR_sample_data_path("explorer"), "sample-ace-brt-2.csv", sep = "/")
  sample_flanker = paste(aceR_sample_data_path("explorer"), "sample-ace-flanker-2.csv", sep = "/")
  
  expect_gt(nrow(load_ace_file(sample_brt, app_type = "explorer")), 0)
  expect_gt(nrow(load_ace_file(sample_flanker, app_type = "explorer")), 0)
})

test_that("SEA CSV loads in", {
  sample_sea = paste(aceR_sample_data_path("sea"), "sample-sea-1.csv", sep = "/")
  
  expect_gt(nrow(load_sea_file(sample_sea)), 0)
  expect_false(any(endsWith(load_sea_file(sample_sea)[[COL_MODULE]], ".")))
})

test_that("load_ace_file returns raises warning when called on a file with all practice data - should return an empty dataframe", {
  all_practice_file_path = file.path(aceR_sample_data_path("nexus"), "all_practice_backwardsspatialspan.csv")
  expect_warning(
    result <- load_ace_file(all_practice_file_path, app_type = "nexus"),
    "processing resulted in an empty data frame"
  )
  expect_equal(nrow(result), 0)
})
