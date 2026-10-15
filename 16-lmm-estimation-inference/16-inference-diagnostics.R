# 16-inference-diagnostics.R --- plain-script version of 16-inference-diagnostics.Rmd
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Run from the r-examples/ folder:  Rscript 16-inference-diagnostics.R

#' ---
#' title: "Session 16 — Inference and diagnostics for LMMs"
#' author: "Prof. Dae-Jin Lee (daelee@faculty.ie.edu)"
#' output: html_document
#' ---
#' 

#' 
## ----data---------------------------------------------------------------------
library(lme4)
data(sleepstudy)
m_ri  <- lmer(Reaction ~ Days + (1 | Subject), data = sleepstudy)       # REML
m_ris <- lmer(Reaction ~ Days + (Days | Subject), data = sleepstudy)    # REML

#' 
#' ## Fixed effects: Wald t statistics
#' 
#' `lme4` prints $t = \hat\beta_k/\mathrm{se}(\hat\beta_k)$ but no p-value, because
#' the reference distribution is not exactly $t$ with a known df. With 18 subjects
#' the normal approximation is rough but the effect here is huge.
#' 
## ----wald---------------------------------------------------------------------
cf <- summary(m_ris)$coefficients
cbind(cf, p_normal = 2 * pnorm(-abs(cf[, "t value"])))

#' 
#' ## Fixed effects: likelihood ratio test needs ML fits
#' 
#' Models that differ in their fixed effects must be compared with ML, not REML.
#' 
## ----lrt-fixed----------------------------------------------------------------
m1_ml <- update(m_ris, REML = FALSE)
m0_ml <- update(m1_ml, . ~ . - Days)
anova(m0_ml, m1_ml)
# What NOT to do: a "LRT" from REML fits with different X
m0_reml <- update(m_ris, . ~ . - Days)
2 * (logLik(m_ris) - logLik(m0_reml))   # not a valid LRT statistic

#' 
#' `anova()` on two `lmer` fits refits them with ML automatically (the message
#' "refitting model(s) with ML"); use `refit = FALSE` only when the fixed effects
#' are the same.
#' 
#' ## Profile-likelihood confidence intervals
#' 
## ----confint------------------------------------------------------------------
confint(m_ris, method = "profile")

#' 
#' ## Testing a variance component: the boundary problem
#' 
#' $H_0: \sigma_b^2 = 0$ puts the parameter on the boundary of $[0, \infty)$.
#' The LRT statistic is then a 50:50 mixture of $\chi^2_0$ (a point mass at 0)
#' and $\chi^2_1$, so the p-value is half the naive one.
#' 
## ----lrt-intercept------------------------------------------------------------
m_lm <- lm(Reaction ~ Days, data = sleepstudy)
m_ri_ml <- update(m_ri, REML = FALSE)
T_int <- as.numeric(2 * (logLik(m_ri_ml) - logLik(m_lm)))
c(T = T_int, p_naive = pchisq(T_int, 1, lower.tail = FALSE),
  p_mixture = 0.5 * pchisq(T_int, 1, lower.tail = FALSE))

#' 
#' Random slope (with its correlation) against random intercept: same fixed
#' effects, so REML fits can be compared. Under $H_0$ the statistic is a 50:50
#' mixture of $\chi^2_1$ and $\chi^2_2$.
#' 
## ----lrt-slope----------------------------------------------------------------
a <- anova(m_ri, m_ris, refit = FALSE)
a
T_slope <- a$Chisq[2]
c(p_naive = pchisq(T_slope, 2, lower.tail = FALSE),
  p_mixture = 0.5 * pchisq(T_slope, 1, lower.tail = FALSE) +
              0.5 * pchisq(T_slope, 2, lower.tail = FALSE))

#' 
#' ## Checking the 50:50 mixture by simulation
#' 
#' Simulate from the fitted model *without* a random intercept and refit both.
#' 
## ----boundary-sim-------------------------------------------------------------
set.seed(2027)
sim_T <- replicate(300, {
  ys <- simulate(m_lm)[, 1]
  d  <- transform(sleepstudy, ys = ys)
  f1 <- suppressMessages(lmer(ys ~ Days + (1 | Subject), data = d, REML = FALSE))
  max(0, as.numeric(2 * (logLik(f1) - logLik(lm(ys ~ Days, data = d)))))
})
c(share_zero = mean(sim_T < 1e-6),            # close to 1/2
  q95_sim = unname(quantile(sim_T, 0.95)),    # compare with qchisq(0.90, 1) = 2.71
  q95_mixture = qchisq(0.90, 1))

#' 
#' ## AIC
#' 
## ----aic----------------------------------------------------------------------
m_unc <- lmer(Reaction ~ Days + (Days || Subject), data = sleepstudy)   # rho = 0
AIC(m_ri, m_unc, m_ris)      # REML fits: comparable because X is the same

#' 
#' ## Diagnostics at both levels
#' 
## ----diagnostics, fig.width = 9, fig.height = 7-------------------------------
res <- resid(m_ris)                 # conditional residuals y - X beta - Z b
fit <- fitted(m_ris)
re  <- ranef(m_ris)$Subject
op <- par(mfrow = c(2, 2))
plot(fit, res, xlab = "Fitted (subject-specific)", ylab = "Conditional residual")
abline(h = 0, lty = 2)
qqnorm(res, main = "Residuals"); qqline(res)
qqnorm(re[, 1], main = "BLUPs: intercepts"); qqline(re[, 1])
qqnorm(re[, 2], main = "BLUPs: slopes"); qqline(re[, 2])
par(op)
# Which observations have the largest standardised residuals?
head(sleepstudy[order(-abs(resid(m_ris, scaled = TRUE))), ], 3)

