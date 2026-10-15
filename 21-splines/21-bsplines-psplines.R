#' ---
#' title: "Session 21 — B-splines and P-splines from scratch"
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
#' ## 1. The Cox–de Boor recursion
#' 
#' With knots $t_j$, degree-0 B-splines are indicators,
#' $B_{j,0}(x) = 1\{t_j \le x < t_{j+1}\}$, and for $q \ge 1$
#' $$B_{j,q}(x) = \frac{x - t_j}{t_{j+q} - t_j}B_{j,q-1}(x) + \frac{t_{j+q+1} - x}{t_{j+q+1} - t_{j+1}}B_{j+1,q-1}(x).$$
#' 
## ----cox-de-boor--------------------------------------------------------------
bspl <- function(x, t, j, q) {
  if (q == 0) return(as.numeric(t[j] <= x & x < t[j + 1]))
  a <- (x - t[j]) / (t[j + q] - t[j])
  b <- (t[j + q + 1] - x) / (t[j + q + 1] - t[j + 1])
  a * bspl(x, t, j, q - 1) + b * bspl(x, t, j + 1, q - 1)
}
t <- -3:8                                   # integer knots
vals <- sapply(1:8, function(j) bspl(1.5, t, j, 3))
round(vals, 5)                              # 1/48, 23/48, 23/48, 1/48
sum(vals)                                   # partition of unity
splineDesign(t, 1.5, ord = 4)               # same values from the splines package

#' 
#' ## 2. An equally spaced B-spline basis
#' 
#' `bbase()` divides $[x_l, x_r]$ into `nseg` equal segments and extends the knots
#' by `bdeg` segments on each side, so that the basis is complete on the whole
#' domain. The domain is taken slightly wider than the data:
#' `xl = min(x) - 0.01` and `xr = max(x) + 0.01`.
#' 
## ----bbase--------------------------------------------------------------------
bbase <- function(x, xl = min(x) - 0.01, xr = max(x) + 0.01, nseg = 20, bdeg = 3) {
  dx <- (xr - xl) / nseg
  knots <- seq(xl - bdeg * dx, xr + bdeg * dx, by = dx)
  B <- splineDesign(knots, x, ord = bdeg + 1, outer.ok = TRUE)
  attr(B, "knots") <- knots
  B
}
B <- bbase(x)
dim(B)                                      # nseg + bdeg = 23 columns
range(rowSums(B))                           # every row sums to 1
max(rowSums(B > 0))                         # at most bdeg + 1 = 4 non-zero per row

#' 
#' ## 3. The difference penalty
#' 
#' $D_d$ is the $(c - d)\times c$ matrix of $d$-th order differences. The first-order
#' penalty $\lVert D_1\theta\rVert^2 = \sum_j (\theta_j - \theta_{j-1})^2$ penalizes
#' differences between neighbouring coefficients (level differences); the second
#' order penalty $\sum_j(\theta_j - 2\theta_{j-1} + \theta_{j-2})^2$ penalizes
#' changes in those differences.
#' 
## ----penalty------------------------------------------------------------------
D1 <- diff(diag(5), differences = 1); D1
D2 <- diff(diag(5), differences = 2); D2
crossprod(D2)                               # D'D: banded, rank c - d

#' 
#' ## 4. Fitting a P-spline for given lambda
#' 
#' Minimizing $\lVert y - B\theta\rVert^2 + \lambda\lVert D_d\theta\rVert^2$ gives
#' $\hat\theta = (B^\top B + \lambda D_d^\top D_d)^{-1}B^\top y$ and the smoother
#' $S_\lambda = B(B^\top B + \lambda D_d^\top D_d)^{-1}B^\top$.
#' 
## ----psfit--------------------------------------------------------------------
psfit <- function(B, y, lambda, d = 2) {
  D <- diff(diag(ncol(B)), differences = d)
  A <- crossprod(B) + lambda * crossprod(D)
  theta <- solve(A, crossprod(B, y))
  S <- B %*% solve(A, t(B))                  # n x n smoother matrix
  f <- drop(B %*% theta)
  n <- length(y); edf <- sum(diag(S)); rss <- sum((y - f)^2)
  list(theta = drop(theta), f = f, S = S, edf = edf, rss = rss,
       gcv = n * rss / (n - edf)^2,
       aic = n * log(rss / n) + 2 * edf,
       sigma = sqrt(rss / (n - edf)))
}
sapply(c(0.01, 1, 100, 1e4), function(l) round(psfit(B, y, l)$edf, 2))

#' 
#' ## 5. Choosing lambda by GCV (and AIC)
#' 
## ----gcv----------------------------------------------------------------------
loglam <- seq(-3, 6, by = 0.05)
crit <- t(sapply(loglam, function(l) {
  p <- psfit(B, y, 10^l)
  c(edf = p$edf, GCV = p$gcv, AIC = p$aic)
}))
opt <- optimize(function(l) psfit(B, y, 10^l)$gcv, c(-3, 6))
fit <- psfit(B, y, 10^opt$minimum)
c(log10_lambda = opt$minimum, lambda = 10^opt$minimum, edf = fit$edf,
  GCV = fit$gcv, sigma = fit$sigma)
loglam[which.min(crit[, "AIC"])]           # AIC picks almost the same lambda
plot(loglam, crit[, "GCV"], type = "l", lwd = 2, col = "navy",
     xlab = "log10(lambda)", ylab = "GCV")
abline(v = opt$minimum, lty = 2)

#' 
#' ## 6. Check against mgcv
#' 
#' `mgcv::gam()` with `bs = "ps"` uses the same construction: cubic B-splines on
#' equally spaced knots and a second-order difference penalty. Passing our knots
#' makes the bases identical; with `method = "GCV.Cp"` the smoothing parameter is
#' chosen by the same GCV criterion. (mgcv rescales the penalty internally, so its
#' `sp` is not our $\lambda$; compare edf and fitted values instead.)
#' 
## ----mgcv-check---------------------------------------------------------------
g <- gam(accel ~ s(times, bs = "ps", k = ncol(B), m = c(2, 2)), data = mcycle,
         knots = list(times = attr(B, "knots")), method = "GCV.Cp")
c(edf_mgcv = sum(g$edf), edf_hand = fit$edf,
  gcv_mgcv = g$gcv.ubre, gcv_hand = fit$gcv,
  max_abs_diff_fit = max(abs(fitted(g) - fit$f)))

#' 
#' ## 7. Limits of the penalty and polynomial reproduction
#' 
#' As $\lambda \to \infty$ the fit tends to the least squares polynomial of degree
#' $d - 1$ (the null space of $D_d$), and edf $\to d$. If the data are a
#' polynomial of degree at most $d - 1$ and the B-splines have degree
#' $q \ge d - 1$ on equally spaced knots, the fit reproduces them exactly for
#' every $\lambda$.
#' 
## ----limits-------------------------------------------------------------------
c(edf_small_lambda = psfit(B, y, 1e-8)$edf, edf_huge_lambda = psfit(B, y, 1e10)$edf)
y_lin <- 3 + 2 * x
y_quad <- (x - 25)^2 / 10
c(linear_d2 = max(abs(psfit(B, y_lin, 1e3, d = 2)$f - y_lin)),
  linear_d1 = max(abs(psfit(B, y_lin, 1e3, d = 1)$f - y_lin)),
  quad_d2 = max(abs(psfit(B, y_quad, 1e3, d = 2)$f - y_quad)),
  quad_d3 = max(abs(psfit(B, y_quad, 1e3, d = 3)$f - y_quad)))

#' 
#' ## 8. Conservation of moments
#' 
#' From the normal equations, $B^\top(y - \hat f) = \lambda D_d^\top D_d\hat\theta$.
#' For $k < d$ the vector $(x_i^k)$ equals $Bu$ with $D_d u = 0$, so
#' $\sum_i x_i^k(y_i - \hat f_i) = 0$: with $d = 2$ the fit keeps the sum of $y$ and
#' the sum of $x y$, but not the sum of $x^2 y$.
#' 
## ----moments------------------------------------------------------------------
f <- fit$f
rbind(data = c(sum(y), sum(x * y), sum(x^2 * y)),
      fit = c(sum(f), sum(x * f), sum(x^2 * f)))

#' 
#' ## 9. A simulated check with a known function
#' 
#' With known $f$ we can see how close the GCV fit gets. Note the noise: standard
#' deviation $0.1$ is `rnorm(n, 0, 0.1)` (mean 0, sd 0.1).
#' 
## ----simulated----------------------------------------------------------------
set.seed(2022)
ns <- 200
xs <- seq(0, 1, length.out = ns)
fs <- sin(3 * pi * xs)
ys <- fs + rnorm(ns, 0, 0.1)
Bs <- bbase(xs)
opt_s <- optimize(function(l) psfit(Bs, ys, 10^l)$gcv, c(-4, 4))
fit_s <- psfit(Bs, ys, 10^opt_s$minimum)
c(edf = fit_s$edf, sigma_hat = fit_s$sigma, rmse_vs_truth = sqrt(mean((fit_s$f - fs)^2)))

