# Session 11 — A toolkit for binary GLMs
# Statistical Modelling (BAM), IE University
# Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Same code as 11-binary-toolkit.Rmd. Run from this folder.

# ---- fit ----
library(MASS)
fit <- glm(type ~ npreg + glu + bp + bmi + ped + age, family = binomial, data = Pima.tr)
round(exp(cbind(OR = coef(fit), confint(fit))), 3)
# Odds ratio for 10 units of glucose, with its profile interval
exp(10 * c(estimate = coef(fit)[["glu"]], confint(fit)["glu", ]))

# ---- lrt ----
fit_small <- update(fit, . ~ . - npreg - bp - age)
anova(fit_small, fit, test = "Chisq")
LR <- deviance(fit_small) - deviance(fit)
c(LR = LR, p = pchisq(LR, df.residual(fit_small) - df.residual(fit), lower.tail = FALSE))

# ---- rates ----
rates <- function(p, y, cut) {
  yhat <- as.integer(p >= cut)
  c(sens = mean(yhat[y == 1] == 1), spec = mean(yhat[y == 0] == 0),
    acc = mean(yhat == y))
}
total_cost <- function(p, y, cut, C_FP = 1, C_FN = 3) {
  yhat <- as.integer(p >= cut)
  C_FP * sum(yhat == 1 & y == 0) + C_FN * sum(yhat == 0 & y == 1)
}
y_tr <- as.integer(Pima.tr$type == "Yes"); p_tr <- fitted(fit)
y_te <- as.integer(Pima.te$type == "Yes"); p_te <- predict(fit, Pima.te, type = "response")

# ---- choose ----
cuts <- seq(0.05, 0.95, by = 0.01)
J <- sapply(cuts, function(k) sum(rates(p_tr, y_tr, k)[1:2]) - 1)
c_youden <- cuts[which.max(J)]
c_star <- 1 / (1 + 3)                       # C_FN = 3 C_FP, calibrated probabilities
c(c_youden = c_youden, c_star = c_star)
rates(p_tr, y_tr, c_youden)                 # optimistic: chosen on these data

# ---- evaluate ----
rbind(half   = rates(p_te, y_te, 0.5),
      youden = rates(p_te, y_te, c_youden),
      cost   = rates(p_te, y_te, c_star))
sapply(c(half = 0.5, youden = c_youden, cost = c_star),
       function(k) total_cost(p_te, y_te, k))
table(predicted = as.integer(p_te >= c_star), observed = y_te)

# ---- calibration ----
bins <- cut(p_te, breaks = c(0, 0.1, 0.25, 0.5, 0.75, 1))
data.frame(n = as.vector(table(bins)),
           mean_pred = round(tapply(p_te, bins, mean), 3),
           observed  = round(tapply(y_te, bins, mean), 3))

