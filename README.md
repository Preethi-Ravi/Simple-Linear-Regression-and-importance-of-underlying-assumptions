# Simple-Linear-Regression-and-importance-of-underlying-assumptions
This repository deals with creating a simple linear regression model and how the model fails with the test data scenario when the relationship between predictor and predicted variables is curved.
Data: https://www.kaggle.com/uciml/autompg-dataset/data
Task: The auto mpg dataset contains 398 observations and 9 variables. The task is to analyse which among the four continuous variables (displacement, acceleration, weight, horsepower) yield the best linear regression models for predicting auto mpg. 
For simplicity's sake, only continuous variables are considered as predictors. The first 300 observations are taken as training set and the last 98 observations are taken as the test data set.

Summary of Univariate and Multivariate Analysis
Section 1.1: Univariate Linear Model for predicting mpg:

Among the four continuous variables present in the auto_mpg data set (horsepower, displacement, weight and acceleration), weight turned out to be the best predictor. This was inferred by analyzing:
•	Model summary (weight was significant at *** level, had low p value, high R square, high F statistic)
•	Analysis of residuals (histogram: fairly normal, residual plot was scattered around mean 0)
•	Other plots of significance: QQ Plot, Scatter plot with linear regression line through the explanatory and response variables

Model accuracy for test data:

The model failed to predict the test data well based on 
•	Analysis of residual plots
•	Actual mpg versus predicted mpg plot 
•	Scatter plot with regression line through explanatory and response variables

Primary reason for ambiguity in the fit for test data:

Even though weight remains to be the best predictor, due to the curved nature of the relationship between weight and mpg, fitting a simple linear model through the data did not yield proper results.
Section 1.2: Multivariate Linear Model for predicting mpg:

Step 1: To identify the best combination of continuous variables to predict mpg, the back elimination method was followed by inputting all variables into the model first.

Step 2: From the pairs plot, weight and displacement were collinear (had a relationship among themselves) and hence cannot be used together for modeling mpg. 

Step 3: From all four 3 variable combination models, 2 showed that weight and acceleration together we highly significant. Hence, these were chosen to be the best combination of predictors for mpg.

Further work involved analyzing:
•	Model summary (weight, acceleration were significant at *** level, had low p value, high R square, high F statistic)
•	Analysis of residuals (histogram: fairly normal, residual plots with each of the independent predictors were scattered around mean 0). Additionally, a 3D scatter plot with the regression plane was plotted to access the fit over training and testing data respectively.
•	Other plots of significance: QQ Plot

Model accuracy for test data:

The model failed to predict the test data well based on 
•	Analysis of residual plots
•	Actual mpg versus predicted mpg plot 
•	3D Scatter plot with regression plane passing under data points of mpg, weight and acceleration along each axis

Primary reason for ambiguity in the fit for test data:

Even though weight and acceleration remain to be the best combination of predictors, due to the curved nature of the relationship between weight, acceleration and mpg, fitting a multivariate linear model through the data did not yield proper results.
