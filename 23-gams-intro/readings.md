# Session 23 — Readings

**Course:** Statistical Modelling (BAM), Spring 2027 · Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

## Required

| Source | Sections | Focus |
|---|---|---|
| Wood (2017), *Generalized Additive Models: An Introduction with R*, 2nd ed. | Ch. 4, Sections 4.1–4.6 | Univariate smoothing with a basis and a penalty (4.2), additive models and their identifiability constraints (4.3), GAMs and their fitting (4.4), first use of `mgcv` (4.6) |
| Session 21 slides and notes | — | B-spline bases, difference penalties, edf as a trace |

## Optional

| Source | Sections | Focus |
|---|---|---|
| Hastie & Tibshirani (1990), *Generalized Additive Models* | Ch. 4 | Backfitting, its normal equations and convergence |
| Hastie, Tibshirani & Friedman (2009), *The Elements of Statistical Learning*, 2nd ed. | Section 9.1 | Short presentation of additive models, backfitting and local scoring |

## What to focus on

1. The additive predictor $\eta=\beta_0+\sum_j f_j(x_j)$ and why the $f_j$ must be centred.
2. How a smooth term becomes columns of a model matrix plus a penalty $\lambda_j\boldsymbol\beta_j^\top S_j\boldsymbol\beta_j$.
3. Backfitting as the solution of the penalized normal equations one block at a time.
4. The `summary()` table of `gam()`: what edf, Ref.df and the approximate $p$-values are, and what they are not.
5. Choosing the response scale: transform $y$, or keep $y$ and choose a family and link.

## R

Knit `23-gam-motivation.Rmd`, `23-backfitting.Rmd` and `23-first-gams.Rmd`.

## Reading summaries

- [Wood Ch. 4 — Introducing GAMs](23-wood-ch4-summary.md)
