#' ---
#' title: "Session 25 — Tensor products, ANOVA decompositions and model comparison"
#' subtitle: "Statistical Modelling (BAM), IE University"
#' author: "Prof. Dae-Jin Lee (daelee@faculty.ie.edu)"
#' date: "Spring 2027"
#' output: html_document
#' ---
#' 
## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE,
                      fig.width = 7, fig.height = 5)

#' 
## ----data---------------------------------------------------------------------
library(mgcv)
aq <- na.omit(airquality[, c("Ozone", "Solar.R", "Wind", "Temp")])
cor(aq$Temp, aq$Wind)

#' 
#' ## 1. Additive model versus tensor-product interaction
#' 
## ----te-----------------------------------------------------------------------
add <- gam(log(Ozone) ~ s(Solar.R) + s(Wind) + s(Temp), data = aq, method = "REML")
te1 <- gam(log(Ozone) ~ s(Solar.R) + te(Temp, Wind), data = aq, method = "REML")
summary(te1)
AIC(add, te1)

#' 
#' `te(Temp, Wind)` uses the product of two marginal bases (default 5 cubic
#' regression spline functions each, so 25 coefficients minus 1 constraint) and
#' two smoothing parameters, one per direction.
#' 
## ----te-sp--------------------------------------------------------------------
te1$sp                         # one lambda for Temp, one for Wind (plus Solar.R)

#' 
#' ## 2. Scale invariance: `te()` versus an isotropic `s(Temp, Wind)`
#' 
#' An isotropic thin-plate smooth penalises wiggliness equally in every
#' direction, so it depends on the units of the covariates. A tensor product
#' does not.
#' 
## ----units--------------------------------------------------------------------
aq$TempC <- (aq$Temp - 32) * 5 / 9      # Celsius
aq$Windk <- aq$Wind * 1.609             # km/h
iso_F <- gam(log(Ozone) ~ s(Solar.R) + s(Temp, Wind), data = aq, method = "REML")
iso_C <- gam(log(Ozone) ~ s(Solar.R) + s(TempC, Windk), data = aq, method = "REML")
te_C  <- gam(log(Ozone) ~ s(Solar.R) + te(TempC, Windk), data = aq, method = "REML")
AIC(iso_F, iso_C, te1, te_C)

#' 
#' Changing the units changes the isotropic fit; the tensor-product fit is identical.
#' 
#' ## 3. ANOVA decomposition with `ti()`
#' 
#' $$\eta = \beta_0 + f_S(\text{Solar.R}) + f_W(\text{Wind}) + f_T(\text{Temp}) + f_{TW}(\text{Temp},\text{Wind})$$
#' 
#' `ti()` builds the interaction from marginal bases that already satisfy the
#' sum-to-zero constraint, so it excludes the main effects.
#' 
## ----ti-----------------------------------------------------------------------
ti1 <- gam(log(Ozone) ~ s(Solar.R) + s(Wind) + s(Temp) + ti(Temp, Wind),
           data = aq, method = "REML")
summary(ti1)$s.table
AIC(add, te1, ti1)

#' 
#' The `ti` term has $p = 0.0008$: evidence that the effect of temperature
#' depends on wind. Its main effect `s(Wind)` is not significant *given* the
#' interaction. Main effects in the presence of an interaction depend on the
#' constraints, so read them together with the interaction.
#' 
#' ## 4. Model comparison: AIC and approximate tests
#' 
## ----compare------------------------------------------------------------------
# Likelihood-based comparison of nested models: fit both by ML
add_ml <- gam(log(Ozone) ~ s(Solar.R) + s(Wind) + s(Temp), data = aq, method = "ML")
ti_ml  <- gam(log(Ozone) ~ s(Solar.R) + s(Wind) + s(Temp) + ti(Temp, Wind),
              data = aq, method = "ML")
anova(add_ml, ti_ml, test = "F")
# The same call on REML fits gives a different answer
anova(add, ti1, test = "F")

#' 
#' Both tests are approximate: the degrees of freedom are effective degrees of
#' freedom and the smoothing parameters are treated as known. Use them as a
#' guide together with AIC and the plots.
#' 
#' ## 5. Visualising the interaction
#' 
## ----vis----------------------------------------------------------------------
vis.gam(te1, view = c("Temp", "Wind"), plot.type = "contour", too.far = 0.1,
        color = "topo", main = "te(Temp, Wind): linear predictor")
points(aq$Temp, aq$Wind, pch = 16, cex = 0.5)
vis.gam(ti1, view = c("Temp", "Wind"), theta = 35, phi = 25, too.far = 0.1,
        color = "topo", ticktype = "detailed")

