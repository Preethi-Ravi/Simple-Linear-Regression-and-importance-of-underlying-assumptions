#Section 2.1: Reading data into R and renaming variables

#reading raw data
auto_mpg_data<-read.table('/users/preethi/Desktop/auto-mpg.data')
View(auto_mpg_data)

#Models with one independent variable
#Renaming variables
names(auto_mpg_data)<-c("mpg","cylinders","displacement","horsepower","weight","acceleration","model year","origin","car name")
auto_mpg_data_modified <- auto_mpg_data[,c(1,3,4,5,6)]
View(auto_mpg_data_modified)
#Section 2.2: Treating missing values in Horsepower: Using average to fill missing values

#After preliminary analysis, Horsepower model is not providing expected results
#INFERENCE: class of horsepower is factor because of the '?' in place of 6 missing values 
class(auto_mpg_data_modified$horsepower)

#changing class of horsepower from factor to numeric
auto_mpg_data_modified$horsepower<-as.numeric(auto_mpg_data_modified$horsepower)

# After changing the class to numeric, '?' was automatically converted to '1'
#Performing analysis after removing 6 observations which had horsepower=1 did not seem to be a good method to follow
#since clean data of other variables viz. weight, displacement, acceleration was lost
data_nonmissing<-auto_mpg_data_modified[auto_mpg_data_modified$horsepower!=1,]
mean(data_nonmissing$horsepower)

#Robust approach to follow is to replace missing values with mean from all nonmissing values from horsepower 
#replacing missing values with mean
mean(auto_mpg_data_modified$horsepower)
auto_mpg_data_modified[auto_mpg_data_modified$horsepower==1,]<-mean(data_nonmissing$horsepower)
auto_mpg_data_modified[auto_mpg_data_modified$horsepower==1,]
#Section 2.3: Creating training data set

training_data<-auto_mpg_data_modified[1:300,]
View(training_data)


#Section 2.4: Examining pairs plot to study the relationship between attributes

#examining pairs() plot
pairs(training_data)

 
#Section 2.5: Building Univariate Linear Models
#Section 2.5.1: Linear Model of mpg against displacement: Summary and Histogram of residuals

mpg_disp1<-lm(mpg~displacement,data=training_data)
summary(mpg_disp1)
hist(mpg_disp1$residuals,breaks = 30)

Call
lm(formula = mpg ~ displacement, data = training_data)

Residuals:
     Min       1Q   Median       3Q      Max 
-10.3175  -2.0821  -0.5313   1.7538  22.9363 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept)  31.876316   0.490064   65.05   <2e-16 ***
displacement -0.050841   0.002038  -24.94   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.866 on 298 degrees of freedom
Multiple R-squared:  0.6762,	Adjusted R-squared:  0.6751 
F-statistic: 622.2 on 1 and 298 DF,  p-value: < 2.2e-16

 

#Section 2.5.2: Linear Model of mpg against weight: Summary and Histogram of residuals (Best Predictor)

mpg_wt1<-lm(mpg~weight,data=training_data)
summary(mpg_wt1)
hist(mpg_wt1$residuals,breaks = 30)

Call:
lm(formula = mpg ~ weight, data = training_data)

Residuals:
   Min     1Q Median     3Q    Max 
-9.507 -1.878  0.007  1.798 14.681 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) 41.4394926  0.6418262   64.56   <2e-16 ***
weight      -0.0065597  0.0001976  -33.20   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.134 on 298 degrees of freedom
Multiple R-squared:  0.7872,	Adjusted R-squared:  0.7865 
F-statistic:  1102 on 1 and 298 DF,  p-value: < 2.2e-16


 

#Section 2.5.3: Linear Model of mpg against horsepower: Summary and Histogram of residuals

mpg_hp1<-lm(mpg~horsepower,data=training_data)
summary(mpg_hp1)
hist(mpg_hp1$residuals,breaks = 30)

Call:
lm(formula = mpg ~ horsepower, data = training_data)

Residuals:
     Min       1Q   Median       3Q      Max 
-11.2153  -4.6826  -0.5734   3.1916  30.8034 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 16.01977    0.66625   24.05   <2e-16 ***
horsepower   0.10233    0.01167    8.77   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 6.056 on 298 degrees of freedom
Multiple R-squared:  0.2051,	Adjusted R-squared:  0.2025 
F-statistic: 76.91 on 1 and 298 DF,  p-value: < 2.2e-16

 

#Section 2.5.4: Linear Model of mpg against acceleration: Summary and Histogram of residuals

mpg_acc1<-lm(mpg~acceleration,data=training_data)
summary(mpg_acc1)
hist(mpg_acc1$residuals,breaks = 30)

Call:
lm(formula = mpg ~ acceleration, data = training_data)

Residuals:
    Min      1Q  Median      3Q     Max 
-14.844  -3.959  -1.095   3.051  16.415 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept)    6.3235     1.2746   4.961 1.18e-06 ***
acceleration   0.9470     0.0796  11.898  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 5.593 on 298 degrees of freedom
Multiple R-squared:  0.3221,	Adjusted R-squared:  0.3198 
F-statistic: 141.6 on 1 and 298 DF,  p-value: < 2.2e-16

 
#Section 2.5.5: Comparative study of mpg versus weight and mpg versus displacement models

#First looking at histograms of residuals from all models
#mgp_wt1 and mpg_disp1 show close to normal graphs

#since weight and displacement produced good models we will explore them further

Study of QQ Plots: 
plot(mpg_disp1)

 

plot(mpg_wt1)
 
#INFERENCE: QQ plot of mpg with weight has lesser outliers towards the top



#Study of Summary of Model fit:

#drilling down into the statistics from summary

#1) mpg_wt1 has greater F-statistic (sum of squares of means / sum of squares of errors) of 1102 
#compared to the F-statistic of mpg_disp1
#2) mpg_wt1 has lower standard error of 3.134 compared to the standard error of mpg_disp1
#3) mpg_wt1 has greater R-squared value of 0.7872 compared to the R-squared value of mpg_disp1 of 0.6762

#Study of Residuals versus predictor variables: 

#residuals vs predictor variables

plot(training_data$displacement,mpg_disp1$residuals)
 

plot(training_data$weight,mpg_wt1$residuals)
x <- seq(0,5500,length=5500)
y <- dnorm(x,mean(mpg_wt1$residuals),sd(mpg_wt1$residuals))
lines(x,y,col=“red")

 #INFERENCE: from the above plots, since residuals are randomly scattered around the mean 0 for weight, we come to a conclusion that the weight is the better predictor (significant variable) of mpg. However, there is a slightly curved trend observed.

#Study of Absolute value of residuals versus predictor variables:

#absolute value of the residuals vs predictor variables

plot(training_data$displacement,abs(mpg_disp1$residuals))

plot(training_data$weight,abs(mpg_wt1$residuals))
 

#Section 2.6: Scatter plot with regression line for the best linear model (mpg versus weight)

#plotting regression line on training data mpg and weight
plot(training_data$weight,training_data$mpg)
abline(41.43949,-0.006559658,col="red")

#Section 2.6: Testing mpg versus weight model with new observations

#Testing the model with remaining 98 observations
test_data<-auto_mpg_data_modified[301:398,]

#Finding the coefficients of the mpg_weight model
mpg_wt1$coefficients[1]
mpg_wt1$coefficients[2]


#Section 2.6.1: Scatter plot with regression line for the test data set

#plotting regression line on test data mpg and weight
plot(test_data$weight,test_data$mpg)
abline(41.43949,-0.006559658,col=“red"

 
#Section 2.6.2: Important inferences from the Scatter plot

#INFERENCE: Even though the regression line fitted the training data well the same did not fit well for the test data. The same procedure was carried out for displacement model but the test failed as the model failed to fit the test data.

#Section 2.6.3: Predicting mpg using test data set based on model coefficients

#Predicting mpg based on model coefficients from mpg_wt1 model summary
predicted_y <- mpg_wt1$coefficients[1] + mpg_wt1$coefficients[2]*test_data[,4]
model_error <- test_data$mpg - predicted_y

#Section 2.7: Analyzing Model Error: Summary, histogram and other plots

#Analysing the model error
summary(model_error)

 summary(model_error)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 -1.865   3.781   6.493   6.831   9.589  19.001 

hist(model_error)

 
qqnorm(model_error)

plot(test_data$mpg,predicted_y)

#INFERENCE: QQ plot and Histogram of Model Error appear fairly normal. Plot of the actual and predicted values of mpg reveals some amount of under-fitting of actual data points.
Section 2.8: Building Multivariate Linear Models

#Models with combination of independent variables
#using back elimination method to identify significant independent variables
#running a model with all continuous independent variables

#Section 2.8.1: Running a multivariate model with all continuous variables to perform Back Elimination

mpg_disp_hp_wt_acc<-lm(mpg~displacement+horsepower+weight+acceleration,data=training_data)

summary(mpg_disp_hp_wt_acc)

Call:
lm(formula = mpg ~ displacement + horsepower + weight + acceleration, 
    data = training_data)

Residuals:
    Min      1Q  Median      3Q     Max 
-8.4678 -1.9069  0.0155  1.8285 13.8154 

Coefficients:
               Estimate Std. Error t value Pr(>|t|)    
(Intercept)  34.9098699  1.5402824  22.665  < 2e-16 ***
displacement -0.0002134  0.0041066  -0.052    0.959    
horsepower    0.0043540  0.0068172   0.639    0.524    
weight       -0.0058592  0.0004965 -11.801  < 2e-16 ***
acceleration  0.2698822  0.0500112   5.396  1.4e-07 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.003 on 295 degrees of freedom
Multiple R-squared:  0.8065,	Adjusted R-squared:  0.8039 
F-statistic: 307.4 on 4 and 295 DF,  p-value: < 2.2e-16

hist(mpg_disp_hp_wt_acc$residuals)

#INFERENCE: from the summary above we can state that weight and acceleration are the two significant variables
Section 2.8.2: Running multivariate models with three independent variables

#running models with 3 independent variables

mpg_disp_hp_wt<-lm(mpg~displacement+horsepower+weight,data=training_data)
summary(mpg_disp_hp_wt)

mpg_disp_hp_acc<-lm(mpg~displacement+horsepower+acceleration,data=training_data)
summary(mpg_disp_hp_acc)

mpg_hp_wt_acc<-lm(mpg~horsepower+weight+acceleration,data=training_data)
summary(mpg_hp_wt_acc)

mpg_disp_wt_acc<-lm(mpg~displacement+weight+acceleration,data=training_data)
summary(mpg_disp_wt_acc)


#INFERENCE: after analyzing the summaries of above 4 models we decide to use weight and acceleration to yield the best linear model.

#Section 2.8.2: Running multivariate model with two independent variables (Combination of weight and acceleration – Best Predictors)

#running model with two independent variables (weight and acceleration)
mpg_wt_acc<-lm(mpg~weight+acceleration,data=training_data)
summary(mpg_wt_acc)

Call:
lm(formula = mpg ~ weight + acceleration, data = training_data)

Residuals:
    Min      1Q  Median      3Q     Max 
-8.3831 -1.8715  0.0491  1.8379 13.7549 

Coefficients:
               Estimate Std. Error t value Pr(>|t|)    
(Intercept)  35.4473444  1.2684752  27.945  < 2e-16 ***
weight       -0.0059624  0.0002189 -27.240  < 2e-16 ***
acceleration  0.2666597  0.0494071   5.397 1.39e-07 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.995 on 297 degrees of freedom
Multiple R-squared:  0.8062,	Adjusted R-squared:  0.8049 
F-statistic: 617.8 on 2 and 297 DF,  p-value: < 2.2e-16
hist(mpg_wt_acc$residuals,breaks=30,prob=T)
x <- seq(-10,15,length=25)
y <- dnorm(x,mean(mpg_wt_acc$residuals),sd(mpg_wt_acc$residuals))
lines(x,y,col="red")

#Section 2.9: Examination of Residuals of Multivariate Linear Models

Examination of multivariate model residuals poses a challenge as these cannot be analyzed visually when the dimensions are more than three. Let us explore certain approaches to analyze the residuals of the mpg_weight_acceleration model.
Section 2.9.1: Residuals, Fitted values and QQ Plots
Study of Residuals versus Fitted values plot:
plot(mpg_wt_acc)

#Residuals Vs Fitted values plot for mpg_wt_acc model
 

#INFERENCE: Residuals form a curve around mean 0 which is not the ideal case.
Study of QQ Plot of Residuals:

#QQ Plot of residuals for mpg_wt_acc model
 
#INFERENCE: QQ Plot satisfies the ideal condition in most cases except for the three outliers at 112, 245 and 248.


#Section 2.9.2: Plotting residuals with predictor variables
Combined Approach:

#Plotting residuals with predictor variables (combined)
library(rgl)
newdat <- expand.grid(weight=seq(50,5140.00,by=10),acceleration=seq(5,55,by=5))
newdat$mpg1 <- predict(mpg_wt_acc,newdata=newdat)
with(training_data,plot3d(weight,acceleration,mpg, col="blue", size=1, type="s", main="3D Linear Model Fit"))
with(newdat,surface3d(unique(weight),unique(acceleration),mpg1,
                      alpha=0.3,front="line", back="line"))

   
#INFERENCE: From the 3D plot of the linear regression plane, examining the fit we can conclude that even if the plane passes exactly through the middle of the training data, it is difficult to ignore the curved nature of the data points. This violates the underlying assumption of a linear regression model.
Separated Approach:

#Residuals Vs Predictor variables (separate)
plot(training_data$weight,mpg_wt_acc$residuals)
x <- seq(0,5500,length=5500)
y <- dnorm(x,mean(mpg_wt_acc$residuals),sd(mpg_wt_acc$residuals))
lines(x,y,col="red")
plot(training_data$acceleration,mpg_wt_acc$residuals)
x <- seq(0,5500,length=5500)
y <- dnorm(x,mean(mpg_wt_acc$residuals),sd(mpg_wt_acc$residuals))
lines(x,y,col="red")

   

#INFERENCE: Examining the individual predictor variables against the residuals, we can observe that the mean of residuals is 0 which is the ideal case.

#Section 2.9.3: Plotting absolute values of residuals with predictor variables

#absolute value of the residuals vs predictor variables
plot(training_data$weight,abs(mpg_wt_acc$residuals))
plot(training_data$acceleration,abs(mpg_wt_acc$residuals))   
#INFERENCE: Absolute Residuals versus the predictor variables give the unsigned differences (magnitude) in the observed and predicted values of mpg.
Section 2.10: Testing the Multivariate Linear Model with new observations

#Testing the model with remaining 98 observations
test_data<-auto_mpg_data_modified[301:398,]
#Finding the coefficients of the mpg_weight model
mpg_wt_acc$coefficients[1]
mpg_wt_acc$coefficients[2]
mpg_wt_acc$coefficients[3]
Section 2.10.1: Scatter plot with regression plane for the test data set

#plotting regression plane on test data mpg, weight and acceleration
newdat <- expand.grid(weight=seq(50,5140.00,by=10),acceleration=seq(5,55,by=5))
newdat$mpg1 <- predict(mpg_wt_acc,newdata=newdat)
with(test_data,plot3d(weight,acceleration,mpg, col="blue", size=1, type="s", main="3D Linear Model Fit"))
with(newdat,surface3d(unique(weight),unique(acceleration),mpg1,
                      alpha=0.3,front="line", back="line"))

   
#Section 2.10.2: Important inferences from the Scatter plot

#INFERENCE: As with the univariate model case, we can see from the above 3D fit of the regression plane that the model does not work well for the test data. The regression suffers from overfitting the training data. Also, due to the curved nature of the datapoints, the linear regression plane passes beneath the actual data points as the curvature increases in the last 98 observations of the auto_mpg data set.
Section 2.10.3: Predicting mpg based on model coefficients

#Predicting mpg based on model coefficients from mpg_wt_acc model summary
predicted_y <- mpg_wt_acc$coefficients[1] + mpg_wt_acc$coefficients[2]*test_data[,4] + mpg_wt_acc$coefficients[3]*test_data[,5]

#Section 2.11: Analyzing Multivariate Model Error: Summary, histogram and other plots

model_error <- test_data$mpg - predicted_y

#Analysing the model error
summary(model_error)

   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 -1.614   3.117   6.427   6.622   9.305  18.960

hist(model_error,breaks=20)

 
qqnorm(model_error)

 
#INFERENCE: QQ Plot shows that the model error is fairly normal

plot(test_data$mpg,predicted_y)

 
#INFERENCE: Clearly, there is a problem of predicted values under-fitting the actual values of mpg as was evident from the other residual and 3D plots as well.
