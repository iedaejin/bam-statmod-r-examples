# Session 7 — Readings

**Topic:** Lab 02 — linear models, diagnostics and selection in R
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

## Before the lab

| Text | Chapter | Focus |
|------|---------|-------|
| Faraway (2014), *Linear Models with R*, 2nd ed. | Ch. 6 (Diagnostics) | Checking error assumptions, finding unusual observations (leverage, outliers, influence); the `savings` example is the one used in the lab |
| | Ch. 7 (Problems with the predictors) | Collinearity and variance inflation factors |
| | Ch. 10–11 | Revisit stepwise selection, AIC/BIC and the lasso (Faraway uses `lars` on other data; the lab uses `glmnet` on `prostate`) |

## Optional

- The `glmnet` vignette ("An Introduction to glmnet", Hastie, Qian and Tay), sections on `cv.glmnet` and `foldid`.
- Kutner et al. (2005), *Applied Linear Statistical Models*, 5th ed., Ch. 10 — further influence measures (DFFITS, DFBETAS).

## What to focus on

1. The difference between a high-leverage point, an outlier and an influential point.
2. Why the outlier test needs a Bonferroni correction.
3. Why every modelling choice must be made without the test data.

## Reading summaries

Study guides to the chapters above. They send you to the book; they do not replace it.

- [Faraway Ch. 6 — Diagnostics](07-faraway-ch6-summary.md)
- [Faraway Ch. 7 — Problems with the Predictors](07-faraway-ch7-summary.md)
- [Faraway Ch. 10 — Model Selection](../06-linear-models-practice-model-selection/06-faraway-ch10-summary.md) (Session 6)
- [Faraway Ch. 11 — Shrinkage Methods](../06-linear-models-practice-model-selection/06-faraway-ch11-summary.md) (Session 6)

## Next

**Session 8 — Linear-model exercises.** Bring a calculator; no software.
