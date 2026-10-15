# 17-poisson-olre.R --- plain-script version of 17-poisson-olre.Rmd
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Run from the r-examples/ folder:  Rscript 17-poisson-olre.R

#' ---
#' title: "Session 17 — Poisson GLMM with an observation-level random effect"
#' author: "Prof. Dae-Jin Lee (daelee@faculty.ie.edu)"
#' output: html_document
#' ---
#' 

#' 
#' `grouseticks` (package `lme4`): number of ticks on the heads of 403 red grouse
#' chicks, from 118 broods at 63 locations, over three years, with the altitude
#' (`HEIGHT`, m) of the location. Chicks are nested in broods; broods are in
#' locations.
#' 
## ----data---------------------------------------------------------------------
library(lme4)
data(grouseticks)
gt <- grouseticks
gt$HEIGHT_s <- as.numeric(scale(gt$HEIGHT))   # standardised altitude
str(gt)
c(mean = mean(gt$TICKS), var = var(gt$TICKS))

#' 
#' ## Poisson GLMM with brood and location effects
#' 
#' $\log E[y_{k}\mid b] = x_k^\top\beta + b_{\text{brood}(k)} + b_{\text{loc}(k)}$.
#' 
## ----p0-----------------------------------------------------------------------
fit0 <- glmer(TICKS ~ YEAR + HEIGHT_s + (1 | LOCATION) + (1 | BROOD),
              family = poisson, data = gt)
pearson_disp <- function(fit) sum(residuals(fit, type = "pearson")^2) / df.residual(fit)
pearson_disp(fit0)        # > 1: overdispersion remains at the chick level

#' 
#' ## Add an observation-level random effect (OLRE)
#' 
#' `INDEX` has one level per chick, so `(1 | INDEX)` adds
#' $e_k \sim N(0, \sigma_e^2)$ to every linear predictor: a Poisson--lognormal
#' model, $\Var(y_k\mid b) = \mu_k + \mu_k^2(e^{\sigma_e^2} - 1)$ approximately.
#' 
## ----p1-----------------------------------------------------------------------
fit1 <- glmer(TICKS ~ YEAR + HEIGHT_s + (1 | LOCATION) + (1 | BROOD) + (1 | INDEX),
              family = poisson, data = gt)
summary(fit1)
pearson_disp(fit1)        # no longer > 1 (Pearson residuals now include the OLRE)

#' 
#' ## Compare
#' 
## ----compare------------------------------------------------------------------
anova(fit0, fit1)          # boundary: halve the p-value (mixture of chi2_0 and chi2_1)
fit_glm <- glm(TICKS ~ YEAR + HEIGHT_s, family = poisson, data = gt)   # ignores everything
pearson_disp(fit_glm)
round(rbind(glm = coef(fit_glm), without_OLRE = fixef(fit0), with_OLRE = fixef(fit1)), 3)
round(rbind(glm = sqrt(diag(vcov(fit_glm))), without_OLRE = sqrt(diag(vcov(fit0))),
            with_OLRE = sqrt(diag(vcov(fit1)))), 3)

#' 
#' The plain Poisson GLM is badly overdispersed and its standard errors are far
#' too small. Brood and location effects absorb most of the extra variation; the
#' OLRE removes what is left at the chick level (AIC drops by about 193) while
#' leaving the fixed effects and their standard errors almost unchanged here.
#' The Pearson dispersion of the OLRE model (0.41) is not a sign of
#' underdispersion: its Pearson residuals are conditional on the fitted
#' chick-level effects, so it is no longer a useful check.
#' 
#' With the OLRE model, the effect of altitude is $e^{-0.854} = 0.43$: for chicks
#' with the same random effects, one SD (`r round(sd(gt$HEIGHT), 1)` m) higher
#' altitude multiplies the expected number of ticks by about 0.43.
