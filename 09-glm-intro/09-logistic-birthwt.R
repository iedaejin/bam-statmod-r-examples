# Session 9 — Logistic regression: low birth weight
# Statistical Modelling (BAM), IE University
# Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Same code as 09-logistic-birthwt.Rmd. Run from this folder.

# ---- data ----
library(MASS)
bw <- with(birthwt, data.frame(
  low   = low,
  age   = age,
  lwt   = lwt,                                   # mother's weight (lb)
  race  = factor(race, labels = c("white", "black", "other")),
  smoke = smoke,
  ptd   = as.integer(ptl > 0),                   # previous premature labour
  ht    = ht,                                    # hypertension
  ui    = ui                                     # uterine irritability
))
table(bw$low)

# ---- lpm ----
lpm <- lm(low ~ age + lwt + race + smoke + ptd + ht + ui, data = bw)
range(fitted(lpm))          # some "probabilities" are negative
sum(fitted(lpm) < 0)

# ---- fit ----
fit <- glm(low ~ age + lwt + race + smoke + ptd + ht + ui,
           family = binomial, data = bw)
summary(fit)

# ---- or ----
# confint() on a glm profiles the likelihood (it does not use +/- 1.96 se)
round(exp(cbind(OR = coef(fit), confint(fit))), 3)

# ---- predict ----
nd <- data.frame(age = 25, lwt = 120, race = "white", smoke = c(0, 1),
                 ptd = 0, ht = 0, ui = 0)
eta <- predict(fit, nd, type = "link")
p   <- predict(fit, nd, type = "response")
cbind(eta, p, check = plogis(eta))
# Slope of the probability in a covariate: beta * p (1 - p) <= beta / 4
coef(fit)["lwt"] * p[1] * (1 - p[1])   # change in P(low) per extra lb, non-smoker
coef(fit)["lwt"] / 4                   # the upper bound

# ---- curve ----
grid <- expand.grid(age = 25, lwt = 80:250, race = "white", smoke = 0:1,
                    ptd = 0, ht = 0, ui = 0)
grid$p <- predict(fit, grid, type = "response")
plot(p ~ lwt, data = subset(grid, smoke == 0), type = "l", lwd = 2,
     ylim = c(0, 0.6), xlab = "Mother's weight (lb)", ylab = "P(low)")
lines(p ~ lwt, data = subset(grid, smoke == 1), lwd = 2, lty = 2)
legend("topright", c("non-smoker", "smoker"), lty = 1:2, lwd = 2, bty = "n")

