#' ---
#' title: "Session 26 — Lab 06 extensions: Gamma family, shrinkage and a parametric month effect"
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
## ----data---------------------------------------------------------------------
library(mgcv)
aq <- na.omit(airquality)

#' 
#' ## 1. The interaction model with a Gamma family
#' 
## ----gamma--------------------------------------------------------------------
g_add <- gam(Ozone ~ s(Solar.R) + s(Wind) + s(Temp),
             family = Gamma(link = "log"), data = aq, method = "REML")
g_ti  <- gam(Ozone ~ s(Solar.R) + s(Wind) + s(Temp) + ti(Temp, Wind),
             family = Gamma(link = "log"), data = aq, method = "REML")
AIC(g_add, g_ti)
summary(g_ti)$s.table

#' 
#' ## 2. Shrinkage with `select = TRUE`
#' 
## ----select-------------------------------------------------------------------
g_sel <- gam(log(Ozone) ~ s(Solar.R) + s(Wind) + s(Temp) + ti(Temp, Wind),
             data = aq, method = "REML", select = TRUE)
summary(g_sel)$s.table

#' 
#' ## 3. A parametric month effect
#' 
## ----month--------------------------------------------------------------------
aq$Month <- factor(aq$Month, labels = c("May", "Jun", "Jul", "Aug", "Sep"))
m_month <- gam(log(Ozone) ~ Month + s(Solar.R) + s(Wind) + s(Temp) + ti(Temp, Wind),
               data = aq, method = "REML")
anova(m_month)$pTerms.table
m_ti <- gam(log(Ozone) ~ s(Solar.R) + s(Wind) + s(Temp) + ti(Temp, Wind),
            data = aq, method = "REML")
AIC(m_ti, m_month)

#' 
#' ## 4. `gratia` diagnostics
#' 
## ----gratia, fig.height = 6---------------------------------------------------
gratia::appraise(m_ti)

