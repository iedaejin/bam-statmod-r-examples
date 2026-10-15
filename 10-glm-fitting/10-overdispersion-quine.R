# Session 10 — Overdispersion: school absences
# Statistical Modelling (BAM), IE University
# Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Same code as 10-overdispersion-quine.Rmd. Run from this folder.

# ---- poisson ----
library(MASS)
fp <- glm(Days ~ Eth + Sex + Age + Lrn, family = poisson, data = quine)
X2 <- sum(residuals(fp, type = "pearson")^2)
c(phi_pearson = X2 / df.residual(fp), phi_deviance = deviance(fp) / df.residual(fp))

# ---- ct-test ----
y <- quine$Days; mu <- fitted(fp)
aux <- lm(((y - mu)^2 - y) / mu ~ 0 + mu)
ct <- summary(aux)$coefficients
c(alpha = ct[1, 1], t = ct[1, 3], p_one_sided = pt(ct[1, 3], df.residual(aux), lower.tail = FALSE))

# ---- quasi ----
fq <- glm(Days ~ Eth + Sex + Age + Lrn, family = quasipoisson, data = quine)
summary(fq)$dispersion
round(cbind(est = coef(fp), se_pois = sqrt(diag(vcov(fp))), se_quasi = sqrt(diag(vcov(fq)))), 3)

# ---- nb ----
fnb <- glm.nb(Days ~ Eth + Sex + Age + Lrn, data = quine)
c(k = fnb$theta, se_k = fnb$SE.theta)
round(cbind(est_nb = coef(fnb), se_nb = sqrt(diag(vcov(fnb)))), 3)
AIC(fp, fnb)
# LR test of k = infinity (Poisson) is on the boundary: halve the chi-square(1) p-value
LR <- 2 * (as.numeric(logLik(fnb)) - as.numeric(logLik(fp)))
c(LR = LR, p = 0.5 * pchisq(LR, 1, lower.tail = FALSE))

# ---- meanvar ----
cells <- aggregate(Days ~ Eth + Sex + Age + Lrn, data = quine,
                   FUN = function(d) c(m = mean(d), v = var(d), n = length(d)))
cells <- data.frame(cells[, 1:4], cells$Days)
cells <- subset(cells, n >= 3)
plot(v ~ m, data = cells, log = "xy", pch = 19, xlab = "cell mean", ylab = "cell variance")
mm <- seq(min(cells$m), max(cells$m), length.out = 100)
lines(mm, mm, lty = 2)                                 # Poisson
lines(mm, summary(fq)$dispersion * mm, lty = 3)       # quasi-Poisson
lines(mm, mm + mm^2 / fnb$theta, lwd = 2)              # negative binomial
legend("topleft", c("Poisson", "quasi-Poisson", "neg. binomial"),
       lty = c(2, 3, 1), lwd = c(1, 1, 2), bty = "n")

# ---- zeros ----
c(observed = sum(y == 0),
  poisson  = sum(dpois(0, fitted(fp))),
  negbin   = sum(dnbinom(0, size = fnb$theta, mu = fitted(fnb))))

# ---- rqr ----
rqr <- function(y, F, ...) {               # as in 10-residuals.Rmd
  lo <- F(y - 1, ...); hi <- F(y, ...); u <- runif(length(y))
  up_lo <- F(y, ..., lower.tail = FALSE); up_hi <- F(y - 1, ..., lower.tail = FALSE)
  ifelse(lo < 0.5, qnorm(lo + u * (hi - lo)),
         qnorm(up_lo + u * (up_hi - up_lo), lower.tail = FALSE))
}
set.seed(2027)
rq_pois <- rqr(y, ppois, lambda = fitted(fp))
rq_nb   <- rqr(y, pnbinom, size = fnb$theta, mu = fitted(fnb))
range(rq_pois); range(rq_nb)
op <- par(mfrow = c(1, 2))
qqnorm(rq_pois, main = "Poisson"); qqline(rq_pois)
qqnorm(rq_nb, main = "Negative binomial"); qqline(rq_nb)
par(op)

