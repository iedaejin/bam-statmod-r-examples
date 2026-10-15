# 18-lab-walkthrough.R --- plain-script version of 18-lab-walkthrough.Rmd
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Run from the r-examples/ folder:  Rscript 18-lab-walkthrough.R

#' ---
#' title: "Session 18 — Lab 04 walk-through: lmer, lme and glmer"
#' author: "Prof. Dae-Jin Lee (daelee@faculty.ie.edu)"
#' output: html_document
#' ---
#' 

#' 
#' The key code of Lab 04 (`R Labs/bam-statmod/Lab_04_Mixed_Models/`), with the
#' data loaded from `lme4` instead of the lab's CSV files.
#' 
## ----data---------------------------------------------------------------------
library(lme4)
library(nlme)            # lme(); masks lme4::lmList
data(sleepstudy, package = "lme4")
data(cbpp, package = "lme4")

#' 
#' ## 1. Pooling
#' 
## ----pooling------------------------------------------------------------------
fit_cp <- lm(Reaction ~ Days, data = sleepstudy)
fit_np <- lme4::lmList(Reaction ~ Days | Subject, data = sleepstudy)
fit_pp <- lmer(Reaction ~ Days + (Days | Subject), data = sleepstudy)
rbind(lm = summary(fit_cp)$coefficients[, 2], lmer = summary(fit_pp)$coefficients[, 2])

#' 
#' ## 2. lmer and lme agree
#' 
## ----lme----------------------------------------------------------------------
fit_lme <- lme(Reaction ~ Days, random = ~ Days | Subject, data = sleepstudy)
rbind(lmer = fixef(fit_pp), lme = fixef(fit_lme))
VarCorr(fit_lme)
fit_ri <- lmer(Reaction ~ Days + (1 | Subject), data = sleepstudy)
vc <- as.data.frame(VarCorr(fit_ri))$vcov
vc[1] / sum(vc)                                     # ICC

#' 
#' ## 3. REML vs ML and LRTs
#' 
## ----lrt----------------------------------------------------------------------
fit_pp_ml <- update(fit_pp, REML = FALSE)
rbind(REML = attr(VarCorr(fit_pp)$Subject, "stddev"),
      ML   = attr(VarCorr(fit_pp_ml)$Subject, "stddev"))
anova(update(fit_pp, . ~ . - Days), fit_pp)          # fixed effect: refits with ML
a <- anova(fit_ri, fit_pp, refit = FALSE)            # random slope: same X, REML ok
0.5 * pchisq(a$Chisq[2], 1, lower.tail = FALSE) + 0.5 * pchisq(a$Chisq[2], 2, lower.tail = FALSE)

#' 
#' ## 4. BLUPs and shrinkage
#' 
## ----blup---------------------------------------------------------------------
k <- 10 * vc[1] / (10 * vc[1] + vc[2])
raw <- tapply(sleepstudy$Reaction - model.matrix(~ Days, sleepstudy) %*% fixef(fit_ri),
              sleepstudy$Subject, mean)
head(cbind(raw, k * raw, blup = ranef(fit_ri)$Subject[, 1]), 3)

#' 
#' ## 5. Diagnostics
#' 
## ----diag, fig.width = 8, fig.height = 6--------------------------------------
re <- ranef(fit_pp)$Subject
op <- par(mfrow = c(2, 2))
plot(fitted(fit_pp), resid(fit_pp)); abline(h = 0, lty = 2)
qqnorm(resid(fit_pp)); qqline(resid(fit_pp))
qqnorm(re[, 1], main = "BLUP intercepts"); qqline(re[, 1])
qqnorm(re[, 2], main = "BLUP slopes"); qqline(re[, 2])
par(op)

#' 
#' ## 6. Binomial GLMM
#' 
## ----glmm---------------------------------------------------------------------
fit_lap <- glmer(cbind(incidence, size - incidence) ~ period + (1 | herd),
                 family = binomial, data = cbpp)
fit_agq <- update(fit_lap, nAGQ = 25)
rbind(Laplace = c(fixef(fit_lap), sd = attr(VarCorr(fit_lap)$herd, "stddev")),
      AGQ25   = c(fixef(fit_agq), sd = attr(VarCorr(fit_agq)$herd, "stddev")))
sb  <- attr(VarCorr(fit_lap)$herd, "stddev")
eta <- fixef(fit_lap)[1] + c(0, fixef(fit_lap)[-1])
rbind(typical = plogis(eta),
      average = sapply(eta, function(e)
        integrate(function(b) plogis(e + b) * dnorm(b, 0, sb), -Inf, Inf)$value))

