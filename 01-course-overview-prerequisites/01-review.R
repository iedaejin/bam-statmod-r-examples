# Session 1 — Review of prerequisites as one script
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Same steps as 01-distributions.Rmd, 01-matrix-algebra.Rmd and 01-calculus-optimization.Rmd,
# in the order of the slides. Run from r-examples/:  Rscript 01-review.R

# Distributions: d, p, q, r -------------------------------------------------
print(pnorm(1.96) - pnorm(-1.96))         # P(|Z| < 1.96) = 0.95
print(qnorm(0.975))                       # 1.959964
print(dbinom(3, size = 10, prob = 0.2))   # P(Y = 3), Y ~ Bin(10, 0.2)

# Poisson counts: mean versus variance (overdispersion, session 10) ---------
y <- as.numeric(discoveries)              # great discoveries per year, 1860-1959
print(c(n = length(y), mean = mean(y), var = var(y)))

# Random vectors: E[AY] = A mu and Var(AY) = A Sigma A^T --------------------
mu    <- c(1, 2)
Sigma <- matrix(c(4, 2, 2, 3), nrow = 2)
A     <- matrix(c(1, 1, 1, -1), nrow = 2, byrow = TRUE)
print(A %*% Sigma %*% t(A))               # theory: [11 1; 1 3]
set.seed(2027)
Y <- MASS::mvrnorm(1e5, mu = mu, Sigma = Sigma)
print(round(var(Y %*% t(A)), 2))          # simulation

# Matrix algebra: normal equations X^T X beta = X^T y, and their solution ---
X <- cbind(1, wt = mtcars$wt, hp = mtcars$hp)   # n x p, intercept included
beta_hat <- solve(crossprod(X), crossprod(X, mtcars$mpg))
print(drop(beta_hat))
print(coef(lm(mpg ~ wt + hp, data = mtcars)))

H <- X %*% solve(crossprod(X)) %*% t(X)   # hat matrix
print(sum(diag(H)))                       # trace = p = 3

# Calculus: maximise f(x) = x^2 exp(-x) and a Poisson log-likelihood --------
print(optimize(function(x) x^2 * exp(-x), c(0, 10), maximum = TRUE)$maximum)  # 2

loglik <- function(lambda) sum(y) * log(lambda) - length(y) * lambda
lambda_hat <- optimize(loglik, c(0.01, 10), maximum = TRUE)$maximum
obs_info <- -optimHess(lambda_hat, loglik)          # numerical -l''(lambda_hat)
print(c(lambda_hat = lambda_hat, ybar = mean(y)))
print(c(info_numeric = drop(obs_info), info_formula = length(y) / mean(y)))
print(c(se = 1 / sqrt(drop(obs_info)), formula = sqrt(mean(y) / length(y))))
