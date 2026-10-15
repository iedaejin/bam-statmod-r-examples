# Session 3 — Wald, score and likelihood-ratio tests and intervals
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Plain-script version of 03-wald-score-lr.Rmd (same code). Run from this folder.

# ---- 1. Binomial: 8 successes in 10 trials, H_0:theta=0.5 ------------------

n <- 10; y <- 8; theta0 <- 0.5
theta_hat <- y / n
loglik <- function(t) y * log(t) + (n - y) * log(1 - t)

W  <- (theta_hat - theta0)^2 / (theta_hat * (1 - theta_hat) / n)   # I(theta_hat) = n / (th (1 - th))
Sc <- (y - n * theta0)^2 / (n * theta0 * (1 - theta0))             # S(theta0)^2 / Ii(theta0)
LR <- 2 * (loglik(theta_hat) - loglik(theta0))

stats <- c(Wald = W, Score = Sc, LR = LR)
round(rbind(statistic = stats, p_value = pchisq(stats, df = 1, lower.tail = FALSE)), 4)

# ---- 2. Three 95% intervals for theta --------------------------------------

z <- qnorm(0.975)
se <- sqrt(theta_hat * (1 - theta_hat) / n)
wald <- theta_hat + c(-1, 1) * z * se

score_ci <- prop.test(y, n, correct = FALSE)$conf.int   # Wilson interval = inverted score test

cut <- qchisq(0.95, df = 1) / 2                         # 1.92
f <- function(t) loglik(t) - loglik(theta_hat) + cut    # zero at the interval ends
lr_ci <- c(uniroot(f, c(1e-8, theta_hat), tol = 1e-10)$root,
           uniroot(f, c(theta_hat, 1 - 1e-8), tol = 1e-10)$root)

round(rbind(Wald = wald, Score = as.numeric(score_ci), LR = lr_ci), 3)

# ---- 3. Exponential mean (aircondit): parametrisation matters for Wald, not for LR ---

data(aircondit, package = "boot")
yy <- aircondit$hours; nn <- length(yy)
mu_hat <- mean(yy)
ll <- function(mu) -nn * log(mu) - sum(yy) / mu

wald_mu    <- mu_hat + c(-1, 1) * z * mu_hat / sqrt(nn)          # Wald on mu
wald_logmu <- exp(log(mu_hat) + c(-1, 1) * z / sqrt(nn))         # Wald on log(mu), back-transformed
g <- function(mu) ll(mu) - ll(mu_hat) + cut
lr_mu <- c(uniroot(g, c(1, mu_hat), tol = 1e-10)$root, uniroot(g, c(mu_hat, 5000), tol = 1e-10)$root)
exact <- 2 * sum(yy) / qchisq(c(0.975, 0.025), df = 2 * nn)      # 2 sum(y) / mu ~ chi^2_{2n}

round(rbind(Wald_mu = wald_mu, Wald_logmu = wald_logmu, LR = lr_mu, Exact = exact), 1)

ll_rate <- function(l) ll(1 / l)
h <- function(l) ll_rate(l) - ll_rate(1 / mu_hat) + cut
lr_rate <- c(uniroot(h, c(1e-5, 1 / mu_hat), tol = 1e-10)$root, uniroot(h, c(1 / mu_hat, 1), tol = 1e-10)$root)
rbind(LR_rate = lr_rate, one_over_LR_mu = rev(1 / lr_mu))

# ---- 4. Profile likelihood for the mean of a normal (nhtemp) ---------------

data(nhtemp)
yt <- as.numeric(nhtemp); nt <- length(yt)
lp <- function(m) -nt / 2 * log(mean((yt - m)^2))       # constants dropped
m_hat <- mean(yt)
k <- function(m) lp(m) - lp(m_hat) + cut
profile_ci <- c(uniroot(k, c(m_hat - 3, m_hat), tol = 1e-10)$root, uniroot(k, c(m_hat, m_hat + 3), tol = 1e-10)$root)
s2_hat <- mean((yt - m_hat)^2)
rbind(profile_LR = profile_ci,
      Wald = m_hat + c(-1, 1) * z * sqrt(s2_hat / nt),
      t_interval = as.numeric(t.test(yt)$conf.int))

mm <- seq(50.6, 51.7, length.out = 200)
plot(mm, sapply(mm, lp) - lp(m_hat), type = "l", lwd = 2,
     xlab = expression(mu), ylab = "profile log-likelihood (max = 0)")
abline(h = -cut, lty = 2)
abline(v = profile_ci, lty = 3)

