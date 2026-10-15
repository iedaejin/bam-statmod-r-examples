#' ---
#' title: "Session 24 — Bases, penalties, identifiability, PIRLS and edf"
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
library(MASS)
aq <- na.omit(airquality[, c("Ozone", "Solar.R", "Wind", "Temp")])
aq$ly <- log(aq$Ozone)

#' 
#' ## 1. A smooth is a basis plus a penalty
#' 
#' `smoothCon()` builds what `gam()` uses internally: the basis matrix `X`
#' and the penalty matrix `S` with $\int f''(x)^2dx=\boldsymbol\beta^\top S\boldsymbol\beta$.
#' 
## ----basis--------------------------------------------------------------------
sm_raw <- smoothCon(s(Temp, k = 10), data = aq, absorb.cons = FALSE)[[1]]
dim(sm_raw$X)                       # 111 x 10
dim(sm_raw$S[[1]])                  # 10 x 10
ev <- eigen(sm_raw$S[[1]], symmetric = TRUE)$values
sum(ev < max(ev) * 1e-10)           # null space of the penalty: 2 (constant, linear)

#' 
#' ## 2. Identifiability: the constant is in every basis
#' 
## ----ident--------------------------------------------------------------------
X_raw <- cbind(1, sm_raw$X)
c(columns = ncol(X_raw), rank = qr(X_raw)$rank)     # 11 columns, rank 10
# The constant function lies in the span of the raw basis:
sum(resid(lm(rep(1, nrow(aq)) ~ sm_raw$X - 1))^2)  # numerically 0
sm_con <- smoothCon(s(Temp, k = 10), data = aq, absorb.cons = TRUE)[[1]]
X_con <- cbind(1, sm_con$X)
c(columns = ncol(X_con), rank = qr(X_con)$rank)     # 10 columns, rank 10
range(colSums(sm_con$X))                            # sum-to-zero columns

#' 
#' `mgcv` imposes $\mathbf 1^\top X_j\boldsymbol\beta_j=0$ by reparametrising
#' $\boldsymbol\beta_j=Z\boldsymbol\beta_j^*$ with $Z$ spanning the null space of
#' $C=\mathbf 1^\top X_j$ (a QR decomposition). One column is lost, so `k = 10`
#' gives at most $k'=9$ degrees of freedom.
#' 
#' ## 3. Penalized least squares and edf for a single smooth
#' 
## ----pls----------------------------------------------------------------------
f0 <- gam(ly ~ s(Temp), data = aq, method = "REML")
X  <- model.matrix(f0); p <- ncol(X); y <- aq$ly
S  <- matrix(0, p, p); S[2:p, 2:p] <- f0$sp * f0$smooth[[1]]$S[[1]]
beta <- solve(crossprod(X) + S, crossprod(X, y))
max(abs(beta - coef(f0)))                           # same estimate
F <- solve(crossprod(X) + S, crossprod(X))          # F = (X'X + S)^{-1} X'X
c(trF = sum(diag(F)), sum_edf = sum(f0$edf),
  trA = sum(influence(f0)))                         # all equal

#' 
#' edf of the smooth alone: the sum of the diagonal of $F$ over its coefficients.
#' 
## ----edf-term-----------------------------------------------------------------
ii <- f0$smooth[[1]]$first.para:f0$smooth[[1]]$last.para
sum(diag(F)[ii]); summary(f0)$edf

#' 
#' ## 4. Posterior covariance
#' 
#' $V_\beta=(X^\top X+S_\lambda)^{-1}\hat\sigma^2$ (Gaussian case):
#' 
## ----vp-----------------------------------------------------------------------
Vb <- solve(crossprod(X) + S) * f0$sig2
max(abs(Vb - vcov(f0)))

#' 
#' ## 5. The REML score by hand
#' 
#' For the Gaussian additive model (Wood 2011), with $M_p$ the dimension of the
#' penalty null space,
#' $$2\mathcal V_R(\lambda)=\frac{\lVert y-X\hat\beta\rVert^2+\hat\beta^\top S_\lambda\hat\beta}{\sigma^2}
#' +\log|X^\top X+S_\lambda|-\log|S_\lambda|_+ +(n-M_p)\log(2\pi\sigma^2).$$
#' 
## ----reml---------------------------------------------------------------------
g <- gam(ly ~ s(Solar.R) + s(Wind) + s(Temp), data = aq, method = "REML")
X <- model.matrix(g); p <- ncol(X); n <- nrow(X)
Sl <- matrix(0, p, p)
for (j in seq_along(g$smooth)) {
  sm <- g$smooth[[j]]; ii <- sm$first.para:sm$last.para
  Sl[ii, ii] <- g$sp[j] * sm$S[[1]]
}
b <- coef(g); s2 <- g$sig2
rss <- sum((y - X %*% b)^2); pen <- drop(t(b) %*% Sl %*% b)
ev <- eigen(Sl, symmetric = TRUE, only.values = TRUE)$values
ev <- ev[ev > max(ev) * 1e-10]; Mp <- p - length(ev)
VR <- 0.5 * ((rss + pen) / s2 + determinant(crossprod(X) + Sl)$modulus -
             sum(log(ev)) + (n - Mp) * log(2 * pi * s2))
c(by_hand = VR, mgcv = g$gcv.ubre, Mp = Mp)

#' 
#' ## 6. PIRLS by hand for a binomial GAM
#' 
#' With the smoothing parameters fixed at the values `gam()` chose, iterate
#' $\boldsymbol\beta^{[r+1]}=(X^\top WX+S_\lambda)^{-1}X^\top W\boldsymbol z$ with
#' $w_i=\mu_i(1-\mu_i)$ and $z_i=\eta_i+(y_i-\mu_i)/w_i$ (logit link).
#' 
## ----pirls--------------------------------------------------------------------
pima <- rbind(Pima.tr, Pima.te)
mb <- gam(type ~ s(glu) + s(bmi) + s(age) + s(ped), family = binomial,
          data = pima, method = "REML")
X <- model.matrix(mb); p <- ncol(X); yb <- as.numeric(pima$type == "Yes")
Sl <- matrix(0, p, p)
for (j in seq_along(mb$smooth)) {
  sm <- mb$smooth[[j]]; ii <- sm$first.para:sm$last.para
  Sl[ii, ii] <- mb$sp[j] * sm$S[[1]]
}
beta <- rep(0, p)
for (it in 1:50) {
  eta <- drop(X %*% beta); mu <- plogis(eta)
  w <- mu * (1 - mu); z <- eta + (yb - mu) / w
  beta_new <- drop(solve(crossprod(X, w * X) + Sl, crossprod(X, w * z)))
  done <- max(abs(beta_new - beta)) < 1e-10
  beta <- beta_new
  if (done) break
}
c(iterations = it, max_diff = max(abs(beta - coef(mb))))
F <- solve(crossprod(X, w * X) + Sl, crossprod(X, w * X))
sapply(mb$smooth, function(sm) sum(diag(F)[sm$first.para:sm$last.para]))
summary(mb)$edf

