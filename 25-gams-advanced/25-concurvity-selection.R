#' ---
#' title: "Session 25 — Concurvity and term selection"
#' subtitle: "Statistical Modelling (BAM), IE University"
#' author: "Prof. Dae-Jin Lee (daelee@faculty.ie.edu)"
#' date: "Spring 2027"
#' output: html_document
#' ---
#' 
## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE,
                      fig.width = 8, fig.height = 3.6)

#' 
## ----packages-----------------------------------------------------------------
library(mgcv)

#' 
#' ## 1. Concurvity: the non-linear analogue of collinearity
#' 
#' Same true functions, two designs: $x_2$ independent of $x_1$, or
#' $x_2 \approx x_1$.
#' 
## ----sim----------------------------------------------------------------------
set.seed(25)
n  <- 300
f1 <- function(x) sin(2 * pi * x)
f2 <- function(x) 2 * (x - 0.5)^2
x1 <- runif(n)
x2_ind <- runif(n)
x2_cor <- pmin(pmax(x1 + rnorm(n, sd = 0.08), 0), 1)
fit_design <- function(x2) {
  y <- f1(x1) + f2(x2) + rnorm(n, sd = 0.3)
  gam(y ~ s(x1) + s(x2), data = data.frame(y, x1, x2), method = "REML")
}
m_ind <- fit_design(x2_ind)
m_cor <- fit_design(x2_cor)
c(cor_ind = cor(x1, x2_ind), cor_cor = cor(x1, x2_cor))

#' 
## ----concurvity---------------------------------------------------------------
round(concurvity(m_ind, full = TRUE), 3)
round(concurvity(m_cor, full = TRUE), 3)
round(concurvity(m_cor, full = FALSE)$estimate, 3)   # pairwise

#' 
#' `concurvity()` reports, for each smooth, how much of it can be
#' approximated by the other terms: 0 = none, 1 = completely. `estimate` is
#' based on the fitted coefficients; `worst` is the worst case over all
#' coefficient values.
#' 
## ----se-----------------------------------------------------------------------
se_ind <- predict(m_ind, type = "terms", se.fit = TRUE)$se.fit
se_cor <- predict(m_cor, type = "terms", se.fit = TRUE)$se.fit
rbind(independent = colMeans(se_ind), correlated = colMeans(se_cor))
par(mfrow = c(1, 2))
plot(m_ind, select = 1, shade = TRUE, main = "independent design", ylim = c(-1.5, 1.5))
curve(f1(x) - mean(f1(x1)), add = TRUE, col = "red", lty = 2)
plot(m_cor, select = 1, shade = TRUE, main = "correlated design", ylim = c(-1.5, 1.5))
curve(f1(x) - mean(f1(x1)), add = TRUE, col = "red", lty = 2)

#' 
#' The standard errors roughly double: the data cannot tell well which
#' covariate the signal belongs to.
#' 
#' ## 2. Concurvity in the airquality model
#' 
## ----aq-----------------------------------------------------------------------
aq <- na.omit(airquality[, c("Ozone", "Solar.R", "Wind", "Temp")])
add <- gam(log(Ozone) ~ s(Solar.R) + s(Wind) + s(Temp), data = aq, method = "REML")
round(concurvity(add, full = TRUE), 3)

#' 
#' Values around 0.25–0.45 (estimate): moderate. Temp and Wind share
#' information (correlation −0.50), so their separate effects are estimated
#' less precisely, but not dangerously so.
#' 
#' ## 3. Shrinkage term selection with `select = TRUE`
#' 
#' `select = TRUE` adds a second penalty on the null space of each smooth, so
#' a whole term can be shrunk to zero.
#' 
## ----select-------------------------------------------------------------------
set.seed(2027)
aq$noise1 <- rnorm(nrow(aq))
aq$noise2 <- runif(nrow(aq))
f_big <- log(Ozone) ~ s(Solar.R) + s(Wind) + s(Temp) + s(noise1) + s(noise2)
m_nosel <- gam(f_big, data = aq, method = "REML")
m_sel   <- gam(f_big, data = aq, method = "REML", select = TRUE)
round(cbind(edf_without = summary(m_nosel)$s.table[, "edf"],
            edf_select  = summary(m_sel)$s.table[, "edf"]), 4)

#' 
#' Without `select`, each noise term keeps at least edf $\approx 1$ (its
#' linear part is unpenalized). With `select = TRUE` both are shrunk to edf
#' $\approx 0$ while the real effects survive. An alternative is a shrinkage
#' basis, e.g. `s(x, bs = "ts")`.
