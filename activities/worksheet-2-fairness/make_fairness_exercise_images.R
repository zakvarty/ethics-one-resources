# R script to create plots used in confusion matrix questions.
# Author: Zak Varty
# Date created: 2021-09-09
# Date modified: 2021-09-09
#-------------------------------------------------------------------------------

# Question plot 4.3 ------------------------------------------------------------

test_1_fpr <- c(0.059)
test_1_tpr <- c(0.771)

test_2_fpr <- c(0.084)
test_2_tpr <- c(0.57)

test_3_fpr <- c(0.2)
test_3_tpr <- c(0.625)

png(filename = "images/confusion_matrices_q4_pt3_plot.png",
    width = 5,
    height = 5,
    units = "in",
    res = 144,
    bg = NA)
  plot(
    x = c(0,0,1,1),
    y = c(0,1,0,1),
    type = "n",
    xlab = " 1 - specificity",
    ylab = "sensitivity")
  abline(a = 0, b= 1, lty = 2)
  points(x = test_1_fpr, y = test_1_tpr, pch = 15, col = 15)
  legend(
    "bottomright",
    legend = c("test 1", "test 2", "test 3"),
    pch = 15:17,
    col = 15:17,
    bty = "n")
dev.off()

# Solution plot 4.3 ------------------------------------------------------------

test_1_fpr <- c(0.059)
test_1_tpr <- c(0.771)

test_2_fpr <- c(0.084)
test_2_tpr <- c(0.57)

test_3_fpr <- c(0.2)
test_3_tpr <- c(0.625)

png(filename = "images/confusion_matrices_Q4_pt3_solution.png",
    width = 5,
    height = 5,
    units = "in",
    res = 144,
    bg = NA)
  plot(
    x = c(0,0,1,1),
    y = c(0,1,0,1),
    type = "n",
    xlab = " 1 - specificity",
    ylab = "sensitivity")
  abline(a = 0, b= 1, lty = 2)
  points(x = test_1_fpr, y = test_1_tpr, pch = 15, col = 15)
  points(x = test_2_fpr, y = test_2_tpr, pch = 16, col = 16)
  points(x = test_3_fpr, y = test_3_tpr, pch = 17, col = 17)
  legend(
    "bottomright",
    legend = c("test 1", "test 2", "test 3"),
    pch = 15:17,
    col = 15:17,
    bty = "n")
dev.off()

# Question plot 5 --------------------------------------------------------------

test_1_fpr <- c(0,0.02, 0.059,0.32, 1)
test_1_tpr <- c(0, 0.33, 0.771,0.83, 1)

test_2_fpr <- c(0,0.04, 0.084, 0.15, 1)
test_2_tpr <- c(0,0.1, 0.57, 0.91, 1)

test_3_fpr <- c(0,0.1, 0.2,0.66, 1)
test_3_tpr <- c(0,0.51, 0.625,0.7, 1)

png(filename = "images/confusion_matrices_q5_plot.png",
    width = 5,
    height = 5,
    units = "in",
    res = 144,
    bg = NA)
  plot(
    x = c(0,0,1,1),
    y = c(0,1,0,1),
    type = "n",
    xlab = " 1 - specificity",
    ylab = "sensitivity")
  abline(a = 0, b= 1, lty = 2)
  points(x = test_1_fpr, y = test_1_tpr, pch = 15, col = 15)
  lines(x = test_1_fpr, y = test_1_tpr, col = 15, lwd = 1.5)
  points(x = test_2_fpr, y = test_2_tpr, pch = 16, col = 16)
  lines(x = test_2_fpr, y = test_2_tpr, col = 16, lwd = 1.5)
  points(x = test_3_fpr, y = test_3_tpr, pch = 17, col = 17)
  lines(x = test_3_fpr, y = test_3_tpr, col = 17, lwd = 1.5)
  legend(
    "bottomright",
    legend = c("test 1", "test 2", "test 3"),
    pch = 15:17,
    bty = "n",
    col = 15:17)
dev.off()

# Question plot 6 --------------------------------------------------------------

group_a_fpr <- c(0, 0.10, 0.20, 0.80, 1)
group_a_tpr <- c(0, 0.77, 0.93, 0.94, 1)

group_b_fpr <- c(0,0.1,0.3,0.4, 1)
group_b_tpr <- c(0,0.25,0.5,0.72, 1)

group_c_fpr <- c(0,0.08,0.2, 0.6,1)
group_c_tpr <- c(0,0.3, 0.47,0.7, 1)

png(filename = "images/confusion_matrices_q6_plot.png",
    width = 5,
    height = 5,
    units = "in",
    res = 144,
    bg = NA)
  plot(
    x = c(0,0,1,1),
    y = c(0,1,0,1),
    type = "n",
    xlab = " 1 - specificity",
    ylab = "sensitivity",
    main = "test 2 ROC curves")
  abline(a = 0, b= 1, lty = 2)
  points(x = group_a_fpr, y = group_a_tpr, pch = 15, col = 1)
  lines( x = group_a_fpr, y = group_a_tpr, col = 1 , lwd = 1.5)
  points(x = group_b_fpr, y = group_b_tpr, pch = 16, col = 2)
  lines( x = group_b_fpr, y = group_b_tpr, col = 2 , lwd = 1.5)
  points(x = group_c_fpr, y = group_c_tpr, pch = 17, col = 3)
  lines( x = group_c_fpr, y = group_c_tpr, col = 3 , lwd = 1.5)
  legend(
    "bottomright",
    legend = c("group a", "group b", "group c"),
    pch = 15:17,
    bty = "n",
    col = 1:3)
dev.off()

# Question plot 7 --------------------------------------------------------------

group_a_fpr <- c(0, 0.10, 0.20, 0.80, 1)
group_a_tpr <- c(0, 0.77, 0.93, 0.94, 1)

group_b_fpr <- c(0,0.1,0.3,0.4, 1)
group_b_tpr <- c(0,0.25,0.5,0.72, 1)

group_c_fpr <- c(0,0.08,0.2, 0.6,1)
group_c_tpr <- c(0,0.3, 0.47,0.7, 1)

shaded_x <- c(0,0.1,0.3,0.32,0.6,1,0)
shaded_y <- c(0,0.25,0.5,0.54, 0.7,1,0)

png(filename = "images/confusion_matrices_q7_plot.png",
    width = 5,
    height = 5,
    units = "in",
    res = 144,
    bg = NA)
plot(
  x = c(0,0,1,1),
  y = c(0,1,0,1),
  type = "n",
  xlab = " 1 - specificity",
  ylab = "sensitivity",
  main = "test 2 ROC curves")
polygon(x = shaded_x, y = shaded_y, border = NA,col = "grey80")
abline(a = 0, b = 1, lty = 2)
points(x = group_a_fpr, y = group_a_tpr, pch = 15, col = 1)
lines( x = group_a_fpr, y = group_a_tpr, col = 1 , lwd = 1.5)
points(x = group_b_fpr, y = group_b_tpr, pch = 16, col = 2)
lines( x = group_b_fpr, y = group_b_tpr, col = 2 , lwd = 1.5)
points(x = group_c_fpr, y = group_c_tpr, pch = 17, col = 3)
lines( x = group_c_fpr, y = group_c_tpr, col = 3 , lwd = 1.5)
polygon(x = shaded_x, y = shaded_y, border = NA,col = "grey70")
legend(
  "bottomright",
  legend = c("group a", "group b", "group c"),
  pch = 15:17,
  bty = "n",
  col = 1:3)
dev.off()
