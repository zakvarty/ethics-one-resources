

generate_bank_data <- function(){
  # Generate training data size
  n <- sample(x = 500:1000, size = 1)

  # Generate training sexes
  is_male <- rbinom(n, size = 1, prob = 0.48)

  # Generate loan repayment outcomes - 30% men and 10% women default
  repaid <- rbinom(n, 1, prob = 0.7 * is_male + 0.9 * !is_male)

  # Current test treats sexes equally but is worse than new test 1
  # New test 1 treats sexes equally and predicts better than current
  # New test 2 predicts better than current, but predicts women worse
  curr_test  <- rbinom(n = n, size = 1, prob = 0.8 * repaid + 0.10 * !repaid)
  new_test_1 <- rbinom(n = n, size = 1, prob = 0.9 * repaid + 0.05 * !repaid)
  probs_curr <- 0.8 * repaid + 0.1 * !repaid
  probs_new_1 <- 0.9 * repaid + 0.1 * !repaid
  probs_new_2 <- 0.97 * ( is_male &  repaid) + # men who repaid
    0.83 * (!is_male &  repaid) + # women who repaid
    0.02 * ( is_male & !repaid) + # men who defaulted
    0.08 * (!is_male & !repaid)  # women who defaulted

  curr_test <- rbinom(n = n , size = 1, prob = probs_curr)
  new_test_1 <- rbinom(n = n, size = 1, prob = probs_new_1)
  new_test_2 <- rbinom(n = n, size = 1, prob = probs_new_2)

  #mean(curr_test & repaid)
  #mean(new_test_1 & repaid)
  #mean(new_test_2 & repaid)

  test_data <- data.frame(id = 1:n, is_male, repaid, curr_test, new_test_1, new_test_2)
  return(test_data)
}


print_confusion_matrices <- function(df){
  CM0 <- data.frame(
    test_pos = c(sum(df$curr_test & df$repaid) , sum(df$curr_test & !df$repaid)),
    test_neg = c(sum(!df$curr_test & df$repaid), sum(!df$curr_test & !df$repaid))
  )

  CM1 <- data.frame(
    test_pos = c(sum(df$new_test_1 & df$repaid) , sum(df$new_test_1 & !df$repaid)),
    test_neg = c(sum(!df$new_test_1 & df$repaid), sum(!df$new_test_1 & !df$repaid))
  )

  CM2 <- data.frame(
    test_pos = c(sum(df$new_test_2 & df$repaid) , sum(df$new_test_2 & !df$repaid)),
    test_neg = c(sum(!df$new_test_2 & df$repaid), sum(!df$new_test_2 & !df$repaid))
  )

  rownames(CM0) <- c("repaid", "defaulted")
  rownames(CM1) <- c("repaid", "defaulted")
  rownames(CM2) <- c("repaid", "defaulted")

  cat("Current Test \n")
  print(CM0)
  cat("\n")

  cat("New Test 1 \n")
  print(CM1)
  cat("\n")

  cat("New Test 2 \n")
  print(CM2)
  cat("\n")
}

print_TPRs_and_FPRs <- function(df){
  # TPR = TP / P = (predicted to repay and did / did repay)
  TPR0 <- sum(df$curr_test & df$repaid)  / sum(df$repaid)
  TPR1 <- sum(df$new_test_1 & df$repaid) / sum(df$repaid)
  TPR2 <- sum(df$new_test_2 & df$repaid) / sum(df$repaid)

  # FPR = FP / N = (predicted to repay and didn't / didn't repay)
  FPR0 <- sum(df$curr_test & !df$repaid) / sum(!df$repaid)
  FPR1 <- sum(df$new_test_1 & !df$repaid) / sum(!df$repaid)
  FPR2 <- sum(df$new_test_2 & !df$repaid) / sum(!df$repaid)

  TPRs <- c(TPR0, TPR1, TPR2)
  FPRs <- c(FPR0, FPR1, FPR2)
  distances <- sqrt((TPRs - 1)^2 + (FPRs - 0)^2)

  out <- data.frame(test = 0:2, TPR = TPRs, FPR = FPRs, distance = distances)
  print(out)
  #cat("Test: \t 0  \t 1  \t  2 \n")
  #cat("TPRs:", round(TPRs, 4), "\n")
  #cat("FPRs:", round(FPRs, 4), "\n \n")
  #cat("distances from (0,1):", distances, "\n")
  cat("\n Preferred test is", which.min(distances) - 1, "(assuming equal treatment of type 1 and 2 errors).")
  invisible(out)
}


print_TPRs_and_FPRs_by_sex <- function(df){

  df_m <- df[df$is_male == 1,]
  df_f <- df[df$is_male == 0,]

  cat('TEST PERFORMANCE ON MALES: \n')
  print_TPRs_and_FPRs(df_m)
  cat("\n ------------------------------------ \n")

  cat('TEST PERFORMANCE ON NON-MALES: \n')
  print_TPRs_and_FPRs(df_f)
  cat("\n ------------------------------------ \n")
}

print_error_rates_by_sex <- function(df){
  df_m <- df[df$is_male == 1,]
  df_f <- df[df$is_male == 0,]

  test_0_male_errors <- mean(df_m$curr_test != df_m$repaid)
  test_0_female_errors <- mean(df_f$curr_test != df_f$repaid)

  test_1_male_errors <- mean(df_m$new_test_1 != df_m$repaid)
  test_1_female_errors <- mean(df_f$new_test_1 != df_f$repaid)

  test_2_male_errors <- mean(df_m$new_test_2 != df_m$repaid)
  test_2_female_errors <- mean(df_f$new_test_2 != df_f$repaid)

  test = c(0,1,2)
  male_error_rate <- c(test_0_male_errors, test_1_male_errors, test_2_male_errors)
  female_error_rate <- c(test_0_female_errors, test_1_female_errors, test_2_female_errors)
  relative_error_rate <-  female_error_rate / male_error_rate

  print(data.frame(test, male_error_rate, female_error_rate, relative_error_rate))
}

print_solutions <- function(ID, all_data = bank_data){

  cat("PART A: CONFUSION MATRICES ----------------------------------------------\n\n")
  print_confusion_matrices(all_data[[ID]])

  cat("PART B: TPRs and FPRs -------------------------------------------------\n\n")
  print_TPRs_and_FPRs(all_data[[ID]])

  cat("\n \n")

  cat("PART C: TPRs and FPRs by sex-------------------------------------------\n\n")
  print_TPRs_and_FPRs_by_sex(all_data[[ID]])

  cat("\n")
  cat("PART D: Fairness metrics ----------------------------------------------\n\n")

  cat("
      _Error parity:_ Males and non-males should be mis-classified with the same \n\t
      probability/proportion. Mis-classification occurs here when someone would \n\t
      have repaid a loan they were not given or else failed to repay a loan that \n\t
      they were given. \n\n")
  cat("\t [ ] Definition \n\t [ ] Context\n \n\n")

  cat("
      _Equalised odds:_ The probability of correctly accepting or rejecting the \n
      loan application should be the same, regardless of gender.  \n\n\t
      \t This requires BOTH of the following: \n\t
      \t Pr(Accepted | repaid & male) = Pr(Accepted | repaid & not male) \n\t
      \t\t\t AND \n
      \t Pr(Rejected | defaulted & male) = Pr(Rejected | defaulted & not male).
     \n\n")
  cat("\t [ ] Definition \n\t [ ] Context\n \n\n")

  cat("
      _Equalised opportunity:_ This is a weaker version of equalised odds. \n\t
      The probability of correctly accepting loan application should be the same \n\t
      for those who will repay the loan, regardless of gender. This requires ONLY: \n\t
      \t Pr(Accepted | repaid & male) = Pr(Accepted | repaid & not male). \n")
  cat("\t [ ] Definition \n\t [ ] Context\n \n\n")



  cat("PART E: Error rates by sex --------------------------------------------\n\n")
  print_error_rates_by_sex(all_data[[ID]])

  cat("
  [ ] Tests 0 and 1 appear to satisfy error parity since relative error rate approx 1. \n
  [ ] Test 2 has a much higher error rate for people who are not male. \n
  [ ] Formally, we should use a hypothesis test to account for sampling variability \n \t in the proportion of misclassified individuals.")

  cat("\n\n EOF ---")
  invisible(NULL)
}
