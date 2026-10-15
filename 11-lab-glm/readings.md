# Session 11 — Readings

**Topic:** Computer lab — GLMs in R (Lab 03)
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

## Required

| Text | Sections | Focus |
|------|----------|-------|
| Wood (2017), *Generalized Additive Models: An Introduction with R*, 2nd ed. | Ch. 3.3 (GLMs with R) | `glm()`, `anova()` for GLMs, residual plots, quasi-likelihood in practice |
| Session 9 and 10 slides | — | Odds and rate ratios, deviance tests, Pearson dispersion, randomized quantile residuals |

## Optional

- Venables and Ripley (2002), *Modern Applied Statistics with S*, 4th ed., Ch. 7 (binomial and Poisson GLMs; the `birthwt` example is in Sec. 7.2, the negative binomial in Sec. 7.4).
- McCullagh and Nelder (1989), *Generalized Linear Models*, 2nd ed., Sec. 6.3.2 (the ship-damage data).

## What to focus on

1. Reading coefficients on the response scale: odds ratios and rate ratios, with profile intervals.
2. One test per question: a likelihood-ratio test for a block of terms.
3. The threshold is a tuning parameter: choose it on training data (or from costs), evaluate once on test data.
4. What overdispersion does to standard errors, and how the two remedies differ.

## Before the lab

- Pull the lab repository and open `Lab_03_GLMs`.
- Re-read the slides "The cost-optimal threshold" (Session 9) and "Two remedies" (Session 10).

## Next

**Session 12 — GLM exercises:** distribution and link choice, likelihoods, interpretation, deviance tests from output, diagnostics, an applied problem.

## Reading summaries

- [Wood Ch. 3 — Generalized linear models](../09-glm-intro/09-wood-ch3-summary.md)
