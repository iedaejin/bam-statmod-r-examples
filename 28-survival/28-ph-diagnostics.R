# Session 28 — Checking proportional hazards and fixing a violation
# Prof. Dae-Jin Lee (daelee@faculty.ie.edu) --- Statistical Modelling (BAM), IE University
# Plain-script version of 28-ph-diagnostics.Rmd. Run: Rscript 28-ph-diagnostics.R

## ----data---------------------------------------------------------------------
library(survival)
vet <- survival::veteran
vet$trt <- factor(vet$trt, levels = 1:2, labels = c("standard", "test"))
fit <- coxph(Surv(time, status) ~ trt + karno + celltype + age, data = vet)


## ----zph, fig.width = 7, fig.height = 4.5-------------------------------------
zp <- cox.zph(fit)
zp                                  # karno p = 0.0003, celltype p = 0.002
plot(zp[2], resid = TRUE, se = TRUE, lwd = 2)
abline(h = coef(fit)["karno"], col = "firebrick", lty = 2)


## ----loglog, fig.width = 7, fig.height = 4.5----------------------------------
vet$kgrp <- cut(vet$karno, c(0, 40, 60, 100), labels = c("10-40", "50-60", "70-99"))
km_k <- survfit(Surv(time, status) ~ kgrp, data = vet)
plot(km_k, fun = "cloglog", col = c("navy", "firebrick", "royalblue"), lwd = 2,
     xlab = "Days (log scale)", ylab = "log(-log S(t))")
legend("topleft", levels(vet$kgrp), col = c("navy", "firebrick", "royalblue"), lwd = 2, bty = "n")


## ----strata-------------------------------------------------------------------
fit_s <- coxph(Surv(time, status) ~ trt + celltype + age + strata(kgrp), data = vet)
summary(fit_s)$coefficients
cox.zph(fit_s)


## ----step---------------------------------------------------------------------
vs <- survSplit(Surv(time, status) ~ ., data = vet, cut = c(90, 180),
                episode = "tgroup", id = "id")
fit_t <- coxph(Surv(tstart, time, status) ~ trt + celltype + age + karno:strata(tgroup),
               data = vs)
round(summary(fit_t)$coefficients, 4)
cox.zph(fit_t)
AIC(fit, fit_t)        # same risk sets, so the partial likelihoods are comparable


## ----tt-----------------------------------------------------------------------
fit_tt <- coxph(Surv(time, status) ~ trt + celltype + age + karno + tt(karno), data = vet,
                tt = function(x, t, ...) x * log(t + 20))
b <- coef(fit_tt)
round(summary(fit_tt)$coefficients, 4)
sapply(c(30, 90, 180, 365), function(t) b["karno"] + b["tt(karno)"] * log(t + 20))

