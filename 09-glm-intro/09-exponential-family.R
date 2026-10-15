# Session 9 — The exponential family in R
# Statistical Modelling (BAM), IE University
# Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Same code as 09-exponential-family.Rmd. Run from this folder.

# ---- cumulant ----
# Numerical first and second derivatives of b at theta
d1 <- function(b, th, h = 1e-4) (b(th + h) - b(th - h)) / (2 * h)
d2 <- function(b, th, h = 1e-4) (b(th + h) - 2 * b(th) + b(th - h)) / h^2

# Poisson(mu = 3): theta = log(mu), b(theta) = exp(theta), a(phi) = 1
mu <- 3
c(mean = d1(exp, log(mu)), var = d2(exp, log(mu)))

# Bernoulli(p = 0.2): theta = logit(p), b(theta) = log(1 + exp(theta))
p <- 0.2
b_bern <- function(th) log(1 + exp(th))
c(mean = d1(b_bern, qlogis(p)), var = d2(b_bern, qlogis(p)))   # p and p(1 - p)

# Gamma(mean mu, shape nu): theta = -1/mu, b(theta) = -log(-theta), a(phi) = 1/nu
mu <- 2; nu <- 4
b_gam <- function(th) -log(-th)
c(mean = d1(b_gam, -1 / mu),               # b'(theta) = -1/theta = mu
  var  = d2(b_gam, -1 / mu) * (1 / nu))    # b''(theta) a(phi) = mu^2 / nu

# ---- simulate ----
set.seed(2027)
y_pois <- rpois(1e5, lambda = 3)
y_gam  <- rgamma(1e5, shape = 4, rate = 4 / 2)   # mean 2, variance 2^2/4 = 1
rbind(poisson = c(mean = mean(y_pois), var = var(y_pois)),
      gamma   = c(mean = mean(y_gam),  var = var(y_gam)))

# ---- variance-functions ----
mu <- seq(0.01, 0.99, length.out = 200)
op <- par(mfrow = c(1, 2))
plot(mu, mu * (1 - mu), type = "l", lwd = 2, xlab = expression(mu),
     ylab = expression(V(mu)), main = "Bernoulli")
m <- seq(0.1, 5, length.out = 200)
plot(m, m^2, type = "l", lwd = 2, lty = 2, xlab = expression(mu),
     ylab = expression(V(mu)), main = "Poisson and gamma")
lines(m, m, lwd = 2)
legend("topleft", c("Poisson: mu", "Gamma: mu^2"), lty = 1:2, lwd = 2, bty = "n")
par(op)

# ---- families ----
fam <- binomial(link = "logit")
fam$linkfun(0.2)     # g(mu) = logit(0.2)
fam$linkinv(-1.386)  # g^{-1}(eta): back to (0, 1)
fam$variance(0.2)    # V(mu) = mu (1 - mu)
poisson()$variance(3)
Gamma()$link         # canonical link of the gamma is the inverse link 1/mu

