---
title: MATH70098 Ethics in Data Science and AI
subtitle: Exercise Sheet - Fairness 
#author: Zak Varty
date: Autumn 2021
output: 
  pdf_document:
    pandoc_args: ["--lua-filter=color-text.lua"]
  html_document:
    pandoc_args: ["--lua-filter=color-text.lua"]
---
# Exercise sheet: Fairness

The questions on this sheet are designed to let you test your own understanding of the course content on fairness. Some questions will test basic notions, while others will encourage you to think more deeply about some of the concepts introduced this week. 

--------------------------------------------------------------

A pharmaceutical company has developed three new tests to screen patients for Coeliac disease (a condition where your immune system attacks your own tissues when you eat gluten), which are rapid and cost-effective. Receiving a diagnosis of Coeliac disease usually requires multiple visits to a general practitioner or specialist. This leads to long delay times between the first appointment and diagnosis. It is hoped that this delay can be reduced by the new tests, if they are effective.

Each of the three tests were administered to $n$ people of whom $m$ had been diagnosed and $n-m$ had no negative reactions to consuming gluten. For each individual $i = 1,\ldots,n$ and each test $j=1,2,3$, let:

- $Y_i$ be an indicator that  individual $i$ has Coeliac disease;
- $D_{j,i}$ be an indicator that test $j$ returns a positive diagnosis for individual $i$;
- $A_{i}$ be a random variable denoting whether individual $i$ belongs to subgroup "a" (children under 18), "b" (adults over 18 but under 65), or "c" (adults over 65). 

--------------------------------------------------------------

__Q1: Using the notation introduced previously for test 1, define and interpret in plain language:__ 

1.  __The true positive rate (TPR) of the test__ 
2.  __The false positive rate (FPR) of the test__
3.  __The true negative rate (TNR) of the test__
4.  __The false negative rate (FNR) of the test__

--------------------------------------------------------------

__Q2: How do the Positive predictive value and negative predictive value relate to the rates defined in Q1?__

--------------------------------------------------------------

__Q3: The confusion matrices for the three tests are given below.__ 

| _Test 1_ 	| D = 1 	| D = 0 	|
|----------	|-------	|-------	|
| Y = 1    	| 81    	| 24    	|
| Y = 0    	| 24    	| 382   	|

| _Test 2_ 	| D = 1 	| D = 0 	|
|----------	|-------	|-------	|
| Y = 1    	| 73    	| 55    	|
| Y = 0    	| 32    	| 351   	|


| _Test 3_ 	| D = 1 	| D = 0 	|
|----------	|-------	|-------	|
| Y = 1    	| 5     	| 3     	|
| Y = 0    	| 100    	| 403   	|


1. __Calculate the TPR, FPR, TNR and FNR for test 1, showing your working clearly.__ 

2. __Calculate and state the TPR, FPR, TNR, and FNR for tests 2 and 3.__

3. __Is it important that the same group of people took each of the three tests? Why or why not?__ 

4. __Calculate the sensitivity and specificity for each of these tests.__ 

--------------------------------------------------------------

__Q4: The receiver operating characteristic for a test plots the sensitivity of the test against 1 - specificity. This pair can be used to compare different tests for the same binary outcome.  The ROC for test 1 is shown in Figure 1 below.__

![ROC plot for test 1](images/confusion_matrices_q4_pt3_plot.png "ROC plot for test 1")

1. __Which region of the ROC plot corresponds to a near-optimal classifier?__ 

2. __What does it mean for a classifier to have an ROC on/above/below the line $y=x$?__ 

3. __Add the ROC for tests 2 and 3 to this plot.__ 

4. __Which, if any, of the tests would you recommend that the company develops further.__

--------------------------------------------------------------

__Q5: By altering the concentration of an enzyme in the tests, the pharmaceutical company can change the threshold at which each test gives a positive diagnosis. The ROC curve for a test interpolates ROC values for each test at a range of enzyme concentrations. The ROC curves for tests 1,2, and 3 are shown in Figure 2.__ 

![ROC curves for tests 1, 2 and 3](images/confusion_matrices_q5_plot.png "ROC curves for tests 1, 2 and 3")

__When enzyme levels are optimised for predictive performance, which test has the best results? Does this change your earlier recommendation?__  

--------------------------------------------------------------

__Q6. The company decides to further develop test 2, having considered the cost, logistics and predictive performance of all three tests. A follow-up study is used to establish the effects of age on test outcomes. Three age groups are considered: group "a" represents people under 18, group "b" represents people 18-65 years old, and group "c" those over 65. The ROC curves for test 2 are shown for people in age-groups "a", "b" and "c" in Figure 3.__ 

![Sub-group specific ROC curves for test 2](images/confusion_matrices_q6_plot.png "Sub-group specific ROC curves for test 2")



1. __Interpret the ROC curves shown. You should use plain language suitable for an executive summary to the directors of the pharmaceutical company.__ 


--------------------------------------------------------------

__Q7. The fairness condition of error-parity ensures that the false positive rates and the false negative rates of a test are equal for all sub-groups of a protected characteristic, such as age.__ 

1. __Shade the area of the ROC plot in which tests satisfying the error-parity fairness condition will be located. Explain why this is the case. __ 

2. __What does this imply about the relative predictive performance of classifiers with and without an error-parity condition?__

