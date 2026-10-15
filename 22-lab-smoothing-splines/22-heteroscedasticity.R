#' ---
#' title: "Session 22 — Non-constant variance in the motorcycle data"
#' subtitle: "Statistical Modelling (BAM), Spring 2027"
#' author: "Prof. Dae-Jin Lee (daelee@faculty.ie.edu)"
#' output: html_document
#' ---
#' 

#' 
## ----data---------------------------------------------------------------------
library(MASS)
library(splines)
library(mgcv)
data(mcycle)
x <- mcycle$times
y <- mcycle$accel
n <- length(y)

#' 
#' ## 1. A P-spline fit and its residuals
#' 
## ----fit----------------------------------------------------------------------
bbase <- function(x, xl = min(x) - 0.01, xr = max(x) + 0.01, nseg = 20, bdeg = 3) {
  dx <- (xr - xl) / nseg
  knots <- seq(xl - bdeg * dx, xr + bdeg * dx, by = dx)
  splineDesign(knots, x, ord = bdeg + 1, outer.ok = TRUE)
}
B <- bbase(x)
D <- diff(diag(ncol(B)), differences = 2)
wpspline <- function(lambda, w = rep(1, n)) {
  # weighted penalized least squares: sum w_i (y_i - f_i)^2 + lambda ||D theta||^2
  A <- crossprod(B, w * B) + lambda * crossprod(D)
  theta <- solve(A, crossprod(B, w * y))
  f <- drop(B %*% theta)
  edf <- sum(diag(solve(A, crossprod(B, w * B))))
  wrss <- sum(w * (y - f)^2)
  list(f = f, edf = edf, gcv = n * wrss / (n - edf)^2)
}
gcv_fit <- function(w = rep(1, n)) {
  o <- optimize(function(l) wpspline(10^l, w)$gcv, c(-4, 6))
  c(wpspline(10^o$minimum, w), log10_lambda = o$minimum)
}
fit0 <- gcv_fit()
r <- y - fit0$f
c(edf = fit0$edf, sigma_hat = sqrt(sum(r^2) / (n - fit0$edf)))
tapply(r, cut(x, c(0, 15, 40, 60)), sd)

#' 
#' ## 2. Estimating sigma(x) by smoothing the absolute residuals
#' 
#' If $r_i \approx \varepsilon_i \sim N(0, \sigma^2(x_i))$, then
#' $\mathbb E|r_i| = \sigma(x_i)\sqrt{2/\pi}$. A smooth of $|r_i|$ against $x_i$,
#' multiplied by $\sqrt{\pi/2}$, therefore estimates $\sigma(x)$.
#' 
## ----sigma--------------------------------------------------------------------
v <- smooth.spline(x, abs(r), df = 6)
sigma_x <- pmax(sqrt(pi / 2) * predict(v, x)$y, 1)   # floor at 1 g to avoid zero weights
plot(x, abs(r), pch = 16, col = "grey50", xlab = "Time (ms)", ylab = "|residual| (g)")
lines(x, sigma_x, lwd = 2, col = "red")
range(sigma_x)

#' 
#' This is a rough, descriptive estimate (it ignores that residuals are slightly
#' smaller than errors); it is enough to build weights.
#' 
#' ## 3. Weighted P-spline
#' 
#' With weights $w_i = 1/\hat\sigma^2(x_i)$, observations from the quiet early
#' segment count more, those from the noisy impact phase count less.
#' 
## ----weighted-----------------------------------------------------------------
w <- 1 / sigma_x^2
fit_w <- gcv_fit(w)
c(edf_unweighted = fit0$edf, edf_weighted = fit_w$edf)
z <- (y - fit_w$f) / sigma_x          # standardized residuals
tapply(z, cut(x, c(0, 15, 40, 60)), sd)
plot(x, y, pch = 16, col = "grey60", xlab = "Time (ms)", ylab = "Acceleration (g)")
lines(x, fit0$f, lwd = 2, col = "navy")
lines(x, fit_w$f, lwd = 2, col = "red", lty = 2)
legend("bottomright", bty = "n", lwd = 2, col = c("navy", "red"), lty = c(1, 2),
       legend = c("unweighted", "weighted by 1/sigma^2(x)"))

#' 
#' After weighting, the standardized residuals have a much more similar spread in
#' the three regions.
#' 
#' ## 4. Modelling mean and variance together (preview)
#' 
#' `mgcv`'s `gaulss()` family fits a smooth for the mean and a smooth for
#' $\log\sigma$ at the same time (location–scale model).
#' 
## ----gaulss-------------------------------------------------------------------
g2 <- gam(list(accel ~ s(times, bs = "ps", k = 20), ~ s(times, bs = "ps", k = 10)),
          family = gaulss(), data = mcycle)
summary(g2)$edf
sig_g <- 1 / predict(g2, type = "response")[, 2]   # second column is 1/sigma
range(sig_g)

