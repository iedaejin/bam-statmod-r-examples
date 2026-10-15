# 02-simulate-from-model.R
# Session 02 --- Introduction to statistical modelling
# A fitted model is a data-generating process: simulate from it and compare
# the simulated series with the observed one. Then separate variability
# (spread of the data) from uncertainty (spread of an estimate).
# Prof. Dae-Jin Lee (daelee@faculty.ie.edu)

data(nhtemp)
nh <- data.frame(year = as.numeric(time(nhtemp)), temp = as.numeric(nhtemp))
n  <- nrow(nh)
m1 <- lm(temp ~ 1, data = nh)
m2 <- lm(temp ~ year, data = nh)
sig1 <- summary(m1)$sigma
sig2 <- summary(m2)$sigma

# ---- 1. One simulated series from model 2 ----
set.seed(2027)                                   # makes the draw reproducible
y_star <- fitted(m2) + rnorm(n, mean = 0, sd = sig2)
plot(nh$year, nh$temp, type = "l", lwd = 2, xlab = "Year", ylab = "deg F",
     ylim = range(nh$temp, y_star))
lines(nh$year, y_star, col = "red")
legend("topleft", c("observed", "simulated from model 2"),
       col = c("black", "red"), lwd = c(2, 1), bty = "n")

# ---- 2. A line-up: can you spot the real series among 8 simulated ones? ----
set.seed(2027)
pos <- sample(1:9, 1)
op <- par(mfrow = c(3, 3), mar = c(2, 2, 1.5, 0.5))
for (k in 1:9) {
  yk <- if (k == pos) nh$temp else fitted(m2) + rnorm(n, 0, sig2)
  plot(nh$year, yk, type = "l", main = paste("Panel", k), xlab = "", ylab = "")
}
par(op)
pos                                              # reveal after the discussion

# ---- 3. Distribution of the fitted slope under each model ----
set.seed(2027)
B <- 1000
slope_m1 <- replicate(B, coef(lm(rnorm(n, coef(m1), sig1) ~ nh$year))[2])
slope_m2 <- replicate(B, coef(lm(fitted(m2) + rnorm(n, 0, sig2) ~ nh$year))[2])
b1_obs <- unname(coef(m2)[2])
c(observed = b1_obs, max_under_m1 = max(slope_m1),
  share_m1_at_least_obs = mean(slope_m1 >= b1_obs))
c(mean_m2 = mean(slope_m2), sd_m2 = sd(slope_m2),
  se_from_lm = summary(m2)$coefficients["year", "Std. Error"])

hist(10 * slope_m1, breaks = 40, xlim = 10 * range(slope_m1, slope_m2),
     col = rgb(0.8, 0.3, 0.2, 0.6), main = "", xlab = "Slope (deg F per decade)")
hist(10 * slope_m2, breaks = 40, col = rgb(0, 0.2, 0.55, 0.6), add = TRUE)
abline(v = 10 * b1_obs, lwd = 3)

# ---- 4. Variability vs uncertainty as the sample size grows ----
set.seed(2027)
mu  <- mean(nh$temp)
sig <- sd(nh$temp)
ns  <- c(10, 30, 100, 300, 1000)
vu <- t(sapply(ns, function(nn) {
  sims <- replicate(500, { z <- rnorm(nn, mu, sig); c(mean(z), sd(z)) })
  c(n = nn,
    variability = mean(sims[2, ]),               # average sample SD: stays near sigma
    uncertainty = sd(sims[1, ]),                 # SD of the 500 sample means
    sigma_over_sqrt_n = sig / sqrt(nn))
}))
round(vu, 3)
