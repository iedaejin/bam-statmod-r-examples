# Session 07 — Lab 02 walk-through, Part 1: inference and diagnostics
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Same code as 07-lab-part1-savings.Rmd. Run from r-examples/:  Rscript 07-lab-part1-savings.R



## ----data---------------------------------------------------------------------
library(car)
savings <- read.csv("data/savings.csv")
rownames(savings) <- savings$country
fit <- lm(sr ~ pop15 + pop75 + dpi + ddpi, data = savings)
n <- nrow(savings); p <- length(coef(fit))
summary(fit)
confint(fit)


## ----f-test-------------------------------------------------------------------
fit0 <- lm(sr ~ pop15 + ddpi, data = savings)
anova(fit0, fit)


## ----residuals, fig.width=8, fig.height=7-------------------------------------
par(mfrow = c(2, 2))
plot(fit)            # residuals vs fitted, QQ, scale-location, residuals vs leverage


## ----influence----------------------------------------------------------------
h <- hatvalues(fit)
names(h)[h > 2 * p / n]
t_i <- rstudent(fit)
c(max_abs_t = max(abs(t_i)), bonferroni = qt(1 - 0.05 / (2 * n), n - p - 1))
D <- cooks.distance(fit)
round(sort(D, decreasing = TRUE)[1:5], 3)


## ----vif----------------------------------------------------------------------
vif(fit)

