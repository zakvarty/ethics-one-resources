# set.seed(5432) - 2021 assessment
set.seed(6543) # - 2022 checkpoint 2
source("./00_checkpoint_2_helpers.R")

# 1: Make Individual data sets -------------------------------------------------
bank_data <- vector(mode = "list", length = 50)

# make and save data sets for all students
for (i in seq_along(bank_data)) {

  bank_data[[i]] <- generate_bank_data()
  csv_path <- paste0("./checkpoint-2-data/loan_outcomes_",i,".csv")
  write.csv(x = bank_data[[i]], file = csv_path)

}

# save all data sets as a single object for easy marking
saveRDS(bank_data, file = "./checkpoint-2-data/bank_data.RDS")

# save all solutions as a separate text file.
for (i in 1:50){
  txt_path <- paste0(
    "confusion-matrix-solutions/confusion_matrix_solutions_",
    i,
    ".txt")
  sink(txt_path)
  print_solutions(i)
  sink()
}


