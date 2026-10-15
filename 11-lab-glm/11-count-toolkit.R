# Session 11 — A toolkit for count GLMs
# Statistical Modelling (BAM), IE University
# Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Same code as 11-count-toolkit.Rmd. Run from this folder.

# ---- fit ----
library(MASS)
ins <- Insurance
ins$Group <- factor(ins$Group, ordered = FALSE)
ins$Age   <- factor(ins$Age, ordered = FALSE)
fit <- glm(Claims ~ District + Group + Age + offset(log(Holders)),
           family = poisson, data = ins)
round(exp(cbind(RR = coef(fit), confint(fit))), 3)

# ---- dispersion ----
y <- ins$Claims; mu <- fitted(fit)
X2 <- sum(residuals(fit, type = "pearson")^2)
c(phi_hat = X2 / df.residual(fit), D = deviance(fit), df = df.residual(fit))
ct <- lm(((y - mu)^2 - y) / mu ~ 0 + mu)     # Var = mu + alpha mu^2
summary(ct)$coefficients

# ---- remedies ----
fit_q  <- update(fit, family = quasipoisson)
# glm.nb warns 'iteration limit reached': k-hat runs off to infinity (NB -> Poisson)
fit_nb <- suppressWarnings(
  glm.nb(Claims ~ District + Group + Age + offset(log(Holders)), data = ins))
c(phi = summary(fit_q)$dispersion, k = fit_nb$theta)
AIC(fit, fit_nb)

# ---- residuals ----
rqr <- function(y, F, ...) {
  lo <- F(y - 1, ...); hi <- F(y, ...); u <- runif(length(y))
  up_lo <- F(y, ..., lower.tail = FALSE); up_hi <- F(y - 1, ..., lower.tail = FALSE)
  ifelse(lo < 0.5, qnorm(lo + u * (hi - lo)),
         qnorm(up_lo + u * (up_hi - up_lo), lower.tail = FALSE))
}
set.seed(2027)
r_Q <- rqr(y, ppois, lambda = mu)
op <- par(mfrow = c(1, 2))
plot(log(mu), r_Q, xlab = "log fitted mean", ylab = "randomized quantile residual")
abline(h = c(-2, 0, 2), lty = c(3, 2, 3))
qqnorm(r_Q); qqline(r_Q)
par(op)

# ---- zeros ----
c(observed = sum(y == 0), expected = sum(dpois(0, mu)))
round(sort(cooks.distance(fit), decreasing = TRUE)[1:3], 3)

