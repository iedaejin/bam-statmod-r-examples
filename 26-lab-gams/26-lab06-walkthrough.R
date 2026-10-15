#' ---
#' title: "Session 26 — Lab 06 walk-through: from LM to GAM on airquality"
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
#' This file collects the key code of Lab 06 in one place. The data come from
#' the `datasets` package, so no file is needed.
#' 
## ----data---------------------------------------------------------------------
library(mgcv)
aq <- airquality
aq$day <- seq_len(nrow(aq))          # day of season
aq <- na.omit(aq)                    # 111 complete days

#' 
#' ## 1. Linear model and residuals
#' 
## ----lm-----------------------------------------------------------------------
lm_log <- lm(log(Ozone) ~ Solar.R + Wind + Temp, data = aq)
par(mfrow = c(1, 3))
for (v in c("Solar.R", "Wind", "Temp")) {
  plot(aq[[v]], resid(lm_log), xlab = v, ylab = "residual")
  lines(lowess(aq[[v]], resid(lm_log)), col = "red", lwd = 2)
}

#' 
#' ## 2. Scale and family
#' 
## ----family-------------------------------------------------------------------
m_log   <- gam(log(Ozone) ~ s(Solar.R) + s(Wind) + s(Temp), data = aq, method = "REML")
m_gamma <- gam(Ozone ~ s(Solar.R) + s(Wind) + s(Temp), family = Gamma(link = "log"),
               data = aq, method = "REML")
c(log_y_on_y_scale = AIC(m_log) + 2 * sum(log(aq$Ozone)), gamma = AIC(m_gamma))

#' 
#' ## 3. REML fit, checks and concurvity
#' 
## ----checks, fig.height = 6---------------------------------------------------
summary(m_log)
set.seed(1); gam.check(m_log)
round(concurvity(m_log, full = TRUE), 3)

#' 
#' ## 4. Interaction and comparison
#' 
## ----interaction--------------------------------------------------------------
m_te <- gam(log(Ozone) ~ s(Solar.R) + te(Temp, Wind), data = aq, method = "REML")
m_ti <- gam(log(Ozone) ~ s(Solar.R) + s(Wind) + s(Temp) + ti(Temp, Wind),
            data = aq, method = "REML")
AIC(lm_log, m_log, m_te, m_ti)
vis.gam(m_te, view = c("Temp", "Wind"), plot.type = "contour", too.far = 0.1)

#' 
#' ## 5. Predictions with intervals built on the link scale
#' 
## ----predict------------------------------------------------------------------
nd <- expand.grid(Temp = c(70, 80, 90), Wind = c(5, 10, 15), Solar.R = 207)
pr <- predict(m_ti, nd, se.fit = TRUE)
cbind(nd, median = exp(pr$fit), lower = exp(pr$fit - 1.96 * pr$se.fit),
      upper = exp(pr$fit + 1.96 * pr$se.fit)) |> round(1)

