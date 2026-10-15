# Session 28 — Kaplan–Meier and the log-rank test
# Prof. Dae-Jin Lee (daelee@faculty.ie.edu) --- Statistical Modelling (BAM), IE University
# Plain-script version of 28-kaplan-meier.Rmd. Run: Rscript 28-kaplan-meier.R

## ----data---------------------------------------------------------------------
library(survival)
vet <- survival::veteran
vet$trt <- factor(vet$trt, levels = 1:2, labels = c("standard", "test"))
str(vet)
table(vet$status)          # 128 deaths, 9 censored


## ----surv---------------------------------------------------------------------
head(Surv(vet$time, vet$status), 15)


## ----km-hand------------------------------------------------------------------
sub10 <- vet[6:15, c("time", "status")]
sub10[order(sub10$time), ]

# event times, numbers at risk and deaths
ev  <- sort(unique(sub10$time[sub10$status == 1]))
n_j <- sapply(ev, function(t) sum(sub10$time >= t))
d_j <- sapply(ev, function(t) sum(sub10$time == t & sub10$status == 1))
S   <- cumprod(1 - d_j / n_j)
gw  <- cumsum(d_j / (n_j * (n_j - d_j)))      # Greenwood sum
data.frame(t = ev, n = n_j, d = d_j, S = round(S, 4),
           se = round(S * sqrt(gw), 4))


## ----km-check-----------------------------------------------------------------
km10 <- survfit(Surv(time, status) ~ 1, data = sub10)
summary(km10)
km10        # median = 82 days: first time with S(t) <= 0.5


## ----km-groups----------------------------------------------------------------
km_trt <- survfit(Surv(time, status) ~ trt, data = vet)
km_trt                                   # medians with 95% CIs
summary(km_trt, times = c(90, 180, 365)) # survival at fixed times

km_cell <- survfit(Surv(time, status) ~ celltype, data = vet)
km_cell


## ----km-plot, fig.width = 7, fig.height = 4.5---------------------------------
plot(km_trt, col = c("navy", "firebrick"), lwd = 2, conf.int = TRUE, mark.time = TRUE,
     xlab = "Days", ylab = "Estimated S(t)")
legend("topright", c("standard", "test"), col = c("navy", "firebrick"), lwd = 2, bty = "n")


## ----logrank------------------------------------------------------------------
survdiff(Surv(time, status) ~ trt, data = vet)       # chi-sq = 0.008, p = 0.93
survdiff(Surv(time, status) ~ celltype, data = vet)  # chi-sq = 25.4 on 3 df


## ----logrank-hand-------------------------------------------------------------
tj <- sort(unique(vet$time[vet$status == 1]))
parts <- t(sapply(tj, function(t) {
  at_risk <- vet$time >= t
  n  <- sum(at_risk); n1 <- sum(at_risk & vet$trt == "standard")
  d  <- sum(vet$time == t & vet$status == 1)
  d1 <- sum(vet$time == t & vet$status == 1 & vet$trt == "standard")
  c(O = d1, E = n1 * d / n,
    V = if (n > 1) n1 * (n - n1) * d * (n - d) / (n^2 * (n - 1)) else 0)
}))
O <- sum(parts[, "O"]); E <- sum(parts[, "E"]); V <- sum(parts[, "V"])
c(O = O, E = E, V = V, chisq = (O - E)^2 / V)

