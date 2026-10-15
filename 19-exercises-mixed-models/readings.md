# Session 19 — Readings

**Topic:** Mixed-model exercises: choosing fixed and random effects, comparing structures, variance components, predictions, diagnostics
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

## Required (revise before class)

| Source | Sections | Focus |
|------|----------|-------|
| Slides and exercises of Sessions 15–17 | all | Model, marginal covariance, ML/REML, BLUPs, tests, GLMMs |
| Wood (2017), *Generalized Additive Models*, 2nd ed. | Ch. 2 exercises; Ch. 3.4 | Practice on LMM algebra and GLMM ideas |
| Lab 04 | `lab.qmd` | The R side of every problem |

## Optional

| Text | Sections | Why |
|------|----------|-----|
| Faraway (2016), *Extending the Linear Model with R*, 2nd ed. | Exercises of Ch. 10, 11 and 13 | More applied problems with printed output |
| Pinheiro and Bates (2000), *Mixed-Effects Models in S and S-PLUS* | Ch. 1 (the `Orthodont` and `Rail` examples) | Original analyses of the data used today |

## What to focus on

1. The decision fixed vs random: population, number of levels, independence of group effects and covariates.
2. $V = ZGZ^\top + \sigma^2 I$ for small designs; ICC; $k_i$.
3. ML vs REML and the boundary mixture in model comparison.
4. Reading `VarCorr` on the data scale; the effect of centring on $\sigma_{b0}$ and $\rho$.
5. Conditional vs marginal GLMM effects.

## Study pack

- `19-exercises.md` — the problems of the session
- R checks: `../19-exercise-checks.Rmd`

## Next

**Session 20 — Polynomial and scatterplot smoothing** (Eilers & Marx Ch. 1; Pawitan Ch. 18; Faraway Ch. 9).

## Reading summaries

- [Wood Ch. 2 — Linear mixed models](../15-linear-mixed-models/15-wood-ch2-summary.md)
