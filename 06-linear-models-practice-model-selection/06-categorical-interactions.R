# Session 06 — Categorical predictors, interactions and the hierarchical principle
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Same code as 06-categorical-interactions.Rmd. Run from r-examples/:  Rscript 06-categorical-interactions.R



## ----data---------------------------------------------------------------------
mt <- mtcars
mt$am  <- factor(mt$am, levels = c(0, 1), labels = c("automatic", "manual"))
mt$cyl <- factor(mt$cyl)


## ----dummies------------------------------------------------------------------
contrasts(mt$cyl)
fit_cyl <- lm(mpg ~ wt + cyl, data = mt)
head(model.matrix(fit_cyl), 4)
coef(summary(fit_cyl))


## ----relevel------------------------------------------------------------------
mt$cyl8 <- relevel(mt$cyl, ref = "8")
coef(lm(mpg ~ wt + cyl8, data = mt))
all.equal(fitted(fit_cyl), fitted(lm(mpg ~ wt + cyl8, data = mt)))


## ----factor-test--------------------------------------------------------------
anova(lm(mpg ~ wt, data = mt), fit_cyl)


## ----am-interaction-----------------------------------------------------------
fit_am <- lm(mpg ~ wt * am, data = mt)
coef(summary(fit_am))
b <- coef(fit_am)
c(auto_intercept = b[["(Intercept)"]], auto_slope = b[["wt"]],
  manual_intercept = b[["(Intercept)"]] + b[["ammanual"]],
  manual_slope = b[["wt"]] + b[["wt:ammanual"]])
cross <- -b[["ammanual"]] / b[["wt:ammanual"]]
cross                                        # the lines cross at wt = 2.81
tapply(mt$wt, mt$am, range)                  # observed weights by group
anova(lm(mpg ~ wt + am, data = mt), fit_am)  # F = t^2 for the interaction


## ----centred------------------------------------------------------------------
mt$wt_c <- mt$wt - 3
coef(lm(mpg ~ wt_c * am, data = mt))   # ammanual = gap at 3000 lb


## ----hp-interaction-----------------------------------------------------------
fit_hp <- lm(mpg ~ wt * hp, data = mt)
coef(summary(fit_hp))
b2 <- coef(fit_hp)
hp_values <- c(100, 150, 250)
setNames(b2[["wt"]] + b2[["wt:hp"]] * hp_values, paste0("hp=", hp_values))


## ----hierarchy----------------------------------------------------------------
mt$hp_c <- mt$hp - 150
c(no_linear  = deviance(lm(mpg ~ I(hp^2), data = mt)),
  no_linear_shifted = deviance(lm(mpg ~ I(hp_c^2), data = mt)),
  full = deviance(lm(mpg ~ hp + I(hp^2), data = mt)),
  full_shifted = deviance(lm(mpg ~ hp_c + I(hp_c^2), data = mt)))
c(no_main = deviance(lm(mpg ~ wt + wt:hp, data = mt)),
  no_main_shifted = deviance(lm(mpg ~ wt_c + wt_c:hp, data = mt)),
  full = deviance(lm(mpg ~ wt * hp, data = mt)),
  full_shifted = deviance(lm(mpg ~ wt_c * hp, data = mt)))

