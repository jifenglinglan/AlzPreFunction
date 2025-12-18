test_that("predict_risk returns classified risk levels correctly", {
  data(example_input)

  predictions <- predict_risk(example_input)

  expect_type(predictions, "character")
  expect_length(predictions, nrow(example_input))
  expect_true(all(predictions %in% c("High Risk", "Low Risk")))
  expect_no_error(predict_risk(example_input))
})
