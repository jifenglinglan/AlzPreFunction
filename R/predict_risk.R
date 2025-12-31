#' Predict Alzheimer's Risk using Trained Model
#'
#' This function preprocesses input data and uses the pre-trained model
#' to predict Alzheimer's risk.
#' Returns classified outcomes ("High Risk" or "Low Risk").
#'
#' @param new_data A data.frame with input features
#' @return A character vector of classified risk levels
#' @importFrom caret predict.train
#' @export
#'
#' @examples
#' data(example_input)
#' predictions <- predict_risk(example_input)
#' head(predictions)
predict_risk <- function(new_data) {
  # 1. Load the model
  model_path <- system.file(
    "extdata",
    "final_model_lgb.rds",
    package = "AlzPreFunction"
  )
  if (model_path == "" || !file.exists(model_path)) {
    stop("Model file not found. Check if final_model_rf.rds is in inst/extdata/")
  }
  model <- readRDS(model_path)

  # 2. pretreatment
  colnames(new_data) <- make.names(colnames(new_data))

  if ("SystolicBP" %in% names(new_data) &&
      "DiastolicBP" %in% names(new_data)) {
    new_data$PulsePressure <- new_data$SystolicBP - new_data$DiastolicBP
  } else {
    warning("PulsePressure not added: Missing BP columns.")
  }

  cat_cols <- c(
    "Gender", "Ethnicity", "EducationLevel", "Smoking",
    "FamilyHistoryAlzheimers", "CardiovascularDisease", "Diabetes",
    "Depression", "HeadInjury", "Hypertension", "MemoryComplaints",
    "BehavioralProblems", "Confusion", "Disorientation",
    "PersonalityChanges", "DifficultyCompletingTasks", "Forgetfulness"
  )
  for (col in cat_cols) {
    if (col %in% names(new_data)) {
      new_data[[col]] <- as.factor(new_data[[col]])
    }
  }

  # 3. forecast
  prob_matrix <- caret::predict.train(
    model,
    newdata = new_data,
    type = "prob"
  )

  # 4. Extract the probability of the positive class
  levels <- model$levels
  positive_class <- levels[2]
  if (is.na(positive_class) || !positive_class %in% colnames(prob_matrix)) {
    prob_positive <- prob_matrix[, 2]
  } else {
    prob_positive <- prob_matrix[, positive_class]
  }

  # 5. Return the classification result
  risk_levels <- ifelse(prob_positive > 0.5, "High Risk", "Low Risk")
  return(as.character(risk_levels))
}

