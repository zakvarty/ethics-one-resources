dat <- readr::read_csv("./checkpoint_2_data/loan_outcomes_10.csv")
head(dat)


TP <- sum(dat$repaid & dat$curr_test)
FN <- sum(dat$repaid & !dat$curr_test)
FP <- sum(!dat$repaid & dat$curr_test)
TN <- sum(!dat$repaid & !dat$curr_test)

matrix(c(TP, FN, FP, TN), nrow = 2, byrow = 2)


TPR <- TP / (TP + FN)
TPR

FPR <- FP / (FP + TN)
FPR
