# Session 06 — Model selection with AIC, BIC and Mallows' Cp
# Statistical Modelling (BAM), IE University --- Prof. Dae-Jin Lee (daelee@faculty.ie.edu)
# Same code as 06-model-selection.Rmd. Run from r-examples/:  Rscript 06-model-selection.R



## ----data---------------------------------------------------------------------
library(faraway)
data(prostate)
full <- lm(lpsa ~ ., data = prostate)
n <- nrow(prostate)


## ----aic-versions-------------------------------------------------------------
k <- length(coef(full)) + 1                      # 9 betas + sigma^2
c(AIC = AIC(full),
  by_hand = -2 * as.numeric(logLik(full)) + 2 * k,
  extractAIC = extractAIC(full)[2],
  by_hand2 = n * log(deviance(full) / n) + 2 * length(coef(full)))
AIC(full) - extractAIC(full)[2]                  # constant n log(2 pi) + n + 2
n * log(2 * pi) + n + 2


## ----step---------------------------------------------------------------------
m_aic <- step(full, trace = 0)                   # penalty 2 per parameter
m_bic <- step(full, trace = 0, k = log(n))       # penalty log(n) = 4.57
formula(m_aic); formula(m_bic)
c(AIC_full = AIC(full), AIC_sel = AIC(m_aic), BIC_full = BIC(full), BIC_sel = BIC(m_bic))


## ----regsubsets---------------------------------------------------------------
library(leaps)
rs <- regsubsets(lpsa ~ ., data = prostate, nvmax = 8)
ss <- summary(rs)
names(ss)
p <- 2:9                                          # columns incl. intercept
sigma2_full <- deviance(full) / (n - 9)
round(cbind(p = p, rss = ss$rss, cp = ss$cp,
            cp_by_hand = ss$rss / sigma2_full - n + 2 * p,
            bic = ss$bic, adjr2 = ss$adjr2), 3)
ss$which[which.min(ss$cp), ]


## ----post-selection-----------------------------------------------------------
set.seed(66)
nsim <- 200
out <- replicate(nsim, {
  d <- as.data.frame(matrix(rnorm(100 * 21), 100, 21))
  names(d)[1] <- "y"
  sel <- step(lm(y ~ ., data = d), trace = 0)
  pv <- coef(summary(sel))[-1, 4, drop = FALSE]
  c(n_kept = nrow(pv), n_sig = sum(pv < 0.05))
})
rowMeans(out)            # on average several noise variables kept, many with p < 0.05
mean(out["n_sig", ] > 0) # share of data sets with at least one "significant" noise term

