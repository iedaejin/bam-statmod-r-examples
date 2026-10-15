# Session 3 — Likelihood, score and information
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Plain-script version of 03-likelihood-basics.Rmd (same code). Run from this folder.

# ---- 1. Binomial likelihood: 8 successes in 10 trials ----------------------

n <- 10
y <- 8
theta <- seq(0.01, 0.99, by = 0.01)
lik <- dbinom(y, size = n, prob = theta)       # L(theta), up to a constant
rel_lik <- lik / max(lik)                       # relative likelihood L(theta) / L(theta_hat)

theta_hat <- y / n
theta_hat
integrate(function(t) dbinom(y, n, t), 0, 1)$value   # 1/(n+1), not 1

# Likelihood ratio: how much better does theta = 0.8 explain the data than theta = 0.5?
dbinom(y, n, 0.5) / dbinom(y, n, 0.8)

plot(theta, rel_lik, type = "l", lwd = 2,
     xlab = expression(theta), ylab = "relative likelihood")
abline(v = theta_hat, lty = 2)
abline(h = exp(-qchisq(0.95, 1) / 2), lty = 3)   # 0.147 cut-off (see 03-wald-score-lr)

# ---- 2. Score and observed vs expected information -------------------------

score    <- function(t) y / t - (n - y) / (1 - t)
obs_info <- function(t) y / t^2 + (n - y) / (1 - t)^2     # I(theta)  = -l''(theta)
exp_info <- function(t) n / (t * (1 - t))                 # Ii(theta) = E[I(theta)]

score(theta_hat)                                          # 0 at the MLE
c(observed = obs_info(theta_hat), expected = exp_info(theta_hat))
c(observed = obs_info(0.6), expected = exp_info(0.6))     # different away from the MLE

se <- 1 / sqrt(obs_info(theta_hat))                       # se = I(theta_hat)^(-1/2)
se

tt <- seq(0.3, 0.97, by = 0.005)
plot(tt, obs_info(tt), type = "l", lwd = 2, log = "y",
     xlab = expression(theta), ylab = "information (log scale)")
lines(tt, exp_info(tt), lwd = 2, lty = 2)
abline(v = theta_hat, lty = 3)
legend("topleft", c("observed I(theta)", "expected (Fisher)"), lty = 1:2, lwd = 2, bty = "n")

# ---- 3. Exponential model: air-conditioning failure times ------------------

data(aircondit, package = "boot")
y_ac <- aircondit$hours
n_ac <- length(y_ac)
y_ac

loglik_exp <- function(mu) -n_ac * log(mu) - sum(y_ac) / mu
mu_hat <- mean(y_ac)
mu_hat
optimize(loglik_exp, c(1, 1000), maximum = TRUE)$maximum   # numerical check

se_mu <- mu_hat / sqrt(n_ac)                                # I(mu_hat)^(-1/2)
se_mu

# Invariance: the MLE of the failure rate lambda = 1/mu is 1/mu_hat
c(rate_hat = 1 / mu_hat,
  rate_numerical = optimize(function(l) loglik_exp(1 / l), c(1e-4, 0.1), maximum = TRUE, tol = 1e-10)$maximum)

# ---- 4. Normal model with two parameters: New Haven temperatures -----------

data(nhtemp)
y_nh <- as.numeric(nhtemp)
n_nh <- length(y_nh)

mu_hat_nh     <- mean(y_nh)
sigma2_hat_nh <- mean((y_nh - mu_hat_nh)^2)       # MLE divides by n
c(n = n_nh, mu_hat = mu_hat_nh, sigma2_hat = sigma2_hat_nh,
  s2_unbiased = var(y_nh))                         # var() divides by n - 1

# Maximised log-likelihood: -n/2 log(2 pi sigma2_hat) - n/2
c(formula = -n_nh / 2 * log(2 * pi * sigma2_hat_nh) - n_nh / 2,
  dnorm_sum = sum(dnorm(y_nh, mu_hat_nh, sqrt(sigma2_hat_nh), log = TRUE)))

# Information matrix at the MLE, parameters (mu, sigma^2): diag(n / s2, n / (2 s2^2))
I_nh <- diag(c(n_nh / sigma2_hat_nh, n_nh / (2 * sigma2_hat_nh^2)))
sqrt(diag(solve(I_nh)))                             # se(mu_hat), se(sigma2_hat)

# ---- 5. The MLE of a variance is biased, but only by a factor (n-1)/n ------

set.seed(2027)
sims <- replicate(10000, {
  z <- rnorm(5, mean = 0, sd = 1)
  mean((z - mean(z))^2)
})
c(mean_of_mle = mean(sims), theory = (5 - 1) / 5)   # biased for n = 5 ...
(60 - 1) / 60                                        # ... negligible for n = 60

