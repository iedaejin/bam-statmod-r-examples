# Session 05 — Least squares in matrix form
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Same code as 05-least-squares.Rmd. Run from r-examples/:  Rscript 05-least-squares.R



## ----data---------------------------------------------------------------------
library(faraway)
data(savings)
head(savings, 3)
dim(savings)


## ----normal-equations---------------------------------------------------------
fit <- lm(sr ~ pop15 + pop75 + dpi + ddpi, data = savings)
X <- model.matrix(fit)          # 50 x 5
y <- savings$sr
n <- nrow(X); p <- ncol(X)
XtX <- crossprod(X)             # X'X, cost O(n p^2)
Xty <- crossprod(X, y)          # X'y
beta_hat <- solve(XtX, Xty)     # solves the system; never use solve(XtX) %*% Xty
cbind(normal_eq = drop(beta_hat), lm = coef(fit))


## ----hat-matrix---------------------------------------------------------------
H <- X %*% solve(XtX, t(X))
max(abs(H - t(H)))              # symmetric
max(abs(H %*% H - H))           # idempotent
sum(diag(H))                    # trace = p = 5
max(abs(H %*% y - fitted(fit))) # fitted values are H y
e <- resid(fit)
max(abs(crossprod(X, e)))       # residuals orthogonal to every column of X
sum(e)                          # so they sum to zero (intercept column)


## ----qr-----------------------------------------------------------------------
qrX <- qr(X)
R <- qr.R(qrX); Q <- qr.Q(qrX)
beta_qr <- backsolve(R, crossprod(Q, y))
drop(beta_qr)
kappa(X, exact = TRUE)^2
kappa(XtX, exact = TRUE)


## ----rank-deficient-----------------------------------------------------------
savings$pop_rest <- 100 - savings$pop15 - savings$pop75   # % aged 15--75
fit_bad <- lm(sr ~ pop15 + pop75 + pop_rest + dpi + ddpi, data = savings)
coef(fit_bad)                                  # one coefficient is NA
max(abs(fitted(fit_bad) - fitted(fit)))         # same fitted values

