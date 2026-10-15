#' ---
#' title: "Session 25 — Residual diagnostics, interpretation and visualisation"
#' subtitle: "Statistical Modelling (BAM), IE University"
#' author: "Prof. Dae-Jin Lee (daelee@faculty.ie.edu)"
#' date: "Spring 2027"
#' output: html_document
#' ---
#' 
## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE,
                      fig.width = 8, fig.height = 5)

#' 
## ----data---------------------------------------------------------------------
library(mgcv)
aq <- airquality
aq$day <- seq_len(nrow(aq))        # day of the season: 1 = 1 May 1973
aq <- na.omit(aq)
nrow(aq)
ti1 <- gam(log(Ozone) ~ s(Solar.R) + s(Wind) + s(Temp) + ti(Temp, Wind),
           data = aq, method = "REML")

#' 
#' ## 1. `gam.check()`
#' 
## ----check--------------------------------------------------------------------
set.seed(1)
gam.check(ti1)

#' 
#' The k-index of `s(Wind)` is now about 0.98 (it was 0.86 in the additive
#' model of Session 24): the pattern left along Wind was the missing
#' interaction, not a too-small $k$.
#' 
#' ## 2. Residuals against covariates, including ones not in the model
#' 
## ----resid-cov, fig.height = 6------------------------------------------------
r <- residuals(ti1, type = "deviance")
par(mfrow = c(2, 2))
for (v in c("Solar.R", "Wind", "Temp")) {
  plot(aq[[v]], r, xlab = v, ylab = "residual"); abline(h = 0, lty = 2)
  lines(lowess(aq[[v]], r), col = "red", lwd = 2)
}
boxplot(r ~ aq$Month, xlab = "Month", ylab = "residual")
anova(gam(r ~ factor(aq$Month)))          # no month effect left

#' 
#' ## 3. Residuals in time order
#' 
#' The days are consecutive, so check for serial correlation.
#' 
## ----time---------------------------------------------------------------------
plot(aq$day, r, xlab = "day of season", ylab = "residual")
lines(lowess(aq$day, r), col = "red", lwd = 2)
ok <- diff(aq$day) == 1                         # pairs of consecutive days
c(lag1_cor = cor(r[-length(r)][ok], r[-1][ok]), pairs = sum(ok))
summary(gam(r ~ s(day), data = data.frame(r, day = aq$day), method = "REML"))$s.table

#' 
#' A lag-1 correlation of 0.13 and no trend in time: little left to model here.
#' Stronger correlation would call for a correlation structure (Session 27,
#' `gamm(..., correlation = corAR1())`).
#' 
#' ## 4. Predictions on the response scale
#' 
#' Build intervals on the link scale, then transform. For a log response,
#' $e^{\hat\eta}$ estimates the median ozone.
#' 
## ----predict------------------------------------------------------------------
nd <- expand.grid(Temp = c(70, 80, 90), Wind = c(5, 10, 15),
                  Solar.R = median(aq$Solar.R))
pr <- predict(ti1, nd, se.fit = TRUE)
nd$median <- exp(pr$fit)
nd$lower  <- exp(pr$fit - 1.96 * pr$se.fit)
nd$upper  <- exp(pr$fit + 1.96 * pr$se.fit)
round(nd, 1)

#' 
#' ## 5. A contrast with its standard error
#' 
#' Effect of Temp 70 → 90 °F at two wind speeds, from the `lpmatrix`:
#' 
## ----contrast-----------------------------------------------------------------
contrast <- function(w) {
  X <- predict(ti1, data.frame(Temp = c(70, 90), Wind = w, Solar.R = 207),
               type = "lpmatrix")
  d <- X[2, ] - X[1, ]
  est <- sum(d * coef(ti1)); se <- sqrt(drop(t(d) %*% vcov(ti1) %*% d))
  exp(c(ratio = est, lower = est - 1.96 * se, upper = est + 1.96 * se))
}
rbind(wind_5 = contrast(5), wind_15 = contrast(15))

#' 
#' ## 6. Visualisation tools
#' 
## ----vis, fig.height = 4------------------------------------------------------
plot(ti1, pages = 1, scheme = 2, too.far = 0.1)   # all terms, heat map for ti
vis.gam(ti1, view = c("Temp", "Wind"), plot.type = "contour", too.far = 0.1)

#' 
#' With `gratia`:
#' 
## ----gratia, fig.height = 6---------------------------------------------------
library(gratia)
draw(ti1)
appraise(ti1)

