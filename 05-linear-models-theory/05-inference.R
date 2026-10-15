# Session 05 — Inference for linear-model coefficients
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Same code as 05-inference.Rmd. Run from r-examples/:  Rscript 05-inference.R



## ----fit----------------------------------------------------------------------
library(faraway)
data(savings)
fit <- lm(sr ~ pop15 + pop75 + dpi + ddpi, data = savings)
summary(fit)


## ----se-by-hand---------------------------------------------------------------
X <- model.matrix(fit)
n <- nrow(X); p <- ncol(X)
RSS <- sum(resid(fit)^2)
sigma2_hat <- RSS / (n - p)
c(RSS = RSS, sigma2_hat = sigma2_hat, sigma_hat = sqrt(sigma2_hat))
V <- sigma2_hat * solve(crossprod(X))
se <- sqrt(diag(V))
cbind(by_hand = se, lm = coef(summary(fit))[, "Std. Error"])


## ----t-and-ci-----------------------------------------------------------------
b <- coef(fit)["pop15"]; s <- se["pop15"]
t_stat <- b / s
p_val <- 2 * pt(-abs(t_stat), df = n - p)
t_crit <- qt(0.975, df = n - p)
c(t = unname(t_stat), p = unname(p_val), t_crit = t_crit)
b + c(-1, 1) * t_crit * s
confint(fit)["pop15", ]


## ----f-test-------------------------------------------------------------------
fit0 <- lm(sr ~ pop15 + ddpi, data = savings)
RSS0 <- deviance(fit0); RSS1 <- deviance(fit)
F_stat <- ((RSS0 - RSS1) / 2) / (RSS1 / (n - p))
c(F = F_stat, p = pf(F_stat, 2, n - p, lower.tail = FALSE))
anova(fit0, fit)


## ----r2-----------------------------------------------------------------------
TSS <- sum((savings$sr - mean(savings$sr))^2)
c(R2 = 1 - RSS / TSS,
  adjR2 = 1 - (RSS / (n - p)) / (TSS / (n - 1)))


## ----mle----------------------------------------------------------------------
sigma2_ml <- RSS / n
loglik_by_hand <- -n / 2 * log(2 * pi * sigma2_ml) - n / 2
c(sigma2_ml = sigma2_ml, sigma2_unbiased = sigma2_hat,
  loglik_by_hand = loglik_by_hand, logLik = as.numeric(logLik(fit)))
# -2 log L at any sigma^2 = n log(2 pi sigma^2) + RSS / sigma^2
m2ll <- function(s2) n * log(2 * pi * s2) + RSS / s2
optimize(m2ll, c(1, 50))$minimum      # numerical minimiser = RSS / n


## ----sim----------------------------------------------------------------------
set.seed(505)
beta <- coef(fit); sigma <- 4
sims <- replicate(2000, {
  ysim <- drop(X %*% beta) + rnorm(n, sd = sigma)
  r <- sum(lm.fit(X, ysim)$residuals^2)
  c(ml = r / n, unbiased = r / (n - p))
})
rowMeans(sims)       # compare with sigma^2 = 16 and 16 * (n - p) / n = 14.4

