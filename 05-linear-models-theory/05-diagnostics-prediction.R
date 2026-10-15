# Session 05 — Diagnostics and prediction
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Same code as 05-diagnostics-prediction.Rmd. Run from r-examples/:  Rscript 05-diagnostics-prediction.R



## ----fit----------------------------------------------------------------------
library(faraway)
data(savings)
fit <- lm(sr ~ pop15 + pop75 + dpi + ddpi, data = savings)
n <- nrow(savings); p <- length(coef(fit))


## ----residual-plots, fig.width=8, fig.height=4--------------------------------
par(mfrow = c(1, 2))
plot(fitted(fit), resid(fit), xlab = "Fitted", ylab = "Residuals")
abline(h = 0, lty = 2)
qqnorm(rstandard(fit)); qqline(rstandard(fit))


## ----leverage-----------------------------------------------------------------
h <- hatvalues(fit)
sum(h)                                  # = p
head(sort(h, decreasing = TRUE), 4)
names(h)[h > 2 * p / n]                 # rule of thumb 2p/n = 0.2


## ----residuals----------------------------------------------------------------
r <- rstandard(fit)
t_i <- rstudent(fit)
e <- resid(fit); s <- summary(fit)$sigma
max(abs(r - e / (s * sqrt(1 - h))))                       # check the formula
head(sort(abs(t_i), decreasing = TRUE), 3)
crit <- qt(1 - 0.05 / (2 * n), df = n - p - 1)            # Bonferroni, 5%
crit
any(abs(t_i) > crit)


## ----cook---------------------------------------------------------------------
D <- cooks.distance(fit)
max(abs(D - r^2 / p * h / (1 - h)))
round(head(sort(D, decreasing = TRUE), 5), 3)
# Leave Libya out and compare the coefficients
fit_noL <- update(fit, subset = rownames(savings) != "Libya")
round(cbind(all = coef(fit), without_Libya = coef(fit_noL)), 4)


## ----cook-plot, fig.width=7, fig.height=4-------------------------------------
plot(D, type = "h", ylab = "Cook's distance", xlab = "Index")
abline(h = 4 / n, lty = 2)
text(which(D > 4 / n), D[D > 4 / n], names(D)[D > 4 / n], pos = 2, cex = 0.8)


## ----vif----------------------------------------------------------------------
car::vif(fit)
# VIF for pop75 by its definition 1 / (1 - R_j^2)
R2_75 <- summary(lm(pop75 ~ pop15 + dpi + ddpi, data = savings))$r.squared
1 / (1 - R2_75)


## ----prediction---------------------------------------------------------------
x0 <- data.frame(pop15 = 35, pop75 = 2, dpi = 1000, ddpi = 3)
predict(fit, x0, interval = "confidence")
predict(fit, x0, interval = "prediction")
# by hand
X <- model.matrix(fit)
x0v <- c(1, 35, 2, 1000, 3)
q <- drop(t(x0v) %*% solve(crossprod(X), x0v))     # x0'(X'X)^{-1} x0
s <- summary(fit)$sigma; yhat <- sum(x0v * coef(fit)); tc <- qt(0.975, n - p)
c(q = q, se_mean = s * sqrt(q), se_pred = s * sqrt(1 + q))
yhat + c(-1, 1) * tc * s * sqrt(q)
yhat + c(-1, 1) * tc * s * sqrt(1 + q)

