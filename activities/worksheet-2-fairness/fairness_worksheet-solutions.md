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


[Let $k = \sum_{i=1} D_1,i$ be the number of positive diagnoses made by test 1 and $\mathbb{I\{A\}}$ be an indicator of event $A$.]{color="blue"} 

[1. The true positive rate of test 1 is the probability of a person with Coeliac disease receiving a positive test result from test 1.]{color="blue"}

[$$ \text{TPR} = \Pr(D = 1 | Y = 1) \approx \frac{\sum_{i=1}^n \mathbb{I}\{ D_{1,i} = 1 \ \& \ Y_i = 1\}}{\sum_{i=1}^n \mathbb{I}\{Y_i = 1\}}.$$]{color="blue"}

[2. The false positive rate of test 1 is the probability of a person without Coeliac disease receiving a positive test result from test 1.]{color="blue"} 

[$$ \text{FPR} = \Pr(D = 1 | Y = 0) \approx \frac{\sum_{i=1}^n \mathbb{I}\{ D_{1,i} = 1 \ \& \ Y_i = 0\}}{\sum_{i=1}^n \mathbb{I}\{Y_i = 0\}}.$$]{color="blue"}

[3. The true negative rate of test 1 is the probability of a person without Coeliac disease receiving a negative test result from test 1.]{color="blue"} 

[$$ \text{TNR} = \Pr(D = 0 | Y = 0) \approx \frac{\sum_{i=1}^n \mathbb{I}\{ D_{1,i} = 0 \ \& \ Y_i = 0\}}{\sum_{i=1}^n \mathbb{I}\{Y_i = 0\}}.$$]{color="blue"}

[4. The false negative rate of test 1 is the probability of a person with Coeliac disease receiving a negative test result from test 1.]{color="blue"}

[$$ \text{FNR} = \Pr(D = 0 | Y = 1) \approx \frac{\sum_{i=1}^n \mathbb{I}\{ D_{1,i} = 0 \ \& \ Y_i = 1\}}{\sum_{i=1}^n \mathbb{I}\{Y_i = 1\}}.$$]{color="blue"}

--------------------------------------------------------------

__Q2: How do the positive predictive value and negative predictive value relate to the rates defined in Q1?__

[The positive predictive value is the the proportion of people who have a positive test result that have truly got Coeliac disease:]{color="blue"}

[$$ \text{PPV} = \Pr(D = 1 | Y = 1) \approx \frac{\sum_{i=1}^n \mathbb{I}\{ D_{1,i}  = 1\ \& \ Y_i = 1\}}{\sum_{i=1}^n \mathbb{I}\{Y_i = 1\}}. $$]{color="blue"}

[The negative predictive value is the the proportion of people who have a negative test result that truly have not got Coeliac disease:]{color="blue"} 

[$$ \text{NPV} = \Pr(D = 0 | Y = 0) \approx \frac{\sum_{i=1}^n \mathbb{I}\{ D_{1,i} = 0\ \& \ Y_i = 0\}}{\sum_{i=1}^n \mathbb{I}\{Y_i = 0\}}.$$]{color="blue"}

[The positive and negative predictive values are complementary measures to the TPR and TNR, where the order of conditioning has been reversed.]{color="blue"}

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

[Using notation as defined previously: ]{color="blue"}

[$$ \text{TPR}_1 = \frac{\sum_{i=1}^n \mathbb{I}\{ D_{1,i} = 1 \ \& \ Y_i = 1\}}{\sum_{i=1}^n \mathbb{I}\{Y_i = 1\}} = \frac{81}{105} \approx 77.1\% .$$]{color="blue"} 


[$$ \text{FPR}_1 = \frac{\sum_{i=1}^n \mathbb{I}\{ D_{1,i} = 1 \ \& \ Y_i = 0\}}{\sum_{i=1}^n \mathbb{I}\{Y_i = 0\}} = \frac{24}{406} \approx 5.9\% .$$]{color="blue"}


[$$ \text{TNR}_2 = \frac{\sum_{i=1}^n \mathbb{I}\{ D_{1,i} = 0 \ \& \ Y_i = 0\}}{\sum_{i=1}^n \mathbb{I}\{Y_i = 0\}} = \frac{382}{406} \approx 94.1\% .$$]{color="blue"} 

[$$ \text{FNR}_2 = \frac{\sum_{i=1}^n \mathbb{I}\{ D_{1,i} = 0 \ \& \ Y_i = 1\}}{\sum_{i=1}^n \mathbb{I}\{Y_i = 1\}} = \frac{24}{105} \approx 22.9\% .$$]{color="blue"} 

2. __Calculate and state the TPR, FPR, TNR, and FNR for tests 2 and 3.__

[ By similar calculations we find that for test 2:]{color="blue"}

[$$\text{TPR}_2 \approx 57.0 \%, \  \text{FPR}_2 \approx 8.4\%, \ \text{TNR}_2 \approx 91.6\%, \ \text{FNR}_2 \approx 43.0\%. $$]{color="blue"}

[And for test 3: ]{color="blue"}

[$$\text{TPR}_3 = 62.5 \%, \  \text{FPR}_3 \approx 20.0\%, \ \text{TNR}_3 \approx 80.0\%, \ \text{FNR}_3 = 37.5\%. $$]{color="blue"}

3. __Is it important that the same group of people took each of the three tests? Why or why not?__ 

[ The test rates calculated in (3.2) use sample proportions to estimate population probabilities that we are truly interested in. If a different group of people (sample from the population) were used for each test then differences in test rates may be attributable to either differences between the sampled groups or between the tests themselves. To control for this confounding effect, the same group should be used for each test.]{color="blue"} 

[(NB: Using sampled groups with the same proportions would also be effective but would not control for differences in unmeasured factors such as sex and age which might impact test performance)]{color="blue"}

4. __Calculate the sensitivity and specificity for each of these tests.__ 

[ Sensitivity and specificity are alternative names for the true positive rate (TPR) and true negative rate (TNR) that are often used when referring to binary classification problems in a medical setting. Therefore we have already calculated these in (Q3.2).]{color="blue"}

--------------------------------------------------------------

__Q4: The receiver operating characteristic for a test plots the sensitivity of the test against 1 - specificity. This pair can be used to compare different tests for the same binary outcome.  The ROC for test 1 is shown in Figure 1 below.__

![ROC plot for test 1](images/confusion_matrices_q4_pt3_plot.png "ROC plot for test 1")

1. __Which region of the ROC plot corresponds to a near-optimal classifier?__ 

[Note that $1 - \text{specificity} = 1 - \text{TPR} = \text{FPR}$, and $\text{sensitivity} = TPR$. A near-optimal classifier will have a high TPR and a low FPR. This corresponds to a ROC value close to (1,0), i.e. in the upper left corner of the ROC plot.]{color="blue"} 

2. __What does it mean for a classifier to have an ROC on/above/below the line $y=x$?__ 

[A classifier on the line $y = x$ has the same diagnostic ability as guessing randomly whether an individual has Coeliacs disease. A classifier above the line has better diagnostic ability than randomly guessing, while a classifier below the line performs worse than guessing randomly.]{color="blue"}

[Note that a classifier that is worse than randomly guessing must be able to discriminate between the two groups, but is getting them the wrong way around. This means that it could be improved by simply reversing the diagnosis of each individual! ]{color="blue"}

3. __Add the ROC for tests 2 and 3 to this plot.__ 

[See Figure 2.]{color="blue"}

![ROC plot for tests 1, 2 and 3](images/confusion_matrices_Q4_pt3_solution.png "ROC plot for tests 1, 2 and 3")


4. __Which, if any, of the tests would you recommend that the company develops further.__

[All three tests have some predictive power (and are therefore better than guessing at random). Based on these results, test 1 gives the best predictive performance and would be the most promising for further development. ]{color="blue"}

--------------------------------------------------------------

__Q5: By altering the concentration of an enzyme in the tests, the pharmaceutical company can change the threshold at which each test gives a positive diagnosis. The ROC curve for a test interpolates ROC values for each test at a range of enzyme concentrations. The ROC curves for tests 1,2, and 3 are shown in Figure 3.__ 

![ROC curves for tests 1, 2 and 3](images/confusion_matrices_q5_plot.png "ROC curves for tests 1, 2 and 3")

__When enzyme levels are optimised for predictive performance, which test has the best results? Does this change your earlier recommendation?__  

[By appropriately selecting the enzyme concentration used in each test, test number 2 can be made to have greater diagnostic ability than test 1. 

Based on prediction considerations alone, this suggests that we should take test 2 forward for further development. However, this improved prediction might be out-weighed by other considerations such as the additional cost or supply problems if more enzyme is required per test.]{color="blue"}

--------------------------------------------------------------

__Q6. The company decides to further develop test 2, having considered the cost, logistics and predictive performance of all three tests. A follow-up study is used to establish the effects of age on test outcomes. Three age groups are considered: group "a" represents people under 18, group "b" represents people 18-65 years old, and group "c" those over 65. The ROC curves for test 2 are shown for people in age-groups "a", "b" and "c" in Figure 4.__ 

![Sub-group specific ROC curves for test 2](images/confusion_matrices_q6_plot.png "Sub-group specific ROC curves for test 2")



1. __Interpret the ROC curves shown. You should use plain language suitable for an executive summary to the directors of the pharmaceutical company.__ 

[At any enzyme concentration, test 2 provides the best diagnostic results to group a, the people under 18.]{color="blue"}

[We might therefore pick the enzyme concentration to optimise the diagnostic ability of the test for either children or working age adults. Alternatively, enzyme concentration can be selected to satisfy a given trade-off between the diagnostic ability in these two groups.]{color="blue"}  

--------------------------------------------------------------

__Q7. The fairness condition of error-parity ensures that the false positive rates and the false negative rates of a test are equal for all sub-groups of a protected characteristic, such as age.__ 

1. __Shade the area of the ROC plot in which tests satisfying the error-parity fairness condition will be located. Explain why this is the case. __ 

[See Figure 5.]{color="blue"}

![Sub-group specific ROC curves for test 2 with equal error region shaded](images/confusion_matrices_q7_plot.png "Sub-group specific ROC curves for test 2  with equal error region shaded")


[A test should not have a FPR > TPR, or else it is worse than random guessing and could be improved by switching all diagnoses.]{color="blue"} 

[If a test satisfies error parity then the false positive rate (and therefore the true positive rate) in each protected sub-group must be equal. This means the the combined false positive rate must be at least as large as in the worst-classified subgroup, or equivalently the true positive rate must be at least as low as in the worst-classified sub-group.]{color="blue"} 

[Therefore tests satisfying error parity fall between the line $y=x$ and point-wise minimum of the sub-group specific ROC curves.]{color="blue"}

2. __What does this imply about the relative predictive performance of classifiers with and without an error-parity condition?__

[A sub-group specific test is at least as good at diagnosing individuals within that sub-group as a combined test with error parity. By requiring equal error rates in all sub-groups we may be degrading diagnostic performance in one or more subgroups.]{color="blue"}
