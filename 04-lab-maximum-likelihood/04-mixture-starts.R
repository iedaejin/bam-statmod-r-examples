# Session 4 — Mixtures, starting values and identifiability
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Plain-script version of 04-mixture-starts.Rmd (same code). Run from this folder.

# ---- 1. The negative log-likelihood ----------------------------------------

e <- faithful$eruptions
nll_mix <- function(par, y) {
  p <- plogis(par[1])
  -sum(log(p * dnorm(y, par[2], exp(par[4])) + (1 - p) * dnorm(y, par[3], exp(par[5]))))
}
show_fit <- function(fit) {
  round(c(p = plogis(fit$par[1]), mu1 = fit$par[2], mu2 = fit$par[3],
          sigma1 = exp(fit$par[4]), sigma2 = exp(fit$par[5]),
          loglik = -fit$value, convergence = fit$convergence), 3)
}
hist(e, breaks = 30, freq = FALSE, main = "", xlab = "eruption duration (min)")

# ---- 2. A sensible start and a symmetric start -----------------------------

fit_good <- optim(c(0, 2, 4.5, log(0.5), log(0.5)), nll_mix, y = e, method = "BFGS", hessian = TRUE)
show_fit(fit_good)
eigen(fit_good$hessian)$values            # all positive

fit_sym <- optim(c(0, mean(e), mean(e), log(sd(e)), log(sd(e))), nll_mix, y = e,
                 method = "BFGS", hessian = TRUE)
show_fit(fit_sym)                          # stuck at a single normal
round(eigen(fit_sym$hessian)$values, 4)    # a zero and a negative eigenvalue: saddle point

# ---- 3. Many starts, classified --------------------------------------------

multi_start <- function(y, B = 20, sd_start = sd(y) / 2) {
  t(replicate(B, {
    st <- c(0, sample(y, 2), log(sd_start), log(sd_start))
    fit <- tryCatch(optim(st, nll_mix, y = y, method = "BFGS"), error = function(err) NULL)
    if (is.null(fit)) rep(NA, 7) else show_fit(fit)
  }))
}
set.seed(2027)
runs <- multi_start(e)
type <- with(as.data.frame(runs),
             ifelse(is.na(loglik), "error",
             ifelse(pmin(p, 1 - p) < 0.01, "one component (p at 0 or 1)",
             ifelse(pmin(sigma1, sigma2) < 0.01, "degenerate (sigma near 0)",
                    "two components"))))
table(type)
runs[type == "two components", ][1:4, ]   # both labellings appear

# ---- 4. Fix the labels before reporting ------------------------------------

relabel <- function(r) {
  if (r["mu1"] > r["mu2"]) {
    r[c("mu1", "mu2")]       <- r[c("mu2", "mu1")]
    r[c("sigma1", "sigma2")] <- r[c("sigma2", "sigma1")]
    r["p"] <- 1 - r["p"]
  }
  r
}
good <- t(apply(runs[type == "two components", ], 1, relabel))
unique(round(good, 2))

