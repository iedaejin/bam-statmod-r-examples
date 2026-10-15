# Session 06 — Ridge, lasso and elastic net with glmnet
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Same code as 06-regularization.Rmd. Run from r-examples/:  Rscript 06-regularization.R



## ----data---------------------------------------------------------------------
library(faraway)
library(glmnet)
data(prostate)
x <- as.matrix(prostate[, names(prostate) != "lpsa"])   # glmnet needs a matrix
y <- prostate$lpsa
n <- nrow(x)


## ----cv-----------------------------------------------------------------------
set.seed(606)
foldid <- sample(rep(1:10, length.out = n))
cv_lasso <- cv.glmnet(x, y, alpha = 1, foldid = foldid)
c(lambda_min = cv_lasso$lambda.min, lambda_1se = cv_lasso$lambda.1se)
round(cbind(min = coef(cv_lasso, s = "lambda.min")[, 1],
            se1 = coef(cv_lasso, s = "lambda.1se")[, 1],
            ols = coef(lm(lpsa ~ ., data = prostate))), 4)
plot(cv_lasso)


## ----paths, fig.width=9, fig.height=4-----------------------------------------
par(mfrow = c(1, 2))
plot(glmnet(x, y, alpha = 1), xvar = "lambda", label = TRUE, main = "lasso")
plot(glmnet(x, y, alpha = 0), xvar = "lambda", label = TRUE, main = "ridge")


## ----alpha-grid---------------------------------------------------------------
alphas <- c(0, 0.25, 0.5, 0.75, 1)
cvm_min <- sapply(alphas, function(a) min(cv.glmnet(x, y, alpha = a, foldid = foldid)$cvm))
round(setNames(cvm_min, paste0("alpha=", alphas)), 4)


## ----standardize--------------------------------------------------------------
x_cm <- x; x_cm[, "lweight"] <- x_cm[, "lweight"] * 100   # rescale one column
b1 <- coef(glmnet(x, y, alpha = 1, lambda = 0.1))[, 1]
b2 <- coef(glmnet(x_cm, y, alpha = 1, lambda = 0.1))[, 1]
b3 <- coef(glmnet(x_cm, y, alpha = 1, lambda = 0.1, standardize = FALSE))[, 1]
round(cbind(original = b1, rescaled_std = b2 * c(1, 1, 100, rep(1, 6)),
            rescaled_nostd = b3 * c(1, 1, 100, rep(1, 6))), 4)


## ----kkt----------------------------------------------------------------------
lam <- 0.05
f <- glmnet(x, y, alpha = 1, lambda = lam, standardize = FALSE,
            control = list(thresh = 1e-16))
b <- coef(f)[-1, 1]
g <- drop(crossprod(x, y - predict(f, x))) / n
round(cbind(beta = b, gradient = g), 4)


## ----ridge-closed-form--------------------------------------------------------
s_y <- sqrt(mean((y - mean(y))^2))
xc <- scale(x, scale = FALSE); yc <- y - mean(y)
fr <- glmnet(x, y, alpha = 0, lambda = 0.5, standardize = FALSE,
             control = list(thresh = 1e-16))
closed <- solve(crossprod(xc) + n * 0.5 / s_y * diag(ncol(x)), crossprod(xc, yc))
round(cbind(glmnet = coef(fr)[-1, 1], closed_form = drop(closed)), 5)

