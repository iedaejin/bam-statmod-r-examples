#' ---
#' title: "Session 27 — A penalized spline is a mixed model"
#' subtitle: "Statistical Modelling (BAM), IE University"
#' author: "Prof. Dae-Jin Lee (daelee@faculty.ie.edu)"
#' date: "Spring 2027"
#' output: html_document
#' ---
#' 
## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE,
                      fig.width = 7, fig.height = 4)

#' 
## ----packages-----------------------------------------------------------------
library(mgcv)
library(nlme)
library(splines)
aq <- na.omit(airquality[, c("Ozone", "Solar.R", "Wind", "Temp")])
y <- log(aq$Ozone); x <- aq$Temp; n <- length(y)

#' 
#' ## 1. P-spline basis and penalty
#' 
#' Cubic B-splines on 17 equal segments ($K=20$) and a second-order difference penalty.
#' 
## ----basis--------------------------------------------------------------------
nseg <- 17; deg <- 3
dx <- diff(range(x)) / nseg
knots <- seq(min(x) - deg * dx, max(x) + deg * dx, by = dx)
B <- splineDesign(knots, x, ord = deg + 1, outer.ok = TRUE)
K <- ncol(B); K
D <- diff(diag(K), differences = 2)
S <- crossprod(D)                       # S = D'D, rank K - 2

#' 
#' ## 2. Penalized fit with REML (`gam` with a supplied penalty)
#' 
#' `paraPen` lets `gam()` use our own model matrix and penalty, so its
#' smoothing parameter is on exactly the scale of
#' $\lVert y-B\beta\rVert^2+\lambda\,\beta^\top S\beta$.
#' 
## ----gam----------------------------------------------------------------------
fit_pen <- gam(y ~ B - 1, paraPen = list(B = list(S)), method = "REML")
c(lambda = fit_pen$sp, edf = sum(fit_pen$edf))

#' 
#' ## 3. Mixed-model reparametrisation: X = [1, x], Z = B U Σ^{-1/2}
#' 
#' Eigen-decompose $S=U\Sigma U^\top$. The two zero eigenvalues span the null
#' space (constant and linear coefficient sequences); the others are positive.
#' 
## ----reparam------------------------------------------------------------------
e <- eigen(S, symmetric = TRUE)
pos <- e$values > 1e-8
c(positive = sum(pos), zero = sum(!pos))
U_pos <- e$vectors[, pos]; Sig <- e$values[pos]
U_null <- e$vectors[, !pos]
# B U_null spans the same space as [1, x]:
c(summary(lm(B %*% U_null[, 1] ~ x))$r.squared, summary(lm(B %*% U_null[, 2] ~ x))$r.squared)
X <- cbind(1, x)
Z <- B %*% U_pos %*% diag(1 / sqrt(Sig))

#' 
#' With $\beta = U_{0}\beta_F + U_{+}\Sigma_{+}^{-1/2} b$ the penalty becomes
#' $\beta^\top S\beta = b^\top b$, and $B\beta = X\beta_F^* + Zb$.
#' 
#' ## 4. Fit the mixed model with `lme()`
#' 
#' $y = X\beta_F + Zb + \varepsilon$, $b\sim N(0,\sigma_b^2 I)$,
#' $\varepsilon\sim N(0,\sigma^2 I)$. All observations are in one group, and
#' `pdIdent` gives the $K-2$ random coefficients a common variance.
#' 
## ----lme----------------------------------------------------------------------
g <- factor(rep(1, n))
fit_lme <- lme(y ~ x, random = list(g = pdIdent(~ Z - 1)), method = "REML")
sigma2   <- fit_lme$sigma^2
sigma2_b <- as.numeric(VarCorr(fit_lme)[1, "Variance"])
c(sigma2 = sigma2, sigma2_b = sigma2_b, lambda_lme = sigma2 / sigma2_b,
  lambda_gam = fit_pen$sp)
max(abs(fitted(fit_lme) - fitted(fit_pen)))   # same fitted curve

#' 
#' The REML estimate of the variance ratio equals the smoothing parameter
#' chosen by `gam(method = "REML")`.
#' 
#' ## 5. The same check with mgcv's own basis inside `gamm()`
#' 
#' `gamm()` does this reparametrisation internally. The random part of the
#' smooth appears in `$lme` as the block `Xr` of group `g`.
#' 
## ----gamm---------------------------------------------------------------------
fit_gamm <- gamm(y ~ s(x, bs = "ps", k = 20), method = "REML")
vc <- VarCorr(fit_gamm$lme)
sd_b <- as.numeric(vc[nrow(vc) - 1, "StdDev"])   # one of the Xr rows
sd_e <- fit_gamm$lme$sigma
c(ratio_from_lme = sd_e^2 / sd_b^2, sp_in_gam = unname(fit_gamm$gam$sp),
  edf = sum(fit_gamm$gam$edf))

#' 
#' `mgcv` rescales its penalty matrices, so its `sp` (about 6573) differs
#' from our 413, but the fitted curve and edf (about 3.0) are the same: only
#' the ratio $\sigma^2/\sigma_b^2$ for a given scaling of $S$ is meaningful.
#' 
#' ## 6. Plot
#' 
## ----plot---------------------------------------------------------------------
o <- order(x)
plot(x, y, col = "grey50", xlab = "Temp", ylab = "log(Ozone)")
lines(x[o], fitted(fit_lme)[o], lwd = 3, col = "navy")
lines(x[o], fitted(fit_pen)[o], lwd = 1, col = "red", lty = 2)
legend("topleft", c("lme (REML)", "gam with paraPen (REML)"),
       col = c("navy", "red"), lty = c(1, 2), lwd = c(3, 1), bty = "n")

