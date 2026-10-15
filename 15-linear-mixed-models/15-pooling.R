# 15-pooling.R --- plain-script version of 15-pooling.Rmd
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Run from the r-examples/ folder:  Rscript 15-pooling.R

#' ---
#' title: "Session 15 — Complete, no and partial pooling (sleepstudy)"
#' author: "Prof. Dae-Jin Lee (daelee@faculty.ie.edu)"
#' output: html_document
#' ---
#' 

#' 
#' The `sleepstudy` data (package `lme4`) record the average reaction time
#' (ms) of 18 subjects on each of 10 days (Days 0--9) of sleep restriction.
#' Each subject is measured 10 times, so the 180 rows are not independent.
#' 
## ----data---------------------------------------------------------------------
library(lme4)
library(ggplot2)
data(sleepstudy)
str(sleepstudy)
table(table(sleepstudy$Subject))   # 18 subjects with 10 observations each

#' 
#' ## Look at the data subject by subject
#' 
## ----panels, fig.width = 9, fig.height = 6------------------------------------
ggplot(sleepstudy, aes(Days, Reaction)) +
  geom_point(size = 1) +
  geom_smooth(method = "lm", se = FALSE, linewidth = 0.6) +
  facet_wrap(~ Subject, nrow = 3) +
  labs(y = "Reaction time (ms)")

#' 
#' ## Complete pooling: one line for everybody
#' 
## ----complete-----------------------------------------------------------------
fit_cp <- lm(Reaction ~ Days, data = sleepstudy)
summary(fit_cp)$coefficients

#' 
#' The residuals of this fit are strongly correlated within subject, which
#' breaks the independence assumption of `lm()`:
#' 
## ----residual-correlation-----------------------------------------------------
r <- matrix(resid(fit_cp), nrow = 10)          # column = subject, row = day
# average correlation between residuals of the same subject on two different days
cr <- cor(t(r))                                 # 10 x 10: day-by-day correlation across subjects
mean(cr[upper.tri(cr)])

#' 
#' ## No pooling: one line per subject
#' 
## ----nopool-------------------------------------------------------------------
fit_np <- lmList(Reaction ~ Days | Subject, data = sleepstudy)
coef_np <- coef(fit_np)
head(coef_np)
apply(coef_np, 2, sd)     # spread of the 18 separate intercepts and slopes

#' 
#' ## Partial pooling: linear mixed model
#' 
## ----partial------------------------------------------------------------------
fit_pp <- lmer(Reaction ~ Days + (Days | Subject), data = sleepstudy)
coef_pp <- coef(fit_pp)$Subject      # beta + BLUP for each subject
head(coef_pp)

#' 
#' ## The three answers side by side
#' 
## ----compare------------------------------------------------------------------
cmp <- data.frame(
  Subject   = rownames(coef_np),
  int_none  = coef_np[, 1], slope_none = coef_np[, 2],
  int_part  = coef_pp[, 1], slope_part = coef_pp[, 2]
)
cmp$int_all   <- coef(fit_cp)[1]
cmp$slope_all <- coef(fit_cp)[2]
cmp$slope_move <- cmp$slope_part - cmp$slope_none   # how far the slope was pulled
cmp[order(-abs(cmp$slope_move)), ][1:5, ]

#' 
#' Subjects whose own line is far from the population line, or noisy, are
#' pulled furthest towards it.
#' 
#' ## Why it matters for inference
#' 
## ----se-----------------------------------------------------------------------
se <- rbind(
  lm   = summary(fit_cp)$coefficients[, "Std. Error"],
  lmer = summary(fit_pp)$coefficients[, "Std. Error"]
)
round(se, 3)

#' 
#' `lm()` treats 180 correlated rows as 180 independent pieces of
#' information about the average slope, so its standard error for `Days`
#' (1.24) is too small. The mixed model recognises that slopes vary between
#' subjects and gives 1.55.
