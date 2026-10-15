# Session 1 — Derivatives and optimization
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Plain-script version of 01-calculus-optimization.Rmd (same code). Run from r-examples/:  Rscript 01-calculus-optimization.R

# Maximum likelihood (session 3) means finding where a derivative is zero, and its standard errors come from the second derivative. This file shows the tools we use: symbolic derivatives, second-order Taylor expansions, numerical optimization, and numerical checks of a gradient and a Hessian.

# ---- Symbolic derivatives ----
f <- expression(x^2 * exp(-x))
D(f, "x")
D(D(f, "x"), "x")

# ---- Find a maximum numerically ----
# $f(x) = x^2 e^{-x}$: $f'(x) = x e^{-x}(2 - x)$, so the stationary points are $x = 0$ and $x = 2$.
# $f''(x) = e^{-x}(x^2 - 4x + 2)$ gives $f''(0) = 2 > 0$ (minimum) and $f''(2) = -2e^{-2} < 0$ (maximum, $f(2) = 4e^{-2}$).
f_num <- function(x) x^2 * exp(-x)
optimize(f_num, interval = c(0, 10), maximum = TRUE)
c(f_at_2 = 4 * exp(-2), f2_at_2 = -2 * exp(-2))

# ---- Second-order Taylor expansion ----
# Around $x_0$: $f(x) \approx f(x_0) + f'(x_0)(x - x_0) + \tfrac12 f''(x_0)(x - x_0)^2$. At the maximum $f'(x_0) = 0$, so only the curvature term is left.
taylor2 <- function(x, x0 = 2) {
  f0 <- x0^2 * exp(-x0)
  f1 <- x0 * exp(-x0) * (2 - x0)
  f2 <- exp(-x0) * (x0^2 - 4 * x0 + 2)
  f0 + f1 * (x - x0) + 0.5 * f2 * (x - x0)^2
}
curve(f_num, from = 0, to = 8, ylab = "f(x)", lwd = 2)
curve(taylor2(x), add = TRUE, lty = 2, lwd = 2)
abline(v = 2, lty = 3)

# ---- Two variables: gradient and Hessian ----
# $f(x, y) = x\, e^{-(x^2 + y^2)}$. The gradient is $\nabla f = e^{-(x^2+y^2)}\,(1 - 2x^2,\ -2xy)^\top$, which vanishes at $(\pm 1/\sqrt2, 0)$.
# At $(1/\sqrt2, 0)$ the Hessian is $e^{-1/2}\,\mathrm{diag}(-2\sqrt2, -\sqrt2)$: negative definite, so a maximum.
# `optimHess()` (package `stats`) computes the Hessian by finite differences.
f2 <- function(v) v[1] * exp(-(v[1]^2 + v[2]^2))
fit2 <- optim(c(0.5, 0.5), f2, control = list(fnscale = -1))   # maximise
fit2$par                                     # close to (0.7071, 0)
H_num <- optimHess(c(1 / sqrt(2), 0), f2)
H_num
exp(-1/2) * diag(c(-2 * sqrt(2), -sqrt(2)))  # analytical Hessian
eigen(H_num)$values                          # both negative

# ---- Check a gradient: least squares ----
# The gradient of $\mathrm{RSS}(\beta) = (y - X\beta)^\top(y - X\beta)$ is $-2X^\top(y - X\beta)$. Compare with a central finite difference at an arbitrary $\beta$, then check that the Hessian is $2X^\top X$.
y <- mtcars$mpg
X <- cbind(1, mtcars$wt, mtcars$hp)
rss <- function(b) sum((y - X %*% b)^2)

b0 <- c(30, -2, -0.02)
grad_analytic <- drop(-2 * crossprod(X, y - X %*% b0))
h <- 1e-5
grad_numeric <- sapply(1:3, function(j) {
  e <- replace(numeric(3), j, h)
  (rss(b0 + e) - rss(b0 - e)) / (2 * h)
})
rbind(grad_analytic, grad_numeric)

all.equal(optimHess(b0, rss), 2 * crossprod(X), tolerance = 1e-6)

# ---- Preview of session 3: a Poisson log-likelihood ----
# Counts $y_1, \dots, y_n \stackrel{\text{iid}}{\sim} \text{Poisson}(\lambda)$. Up to a constant, the log-likelihood is
# $\ell(\lambda) = \sum_i y_i \log \lambda - n\lambda$.
# The score $S(\lambda) = \sum_i y_i/\lambda - n = 0$ gives $\hat\lambda = \bar y$.
# We use the `discoveries` counts (number of great discoveries per year, 1860–1959).
y <- as.numeric(discoveries)
n <- length(y)
loglik <- function(lambda) sum(y) * log(lambda) - n * lambda
fit <- optimize(loglik, interval = c(0.01, 10), maximum = TRUE)
c(numerical = fit$maximum, analytical = mean(y))

# The observed information is $I(\lambda) = -\ell''(\lambda) = \sum_i y_i / \lambda^2$. At $\hat\lambda = \bar y$ it equals $n/\bar y$, and the standard error is $\mathrm{se}(\hat\lambda) = I(\hat\lambda)^{-1/2} = \sqrt{\bar y / n}$.
lambda_hat <- mean(y)
obs_info <- sum(y) / lambda_hat^2
num_info <- -optimHess(lambda_hat, loglik)   # numerical second derivative
c(analytic = obs_info, numeric = drop(num_info), n_over_ybar = n / lambda_hat)
c(se = 1 / sqrt(obs_info), formula = sqrt(lambda_hat / n))

# The second-order Taylor expansion of $\ell$ at $\hat\lambda$ is the quadratic approximation used for Wald intervals in session 3.
ll_rel <- function(l) loglik(l) - loglik(lambda_hat)
curve(sapply(x, ll_rel), from = 2.4, to = 4, lwd = 2,
      xlab = expression(lambda), ylab = "log-likelihood (relative)")
curve(-0.5 * obs_info * (x - lambda_hat)^2, add = TRUE, lty = 2, lwd = 2)
abline(v = lambda_hat, lty = 3)

# ---- `optim()` for several parameters ----
# Most models have more than one parameter. `optim()` minimises, so pass the negative log-likelihood. Here a normal sample, with $\log\sigma$ as the second parameter so that $\sigma$ stays positive.
set.seed(2027)
z <- rnorm(100, mean = 5, sd = 2)
negloglik <- function(par) -sum(dnorm(z, mean = par[1], sd = exp(par[2]), log = TRUE))
fit <- optim(c(0, 0), negloglik, method = "BFGS")
c(mu = fit$par[1], sigma = exp(fit$par[2]))
c(mean(z), sqrt(mean((z - mean(z))^2)))   # MLE of sigma divides by n, not n - 1
