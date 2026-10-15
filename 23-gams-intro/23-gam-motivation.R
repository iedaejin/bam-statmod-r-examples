#' ---
#' title: "Session 23 — Why additive models? LM residuals on airquality"
#' subtitle: "Statistical Modelling (BAM), IE University"
#' author: "Prof. Dae-Jin Lee (daelee@faculty.ie.edu)"
#' date: "Spring 2027"
#' output: html_document
#' ---
#' 
## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE,
                      fig.width = 8, fig.height = 4)

#' 
#' ## 1. The data
#' 
#' `airquality` (package `datasets`) has daily measurements in New York, May to
#' September 1973: mean ozone (ppb, 13:00–15:00), solar radiation (Langleys),
#' average wind speed (mph) and maximum temperature (°F).
#' 
## ----data---------------------------------------------------------------------
library(mgcv)
data(airquality)
dim(airquality)                 # 153 days, 6 variables
colSums(is.na(airquality))      # Ozone has 37 missing values, Solar.R 7
aq <- na.omit(airquality[, c("Ozone", "Solar.R", "Wind", "Temp")])
nrow(aq)                        # 111 complete cases for our model

#' 
#' ## 2. A linear model on the original scale
#' 
## ----lm-raw-------------------------------------------------------------------
lm_raw <- lm(Ozone ~ Solar.R + Wind + Temp, data = aq)
summary(lm_raw)$coefficients
par(mfrow = c(1, 2))
plot(fitted(lm_raw), resid(lm_raw), xlab = "Fitted", ylab = "Residual",
     main = "Curvature and a funnel")
abline(h = 0, lty = 2)
plot(aq$Temp, resid(lm_raw), xlab = "Temp", ylab = "Residual",
     main = "Residuals vs Temp")
lines(lowess(aq$Temp, resid(lm_raw)), col = "red", lwd = 2)

#' 
#' The residuals grow with the fitted value (variance increases with the mean)
#' and bend against `Temp`: the linear predictor misses a curved effect.
#' 
#' ## 3. Log scale: the funnel goes, the curvature stays
#' 
## ----lm-log-------------------------------------------------------------------
lm_log <- lm(log(Ozone) ~ Solar.R + Wind + Temp, data = aq)
par(mfrow = c(1, 3))
for (v in c("Solar.R", "Wind", "Temp")) {
  plot(aq[[v]], resid(lm_log), xlab = v, ylab = "Residual (log scale)")
  lines(lowess(aq[[v]], resid(lm_log)), col = "red", lwd = 2)
  abline(h = 0, lty = 2)
}

#' 
#' The lowess lines show a hump in `Solar.R` and curvature in `Wind`: a
#' straight line per covariate is too rigid.
#' 
#' ## 4. The additive model
#' 
#' $$\log(\text{Ozone}_i) = \beta_0 + f_1(\text{Solar.R}_i) + f_2(\text{Wind}_i) + f_3(\text{Temp}_i) + \varepsilon_i .$$
#' 
## ----gam----------------------------------------------------------------------
gam_log <- gam(log(Ozone) ~ s(Solar.R) + s(Wind) + s(Temp),
               data = aq, method = "REML")
summary(gam_log)
AIC(lm_log, gam_log)
par(mfrow = c(1, 3))
plot(gam_log, residuals = TRUE, shade = TRUE, pch = 16, cex = 0.6)

#' 
#' Each `edf` between 1.9 and 2.5 says that each effect is mildly non-linear.
#' AIC drops from 170.8 (linear) to 166.4 (additive). The same response
#' `log(Ozone)` is used in both models, so the AICs are comparable.
