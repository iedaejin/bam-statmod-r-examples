# Session 28 — Cox proportional hazards model
# Prof. Dae-Jin Lee (daelee@faculty.ie.edu) --- Statistical Modelling (BAM), IE University
# Plain-script version of 28-cox-model.Rmd. Run: Rscript 28-cox-model.R

## ----data---------------------------------------------------------------------
library(survival)
vet <- survival::veteran
vet$trt <- factor(vet$trt, levels = 1:2, labels = c("standard", "test"))


## ----toy----------------------------------------------------------------------
toy <- data.frame(time = c(2, 3, 4, 6, 8), status = c(1, 0, 1, 1, 1), x = c(1, 0, 0, 1, 0))
lp <- function(b) 2 * b - log(2 * exp(b) + 3) - log(exp(b) + 2) - log(exp(b) + 1)
score <- function(b) 2 - 2 * exp(b) / (2 * exp(b) + 3) - exp(b) / (exp(b) + 2) - exp(b) / (exp(b) + 1)
info <- function(b) {
  p <- c(2 * exp(b) / (2 * exp(b) + 3), exp(b) / (exp(b) + 2), exp(b) / (exp(b) + 1))
  sum(p * (1 - p))          # variance of x within each risk set
}
b <- 0
for (it in 1:5) b <- b + score(b) / info(b)   # Newton-Raphson
c(beta = b, se = 1 / sqrt(info(b)), HR = exp(b))
coef(coxph(Surv(time, status) ~ x, data = toy))


## ----cox----------------------------------------------------------------------
fit <- coxph(Surv(time, status) ~ trt + karno + celltype + age, data = vet)
summary(fit)


## ----hr-----------------------------------------------------------------------
round(cbind(HR = exp(coef(fit)), exp(confint(fit))), 3)
exp(10 * coef(fit)["karno"])            # 0.72
exp(10 * confint(fit)["karno", ])       # (0.65, 0.80)


## ----lrt----------------------------------------------------------------------
fit0 <- coxph(Surv(time, status) ~ trt + karno + age, data = vet)
anova(fit0, fit)                       # does cell type add to the model?


## ----ties---------------------------------------------------------------------
fit_b <- update(fit, ties = "breslow")
round(cbind(efron = coef(fit), breslow = coef(fit_b)), 4)


## ----score--------------------------------------------------------------------
f1 <- coxph(Surv(time, status) ~ trt, data = vet)
summary(f1)$sctest
survdiff(Surv(time, status) ~ trt, data = vet)$chisq


## ----pred, fig.width = 7, fig.height = 4.5------------------------------------
nd <- data.frame(trt = "standard", karno = c(40, 80), celltype = "squamous", age = 60)
sf <- survfit(fit, newdata = nd)
plot(sf, col = c("firebrick", "navy"), lwd = 2, xlab = "Days", ylab = "Predicted S(t)")
legend("topright", c("karno = 40", "karno = 80"), col = c("firebrick", "navy"), lwd = 2, bty = "n")

