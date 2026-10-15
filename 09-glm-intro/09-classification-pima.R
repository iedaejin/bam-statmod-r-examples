# Session 9 — From probabilities to decisions
# Statistical Modelling (BAM), IE University
# Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Same code as 09-classification-pima.Rmd. Run from this folder.

# ---- fit ----
library(MASS)
fit <- glm(type ~ npreg + glu + bmi + ped + age, family = binomial, data = Pima.tr)
round(summary(fit)$coefficients, 4)
p_tr <- fitted(fit);                               y_tr <- Pima.tr$type == "Yes"
p_te <- predict(fit, Pima.te, type = "response");  y_te <- Pima.te$type == "Yes"

# ---- rates ----
rates <- function(p, y, cut) {
  yhat <- p >= cut
  c(sens = mean(yhat[y]), spec = mean(!yhat[!y]), acc = mean(yhat == y))
}
rates(p_te, y_te, 0.5)

# ---- threshold ----
cuts <- seq(0.05, 0.95, by = 0.01)
youden <- function(p, y) sapply(cuts, function(k) sum(rates(p, y, k)[1:2]) - 1)
c_train <- cuts[which.max(youden(p_tr, y_tr))]   # legitimate choice
c_test  <- cuts[which.max(youden(p_te, y_te))]   # leakage: uses the test labels
c(c_train = c_train, c_test = c_test)
rbind(chosen_on_train = rates(p_te, y_te, c_train),
      chosen_on_test  = rates(p_te, y_te, c_test))

# ---- cost ----
C_FP <- 1; C_FN <- 3
c_star <- C_FP / (C_FP + C_FN)
c_star
rates(p_te, y_te, c_star)

# ---- roc ----
roc_xy <- function(p, y) t(sapply(cuts, function(k) {
  r <- rates(p, y, k); c(fpr = 1 - r[["spec"]], tpr = r[["sens"]]) }))
plot(roc_xy(p_tr, y_tr), type = "l", lwd = 2, xlim = c(0, 1), ylim = c(0, 1),
     xlab = "1 - specificity", ylab = "sensitivity")
lines(roc_xy(p_te, y_te), lwd = 2, lty = 2)
abline(0, 1, col = "grey")
legend("bottomright", c("training", "test"), lty = 1:2, lwd = 2, bty = "n")
# AUC = P(score of a random case > score of a random control)
auc <- function(p, y) mean(outer(p[y], p[!y], ">") + 0.5 * outer(p[y], p[!y], "=="))
c(train = auc(p_tr, y_tr), test = auc(p_te, y_te))

