# Session 06 — Confounding, omitted-variable bias and collinearity
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Same code as 06-confounding.Rmd. Run from r-examples/:  Rscript 06-confounding.R



## ----data---------------------------------------------------------------------
library(faraway)
data(savings)
cor(savings$pop15, savings$pop75)


## ----ovb----------------------------------------------------------------------
short <- lm(sr ~ pop75, data = savings)          # omits pop15
long  <- lm(sr ~ pop75 + pop15, data = savings)
aux   <- lm(pop15 ~ pop75, data = savings)        # pop15 on pop75
coef(short); coef(long); coef(aux)


## ----ovb-identity-------------------------------------------------------------
coef(long)[["pop75"]] + coef(long)[["pop15"]] * coef(aux)[["pop75"]]
coef(short)[["pop75"]]


## ----fwl----------------------------------------------------------------------
ry <- resid(lm(sr ~ pop15, data = savings))
rx <- resid(lm(pop75 ~ pop15, data = savings))
coef(lm(ry ~ rx))[["rx"]]          # equals the pop75 coefficient in 'long'


## ----vif----------------------------------------------------------------------
fit <- lm(sr ~ pop15 + pop75 + dpi + ddpi, data = savings)
car::vif(fit)
R2_15 <- summary(lm(pop15 ~ pop75 + dpi + ddpi, data = savings))$r.squared
1 / (1 - R2_15)
# se(beta_j)^2 = sigma^2 / ((n-1) var(x_j)) * VIF_j
s <- summary(fit)$sigma; n <- nrow(savings)
sqrt(s^2 / ((n - 1) * var(savings$pop15)) * car::vif(fit)[["pop15"]])
coef(summary(fit))["pop15", "Std. Error"]

