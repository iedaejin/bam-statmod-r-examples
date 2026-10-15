# Session 4 — A small toolkit for numerical MLE
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Plain-script version of 04-mle-toolkit.Rmd (same code). Run from this folder.

# ---- 1. Fit any model from its negative log-likelihood ---------------------

fit_mle <- function(nll, start, ...) {
  fit <- optim(start, nll, method = "BFGS", hessian = TRUE, ...)
  if (fit$convergence != 0) warning("optim() did not report convergence")
  ev <- eigen(fit$hessian, symmetric = TRUE, only.values = TRUE)$values
  if (min(ev) <= 0) warning("Hessian not positive definite: not a proper maximum")
  list(par = fit$par, se = sqrt(diag(solve(fit$hessian))),
       loglik = -fit$value, convergence = fit$convergence)
}

# 95% likelihood interval for a one-parameter log-likelihood
lr_interval <- function(loglik, mle, lower, upper, level = 0.95) {
  cut <- qchisq(level, df = 1) / 2
  f <- function(t) loglik(t) - loglik(mle) + cut
  c(uniroot(f, c(lower, mle), tol = 1e-10)$root,
    uniroot(f, c(mle, upper), tol = 1e-10)$root)
}

# ---- 2. Poisson model for the warp breaks ----------------------------------

y <- warpbreaks$breaks
n <- length(y)
loglik <- function(lambda) sum(dpois(y, lambda, log = TRUE))

fit <- fit_mle(function(theta) -loglik(exp(theta)), start = 0)   # theta = log(lambda)
lambda_hat <- exp(fit$par)
se_lambda  <- lambda_hat * fit$se                                 # delta method
c(lambda_hat = lambda_hat, mean = mean(y), se = se_lambda, se_formula = sqrt(mean(y) / n))

# ---- 3. Wald and likelihood intervals --------------------------------------

wald <- lambda_hat + c(-1, 1) * qnorm(0.975) * se_lambda
lr   <- lr_interval(loglik, mean(y), lower = 1, upper = 100)
round(rbind(Wald = wald, LR = lr), 3)

# ---- 4. Check the model before trusting the standard error -----------------

c(mean = mean(y), variance = var(y), ratio = var(y) / mean(y))
D <- sum((y - mean(y))^2) / mean(y)                 # ~ chi^2_{n-1} under the Poisson model
c(D = D, df = n - 1, p_value = pchisq(D, n - 1, lower.tail = FALSE))

# ---- 5. A two-parameter alternative and an LR test -------------------------

nll_nb <- function(par) -sum(dnbinom(y, mu = exp(par[1]), size = exp(par[2]), log = TRUE))
fit_nb <- fit_mle(nll_nb, start = c(log(mean(y)), 0))
c(mu_hat = exp(fit_nb$par[1]), k_hat = exp(fit_nb$par[2]), loglik_nb = fit_nb$loglik,
  loglik_pois = loglik(mean(y)))
LR <- 2 * (fit_nb$loglik - loglik(mean(y)))
c(LR = LR, p_value = pchisq(LR, df = 1, lower.tail = FALSE))

