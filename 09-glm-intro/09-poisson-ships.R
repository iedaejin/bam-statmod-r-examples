# Session 9 — Poisson regression with an offset: ship damage
# Statistical Modelling (BAM), IE University
# Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Same code as 09-poisson-ships.Rmd. Run from this folder.

# ---- data ----
library(MASS)
# Six cells have no service at all: they carry no information about a rate
sh <- subset(ships, service > 0)
sh$year   <- factor(sh$year)
sh$period <- factor(sh$period)
nrow(sh)
head(sh)

# ---- fit ----
fit <- glm(incidents ~ type + year + period + offset(log(service)),
           family = poisson, data = sh)
summary(fit)

# ---- rr ----
round(exp(cbind(RR = coef(fit), confint(fit))), 3)

# ---- by-hand ----
b <- coef(fit)
# Type B, built 1965-69, operating 1975-79, 1000 months of service
eta <- log(1000) + b["(Intercept)"] + b["typeB"] + b["year65"] + b["period75"]
unname(exp(eta))
predict(fit, data.frame(type = "B", year = "65", period = "75", service = 1000),
        type = "response")

# ---- free-offset ----
fit_free <- glm(incidents ~ type + year + period + log(service),
                family = poisson, data = sh)
coef(fit_free)["log(service)"]   # estimated freely: close to 1?

# ---- fit-check ----
c(deviance = deviance(fit), df = df.residual(fit),
  pearson_X2 = sum(residuals(fit, type = "pearson")^2))

