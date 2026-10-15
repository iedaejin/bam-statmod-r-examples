# Session 28 — Likelihood with right censoring: the exponential model
# Prof. Dae-Jin Lee (daelee@faculty.ie.edu) --- Statistical Modelling (BAM), IE University
# Plain-script version of 28-exponential-likelihood.Rmd. Run: Rscript 28-exponential-likelihood.R

## ----data---------------------------------------------------------------------
library(survival)
vet <- survival::veteran
vet$trt <- factor(vet$trt, levels = 1:2, labels = c("standard", "test"))


## ----closed-form--------------------------------------------------------------
d   <- sum(vet$status)          # 128 deaths
tot <- sum(vet$time)            # 16663 person-days at risk
lam <- d / tot
se  <- lam / sqrt(d)
c(lambda = lam, se = se, mean_days = 1 / lam, median_days = log(2) / lam)
# 95% Wald interval on the log scale (stays positive)
lam * exp(c(-1, 1) * 1.96 / sqrt(d))


## ----wrong--------------------------------------------------------------------
c(correct = lam,
  drop_censored = sum(vet$status) / sum(vet$time[vet$status == 1]),
  censored_as_deaths = nrow(vet) / tot)


## ----optim--------------------------------------------------------------------
negll <- function(loglam) -(d * loglam - exp(loglam) * tot)
opt <- optim(log(0.01), negll, method = "BFGS", hessian = TRUE)
exp(opt$par)                       # same as lam
sqrt(1 / opt$hessian)              # se of log(lambda) = 1/sqrt(d)
1 / sqrt(d)


## ----survreg------------------------------------------------------------------
e0 <- survreg(Surv(time, status) ~ 1, data = vet, dist = "exponential")
summary(e0)
exp(-coef(e0))                     # = 128 / 16663
logLik(e0)
d * log(lam) - lam * tot           # same log-likelihood


## ----by-trt-------------------------------------------------------------------
e1 <- survreg(Surv(time, status) ~ trt, data = vet, dist = "exponential")
coef(e1)
exp(-coef(e1)[2])   # hazard ratio test / standard under the exponential model
tapply(vet$status, vet$trt, sum) / tapply(vet$time, vet$trt, sum)


## ----check, fig.width = 7, fig.height = 4.5-----------------------------------
km <- survfit(Surv(time, status) ~ 1, data = vet)
w0 <- survreg(Surv(time, status) ~ 1, data = vet, dist = "weibull")
w0$scale                           # 1.17 > 1: hazard decreases with time
anova(e0, w0)                      # LR = 6.26 on 1 df, p = 0.012
plot(km, conf.int = FALSE, xlab = "Days", ylab = "S(t)", xlim = c(0, 600))
curve(exp(-lam * x), add = TRUE, col = "firebrick", lwd = 2)
curve(1 - psurvreg(x, coef(w0), w0$scale, distribution = "weibull"),
      add = TRUE, col = "royalblue", lwd = 2, lty = 2)
legend("topright", c("Kaplan-Meier", "exponential", "Weibull"),
       col = c("black", "firebrick", "royalblue"), lty = c(1, 1, 2), lwd = 2, bty = "n")

