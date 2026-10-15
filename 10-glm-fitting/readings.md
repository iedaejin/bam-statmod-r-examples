# Session 10 — Readings

**Topic:** Fitting GLMs: IRLS, likelihood inference, deviance, residuals, overdispersion
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

## Required

| Text | Sections | Focus |
|------|----------|-------|
| Wood (2017), *Generalized Additive Models: An Introduction with R*, 2nd ed. | Ch. 3.1: the sections on fitting GLMs, the large-sample distribution of $\hat\beta$, comparing models, estimating $\phi$ (Pearson), residuals and quasi-likelihood; Ch. 3.2 (geometry of IRLS) | The IRLS derivation, deviance and LR tests, Pearson estimate of $\phi$, quasi-likelihood |

Check section numbers against the library copy.

## Optional

- Dunn, P. K. and Smyth, G. K. (1996). Randomized quantile residuals. *Journal of Computational and Graphical Statistics*, 5(3), 236–244.
- Cameron, A. C. and Trivedi, P. K. (1990). Regression-based tests for overdispersion in the Poisson model. *Journal of Econometrics*, 46(3), 347–364.
- Faraway (2016), *Extending the Linear Model with R*, 2nd ed., Ch. 5 (count regression: dispersion, negative binomial, zero-inflated models) and Ch. 8 (GLM theory).
- Venables and Ripley (2002), *Modern Applied Statistics with S*, 4th ed., Sec. 7.4 (negative binomial; the `quine` data).

## What to focus on

1. Why IRLS is Fisher scoring, and why it equals Newton–Raphson only for the canonical link.
2. Deviance differences as likelihood-ratio statistics; when $\phi$ must be estimated, the $F$ test.
3. Why the deviance is not a goodness-of-fit test for binary data.
4. The Pearson estimate $\hat\phi=X^2/(n-p)$ and what quasi-likelihood changes (only standard errors).
5. How randomized quantile residuals turn a discrete response into $N(0,1)$ residuals.
6. Quasi-Poisson vs negative binomial: the shape of the variance function.

## Reading questions

1. Write the IRLS weight and working response for a Poisson log-linear model.
2. Show that for nested models the LR statistic equals the difference of scaled deviances.
3. A Poisson fit has $X^2=120$ on 40 df. By what factor do quasi-Poisson standard errors exceed the Poisson ones?
4. What is $\mathrm{Var}(Y)$ for the negative binomial with mean $\mu$ and size $k$? What happens as $k\to\infty$?

## Next

**Session 11 — Lab 03 (GLMs in R):** `birthwt` (logistic regression, LR tests, a threshold evaluated on held-out data) and `ships` (Poisson with offset, overdispersion, quasi-Poisson vs NB, residuals).
