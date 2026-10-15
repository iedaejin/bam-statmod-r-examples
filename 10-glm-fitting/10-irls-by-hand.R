# Session 10 — IRLS by hand
# Statistical Modelling (BAM), IE University
# Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Same code as 10-irls-by-hand.Rmd. Run from this folder.

# ---- irls ----
irls <- function(X, y, family = binomial(), offset = rep(0, length(y)),
                 tol = 1e-10, maxit = 50) {
  mu  <- (y + mean(y)) / 2                     # starting values inside the range
  eta <- family$linkfun(mu)
  dev <- sum(family$dev.resids(y, mu, 1))
  trace <- numeric(0)                          # deviance after each update
  converged <- FALSE
  for (iter in 1:maxit) {
    d    <- family$mu.eta(eta)                 # d mu / d eta = 1 / g'(mu)
    z    <- eta - offset + (y - mu) / d        # working response
    w    <- d^2 / family$variance(mu)          # working weights
    beta <- solve(crossprod(X, w * X), crossprod(X, w * z))
    eta  <- drop(X %*% beta) + offset          # update eta and mu with the NEW beta
    mu   <- family$linkinv(eta)
    dev_new <- sum(family$dev.resids(y, mu, 1))
    trace <- c(trace, dev_new)
    if (abs(dev_new - dev) / (abs(dev_new) + 0.1) < tol) {
      converged <- TRUE                        # TRUE only if the criterion is met
      dev <- dev_new
      break
    }
    dev <- dev_new
  }
  d <- family$mu.eta(eta); w <- d^2 / family$variance(mu)   # weights at the final beta
  list(coefficients = drop(beta), deviance = dev, iter = iter,
       converged = converged, trace = trace,
       cov_unscaled = solve(crossprod(X, w * X)))
}

# ---- birthwt ----
library(MASS)
bw <- with(birthwt, data.frame(low = low, age = age, lwt = lwt,
  race = factor(race, labels = c("white", "black", "other")),
  smoke = smoke, ptd = as.integer(ptl > 0), ht = ht, ui = ui))
form <- low ~ age + lwt + race + smoke + ptd + ht + ui
X <- model.matrix(form, data = bw)
my  <- irls(X, bw$low, family = binomial())
# glm() run to the same tight tolerance, so both are fully converged
fit <- glm(form, family = binomial, data = bw,
           control = glm.control(epsilon = 1e-10))
c(iterations = my$iter, converged = my$converged)
max(abs(my$coefficients - coef(fit)))                          # < 1e-8
max(abs(sqrt(diag(my$cov_unscaled)) - sqrt(diag(vcov(fit)))))  # standard errors
round(my$trace, 6)                                             # deviance at each step

# ---- ships ----
sh <- subset(ships, service > 0)
sh$year <- factor(sh$year); sh$period <- factor(sh$period)
Xs <- model.matrix(~ type + year + period, data = sh)
my_s  <- irls(Xs, sh$incidents, family = poisson(), offset = log(sh$service))
fit_s <- glm(incidents ~ type + year + period + offset(log(service)),
             family = poisson, data = sh, control = glm.control(epsilon = 1e-10))
c(iterations = my_s$iter, converged = my_s$converged,
  max_diff = max(abs(my_s$coefficients - coef(fit_s))))

# ---- fisher-vs-newton ----
# Binary GLM, mu = F(eta): d loglik / d eta = (y - mu) h(eta), h = F'(eta) / (mu (1 - mu))
# observed information = sum [F' h - (y - mu) h'] x x',  expected = sum F' h x x'
info_gap <- function(link) {
  fam  <- binomial(link = link)
  beta <- coef(glm(form, family = fam, data = bw))
  eta  <- drop(X %*% beta); mu <- fam$linkinv(eta)
  h    <- function(e) { m <- fam$linkinv(e); fam$mu.eta(e) / (m * (1 - m)) }
  dh   <- (h(eta + 1e-5) - h(eta - 1e-5)) / 2e-5
  expected <- crossprod(X, fam$mu.eta(eta) * h(eta) * X)
  observed <- expected - crossprod(X, (bw$low - mu) * dh * X)
  c(rel_gap = max(abs(observed - expected)) / max(abs(expected)),
    se_ratio_ptd = sqrt(solve(observed)["ptd", "ptd"] / solve(expected)["ptd", "ptd"]))
}
rbind(logit = info_gap("logit"), probit = info_gap("probit"))

