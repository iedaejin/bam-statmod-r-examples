# 17-cbpp-glmm.R --- plain-script version of 17-cbpp-glmm.Rmd
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Run from the r-examples/ folder:  Rscript 17-cbpp-glmm.R

#' ---
#' title: "Session 17 — A binomial GLMM: cbpp"
#' author: "Prof. Dae-Jin Lee (daelee@faculty.ie.edu)"
#' output: html_document
#' ---
#' 

#' 
#' `cbpp` (package `lme4`): new serological cases of contagious bovine
#' pleuropneumonia (`incidence`) out of `size` animals, in 15 herds followed over
#' 4 periods (56 herd-periods; herd 8 has only one period).
#' 
## ----data---------------------------------------------------------------------
library(lme4)
data(cbpp)
str(cbpp)
table(cbpp$herd)

#' 
#' ## A binomial GLM ignores the herds
#' 
## ----glm----------------------------------------------------------------------
fit_glm <- glm(cbind(incidence, size - incidence) ~ period, family = binomial, data = cbpp)
coef(fit_glm)
# Pearson dispersion: well above 1, a sign of extra-binomial (herd) variation
sum(residuals(fit_glm, type = "pearson")^2) / df.residual(fit_glm)

#' 
#' ## The GLMM: a random intercept for herd
#' 
#' $\mathrm{logit}\,P(\text{case}\mid b_{0i}) = \beta_0 + \beta_{\text{period}} + b_{0i}$,
#' $b_{0i}\sim N(0, \sigma_b^2)$, i.e. $E[y\mid b] = g^{-1}(X\beta + Zb)$ with the logit link.
#' 
## ----glmer--------------------------------------------------------------------
fit_lap <- glmer(cbind(incidence, size - incidence) ~ period + (1 | herd),
                 family = binomial, data = cbpp)          # Laplace (nAGQ = 1)
summary(fit_lap)

#' 
#' ## Laplace vs adaptive Gauss--Hermite quadrature
#' 
## ----nagq---------------------------------------------------------------------
fits <- lapply(c(1, 2, 5, 10, 25), function(q) update(fit_lap, nAGQ = q))
tab <- t(sapply(fits, function(f) c(fixef(f), sd_herd = attr(VarCorr(f)$herd, "stddev"))))
rownames(tab) <- paste0("nAGQ=", c(1, 2, 5, 10, 25))
round(tab, 4)

#' 
#' Estimates hardly change. Note: `lme4` reports log-likelihoods on different
#' scales for `nAGQ = 1` and `nAGQ > 1`, so compare estimates, not `logLik()`
#' values, across `nAGQ`.
#' 
#' ## Penalized quasi-likelihood (for comparison only)
#' 
## ----pql----------------------------------------------------------------------
library(MASS)
fit_pql <- glmmPQL(cbind(incidence, size - incidence) ~ period, random = ~ 1 | herd,
                   family = binomial, data = cbpp, verbose = FALSE)
fixef(fit_pql)
VarCorr(fit_pql)

#' 
#' PQL pulls the estimates towards zero (here $\hat\sigma_b = 0.56$ against 0.64);
#' it is known to be biased for binary data and small clusters.
#' 
#' ## Conditional (herd-specific) interpretation
#' 
## ----conditional--------------------------------------------------------------
exp(fixef(fit_lap))      # odds ratios for a given herd (b fixed)

#' 
#' For a given herd, the odds of a new case in period 2 are
#' $e^{-0.992} = 0.37$ times the odds in period 1.
#' 
#' ## Marginal (population-averaged) probabilities
#' 
#' Average the herd-specific probability over $b\sim N(0, \hat\sigma_b^2)$.
#' 
## ----marginal-----------------------------------------------------------------
sb  <- attr(VarCorr(fit_lap)$herd, "stddev")
eta <- fixef(fit_lap)[1] + c(0, fixef(fit_lap)[-1])          # linear predictor per period
p_cond <- plogis(eta)                                         # typical herd (b = 0)
p_marg <- sapply(eta, function(e)
  integrate(function(b) plogis(e + b) * dnorm(b, 0, sb), -Inf, Inf)$value)
p_obs  <- with(cbpp, tapply(incidence, period, sum) / tapply(size, period, sum))
round(rbind(conditional_b0 = p_cond, marginal = p_marg, observed = p_obs), 4)

#' 
#' The approximation $\beta_M \approx \beta_C/\sqrt{1 + 0.346\sigma_b^2}$:
#' 
## ----attenuation--------------------------------------------------------------
fixef(fit_lap) / sqrt(1 + 0.346 * sb^2)

#' 
#' ## Is there herd-to-herd variation? (boundary LRT)
#' 
## ----lrt-herd-----------------------------------------------------------------
T <- as.numeric(2 * (logLik(fit_lap) - logLik(fit_glm)))
c(T = T, p_mixture = 0.5 * pchisq(T, 1, lower.tail = FALSE))

#' 
#' ## Is there a period effect? (LRT, same random part)
#' 
## ----lrt-period---------------------------------------------------------------
anova(update(fit_lap, . ~ . - period), fit_lap)

#' 
#' ## Predicted herd effects
#' 
## ----ranef--------------------------------------------------------------------
round(ranef(fit_lap)$herd, 3)

