# Session 18 — Exercises

**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

These tasks extend the lab. They are not graded; solutions are discussed in Session 19.

## Task 1 — Use the real baseline

The `lme4` documentation says that Days 0–1 of `sleepstudy` were adaptation and training and Day 2 was the baseline. Keep only Days 2–9, recode `Days2 = Days - 2`, and refit `Reaction ~ Days2 + (Days2 | Subject)`. Compare $\hat\beta_1$, $\hat\sigma_{b0}$, $\hat\sigma_{b1}$ and $\hat\rho$ with the full-data fit. Which estimates change most, and why does $\hat\rho$ change?

## Task 2 — A parametric bootstrap for the random slope

The 50:50 mixture is an asymptotic result. Simulate 200 data sets from the fitted random-intercept model (`simulate(fit_ri)`), refit both `(1 | Subject)` and `(Days | Subject)` to each, and record $T = 2(\ell_1 - \ell_0)$ (REML). Estimate the bootstrap p-value of the observed $T = 42.8$ and the 95% quantile of the null distribution. Compare with the mixture's critical value (solve $\tfrac12P(\chi^2_1 > c) + \tfrac12P(\chi^2_2 > c) = 0.05$).

## Task 3 — PQL vs Laplace on `cbpp`

Fit the `cbpp` model with `MASS::glmmPQL(cbind(incidence, size - incidence) ~ period, random = ~ 1 | herd, family = binomial, data = cbpp)`. Compare the fixed effects and $\hat\sigma_b$ with `glmer` (Laplace and `nAGQ = 25`). Which method is furthest from the quadrature answer? Why can you not use the PQL fit for a likelihood-ratio test?

## Hints and key numbers (for checking)

- Task 1: $\hat\beta_1 = 11.44$ ms/day, $\hat\sigma_{b0} = 31.0$, $\hat\sigma_{b1} = 6.77$, $\hat\rho = 0.18$, $\hat\sigma = 25.5$. The intercept now refers to Day 2, so $\sigma_{b0}$ and $\rho$ change with the origin (Session 15, exercise 5).
- Task 2 (`set.seed(2027)`): none of the 200 simulated $T$ reaches 42.8 (bootstrap $p < 1/201$); the simulated 95% quantile is about 4.0; the mixture critical value is 5.14.
- Task 3: PQL gives $\hat\beta_{\text{period2}} = -1.016$ and $\hat\sigma_b = 0.556$; Laplace $-0.992$ and $0.642$; `nAGQ = 25` $-0.991$ and $0.648$. PQL maximises a quasi-likelihood of a working LMM, not the GLMM likelihood, so its "log-likelihood" cannot be used for LRTs or AIC.
