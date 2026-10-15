#' ---
#' title: "Session 21 — Smoothing splines and penalized truncated power splines"
#' subtitle: "Statistical Modelling (BAM), Spring 2027"
#' author: "Prof. Dae-Jin Lee (daelee@faculty.ie.edu)"
#' output: html_document
#' ---
#' 

#' 
## ----data---------------------------------------------------------------------
library(MASS)
data(mcycle)
x <- mcycle$times
y <- mcycle$accel
n <- length(y)

#' 
#' ## 1. Smoothing splines with `smooth.spline()`
#' 
#' The smoothing spline minimizes
#' $\sum_i\{y_i - f(x_i)\}^2 + \lambda\int f''(u)^2\,du$. The minimizer is a natural
#' cubic spline with knots at the distinct $x_i$. `smooth.spline()` chooses
#' $\lambda$ by GCV by default (`cv = FALSE`) or by leave-one-out CV (`cv = TRUE`).
#' `mcycle` has tied times, so `smooth.spline()` works with the 94 distinct values
#' and weights them by their counts; with ties, ordinary LOOCV is not well defined
#' and R warns about it.
#' 
## ----ss-----------------------------------------------------------------------
ss_gcv <- smooth.spline(x, y)
ss_cv <- suppressWarnings(smooth.spline(x, y, cv = TRUE))
rbind(GCV = c(df = ss_gcv$df, lambda = ss_gcv$lambda),
      CV = c(df = ss_cv$df, lambda = ss_cv$lambda))

#' 
#' `df` is $\mathrm{tr}(S_\lambda)$. Fixing `df` instead of $\lambda$ is often easier to
#' interpret:
#' 
## ----ss-df--------------------------------------------------------------------
fits <- lapply(c(5, 12, 30), function(df) smooth.spline(x, y, df = df))
sapply(fits, function(f) c(df = f$df, lambda = f$lambda))
plot(x, y, pch = 16, col = "grey60", xlab = "Time (ms)", ylab = "Acceleration (g)")
for (k in 1:3) lines(fits[[k]], col = c("darkgreen", "navy", "red")[k], lwd = 2)
legend("bottomright", bty = "n", lwd = 2, col = c("darkgreen", "navy", "red"),
       legend = paste("df =", c(5, 12, 30)))

#' 
#' ## 2. Leverages and leave-one-out residuals
#' 
#' `fit$lev` holds the leverages (diagonal of $S_\lambda$) at the 94 distinct $x$
#' values; they add up to the reported `df`. Because the smoothing spline is a
#' penalized least squares fit, the leave-one-out residual is exactly
#' $(y_i - \hat f_i)/(1 - S_{ii})$ when the $x_i$ are distinct.
#' 
## ----lev----------------------------------------------------------------------
summary(ss_gcv$lev)
c(sum_lev = sum(ss_gcv$lev), df = ss_gcv$df)

#' 
#' ## 3. A penalized truncated power spline
#' 
#' With the truncated power basis $[1, x, \dots, x^q, (x - \kappa_k)_+^q]$ the natural
#' penalty is a ridge penalty on the knot coefficients $\gamma_k$ only:
#' $\lambda\sum_k\gamma_k^2 = \lambda\,\theta^\top P\theta$ with
#' $P = \mathrm{diag}(0_{q+1}, I_K)$. The polynomial part is not penalized.
#' 
## ----tp-penalized-------------------------------------------------------------
q <- 3
K <- 30
knots <- quantile(unique(x), probs = (1:K) / (K + 1))
xs <- x / max(x)                                  # rescale to [0, 1] for conditioning
ks <- knots / max(x)
X <- cbind(outer(xs, 0:q, `^`), outer(xs, ks, function(u, k) pmax(u - k, 0)^q))
P <- diag(c(rep(0, q + 1), rep(1, K)))
tp_fit <- function(lambda) {
  A <- crossprod(X) + lambda * P
  S <- X %*% solve(A, t(X))
  f <- drop(S %*% y); edf <- sum(diag(S)); rss <- sum((y - f)^2)
  c(edf = edf, GCV = n * rss / (n - edf)^2)
}
loglam <- seq(-10, 0, by = 0.05)
crit <- t(sapply(loglam, function(l) tp_fit(10^l)))
crit[which.min(crit[, "GCV"]), ]

#' 
#' Penalizing the polynomial coefficients as well would shrink the fit toward zero
#' instead of toward a cubic; with $\lambda \to \infty$ the fit above tends to the
#' least squares cubic (edf $\to q + 1 = 4$).
#' 
## ----tp-limit-----------------------------------------------------------------
tp_fit(1e8)["edf"]

#' 
#' ## 4. Smoothing as regularization: the ridge analogy
#' 
#' Ridge regression is penalized least squares with $D = I$: every coefficient is
#' shrunk toward zero. P-splines and penalized truncated power splines shrink
#' toward the null space of the penalty (a low-degree polynomial). Session 27 shows
#' that both are mixed models in which the penalized coefficients are random
#' effects with variance $\sigma^2/\lambda$.
