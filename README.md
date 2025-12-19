AlzPreFunction: Alzheimer’s Disease Risk Prediction
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

## Overall

<!-- badges: start -->

<!-- badges: end -->

This R package was developed for predicting Alzheimer’s disease risk.
You can find our dataset at:<https://www.kaggle.com/dsv/8668279>

Based on a Kaggle bioinformatics dataset,we developed seven machine
learning models and one deep learning model. The champion model is
LightGBM (AUC = 0.937), which showed superior performance and robustness
compared to the contrast model Elastic Net (AUC = 0.899).As a result,we
choose to use LightGBM.

The package implements the trained LightGBM model with necessary data
preprocessing and exports a prediction function that returns classified
risk outcomes (“High Risk” or “Low Risk”) as required.

## Installation

You can install the development version of AlzPreFunction like so:

``` r
if (!require("remotes")) install.packages("remotes")

remotes::install_github("jifenglinglan/AlzPreFunction")
```

To update between versions, please remove old version with the following
codes and then reinstall it with the above codes.

``` r
remove.packages("AlzPreFunction")
detach("package:AlzPreFunction")
```
Dependencies:LightGBM,Elastic Net
R version requirement:R ≥ 3.5.0
## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(AlzPreFunction)

# Load the example dataset (processed input features)
data(example_input)

# View the data
head(example_input)
#> # A tibble: 6 × 33
#>     Age Gender Ethnicity EducationLevel   BMI Smoking
#>   <dbl>  <dbl>     <dbl>          <dbl> <dbl>   <dbl>
#> 1    73      0         0              2  22.9       0
#> 2    89      0         0              0  26.8       0
#> 3    73      0         3              1  17.8       0
#> 4    74      1         0              1  33.8       1
#> 5    89      0         0              0  20.7       0
#> 6    86      1         1              1  30.6       0
#> # ℹ 27 more variables: AlcoholConsumption <dbl>,
#> #   PhysicalActivity <dbl>, DietQuality <dbl>,
#> #   SleepQuality <dbl>, FamilyHistoryAlzheimers <dbl>,
#> #   CardiovascularDisease <dbl>, Diabetes <dbl>,
#> #   Depression <dbl>, HeadInjury <dbl>, Hypertension <dbl>,
#> #   SystolicBP <dbl>, DiastolicBP <dbl>,
#> #   CholesterolTotal <dbl>, CholesterolLDL <dbl>, …

# Predict Alzheimer's risk
predictions <- predict_risk(example_input)

# View predictions
head(predictions)
#> [1] "Low Risk"  "Low Risk"  "Low Risk"  "Low Risk"  "High Risk"
#> [6] "Low Risk"

# Summary of risk levels
table(predictions)
#> predictions
#> High Risk  Low Risk 
#>         1         9
```

## Model Performance

The following table compares the performance of the champion model and
the contrast model based on 5-fold cross-validation:

The table below compares the champion and contrast models based on
5-fold cross-validation:

| Model | AUC | Key Characteristics |
|:---|:--:|:---|
| **LightGBM** (Champion) | **0.884** | Highest AUC, fast training, excellent handling of categorical features |
| Elastic Net (Contrast) | 0.825 | Linear model with built-in feature selection, good interpretability |

The LightGBM model was selected as the final deployed model due to its
superior predictive performance.

## Performance Visualization

![ROC Curves for Random Forest and Elastic Net
Models](inst/extdata/PRC.jpg)![ROC Curves for Random Forest and Elastic
Net Models](inst/extdata/ROC%20FPR.jpg)

This ROC curve（First figure) illustrates the comparison of classification performance between the LightGBM and ElasticNet models in the Alzheimer's disease prediction task.

This PRC graph further compares the performance of the two models in scenarios where the positive class samples are relatively scarce, with a focus on the trade-off between precision and recall.

## Group Division

Hongyao.Yang 2363361 Machine learning modeling Keyu.Fang 2252078 and
Zhenyu.Yang 2363283 Shiny website for database and model deployment
Yuzou.Lu 2360162 Create an R package for reproducible software

Finally, we jointly completed the project report.
## Reference
