#' ---
#' title: "Session 27 — Random effects inside GAMs: Oxboys growth curves"
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
## ----data---------------------------------------------------------------------
library(mgcv)
library(nlme)
ox <- as.data.frame(nlme::Oxboys)            # 26 boys x 9 occasions
ox$Subject <- factor(as.character(ox$Subject))
str(ox)

#' 
#' `age` is standardised (from −1 to 1); `height` is in cm.
#' 
#' ## 1. Population smooth + random intercepts: `s(Subject, bs = "re")`
#' 
#' A `bs = "re"` term has an identity penalty: its coefficients behave like
#' iid $N(0,\sigma_b^2)$ random effects, and REML estimates $\sigma_b^2$.
#' 
## ----re-----------------------------------------------------------------------
m1 <- gam(height ~ s(age) + s(Subject, bs = "re"), data = ox, method = "REML")
summary(m1)$s.table
gam.vcomp(m1)

#' 
#' The same model with `gamm()` (an `lme` fit underneath):
#' 
## ----re-gamm------------------------------------------------------------------
g1 <- gamm(height ~ s(age), random = list(Subject = ~1), data = ox, method = "REML")
VarCorr(g1$lme)[c("(Intercept)", "Residual"), ]

#' 
#' Both give $\hat\sigma_b = 8.10$ cm between boys and $\hat\sigma = 1.28$ cm
#' within boys.
#' 
#' ## 2. Random slopes
#' 
## ----slopes-------------------------------------------------------------------
m2 <- gam(height ~ s(age) + s(Subject, bs = "re") + s(Subject, age, bs = "re"),
          data = ox, method = "REML")
gam.vcomp(m2)

#' 
#' In `gam()` the random intercepts and slopes are independent. `gamm()` and
#' `gamm4()` allow a correlation:
#' 
## ----slopes-gamm4-------------------------------------------------------------
library(gamm4)
g4 <- gamm4(height ~ s(age), random = ~ (1 + age | Subject), data = ox, REML = TRUE)
lme4::VarCorr(g4$mer)
summary(g4$gam)$s.table

#' 
#' ## 3. Subject-specific smooth curves: factor-smooth interaction `bs = "fs"`
#' 
## ----fs-----------------------------------------------------------------------
m3 <- gam(height ~ s(age, k = 5) + s(age, Subject, bs = "fs", k = 5),
          data = ox, method = "REML")
summary(m3)$s.table
AIC(m1, m2, m3)

#' 
#' ## 4. Population-level and subject-level predictions
#' 
## ----predict------------------------------------------------------------------
nd <- data.frame(age = seq(-1, 1, length.out = 50), Subject = ox$Subject[1])
pop <- predict(m3, nd, exclude = "s(age,Subject)")      # population curve
sub <- predict(m3, nd)                                  # this boy's curve
plot(height ~ age, data = ox, col = "grey70", pch = 16, cex = 0.6)
lines(nd$age, pop, lwd = 3, col = "navy")
lines(nd$age, sub, lwd = 2, col = "red")
points(height ~ age, data = subset(ox, Subject == ox$Subject[1]), col = "red", pch = 16)

#' 
#' ## 5. Diagnostics
#' 
## ----diag---------------------------------------------------------------------
r1 <- residuals(m1); r2 <- residuals(m2)
lag1 <- function(r) {                   # within-boy lag-1 correlation
  d <- split(r, ox$Subject)
  cor(unlist(lapply(d, function(v) v[-length(v)])), unlist(lapply(d, function(v) v[-1])))
}
c(random_intercept = lag1(r1), random_slope = lag1(r2))
qqnorm(coef(m1)[grep("Subject", names(coef(m1)))], main = "Predicted random intercepts")
qqline(coef(m1)[grep("Subject", names(coef(m1)))])

#' 
#' Random intercepts alone leave strong within-boy correlation (0.77):
#' boys grow at different rates. Random slopes remove most of it (0.10).
