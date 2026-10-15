# Session 25 — Readings

**Course:** Statistical Modelling (BAM), Spring 2027 · Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

## Required

| Source | Sections | Focus |
|---|---|---|
| Wood (2017), *Generalized Additive Models*, 2nd ed. | 5.6 | Tensor-product smooths: construction, penalties, scale invariance, `ti()` interactions |
| Wood (2017) | 6.12 | Model selection and comparison for GAMs: AIC, approximate tests, shrinkage (`select = TRUE`) |
| Wood (2017) | Ch. 7, one worked example of your choice | How a full GAM analysis is checked and reported |

## Optional

| Source | Sections | Focus |
|---|---|---|
| Wood (2017) | 5.7 | Isotropic versus tensor-product smooths |
| Wood, Pya & Säfken (2016), *JASA* 111 | Section on AIC | Why `mgcv`'s AIC corrects the df for smoothing-parameter uncertainty |
| `?concurvity`, `?gam.selection`, `?vis.gam` in `mgcv` | — | Definitions used by the software |

## What to focus on

1. How a tensor product is built from marginal bases and why it has one smoothing parameter per margin.
2. The difference between `te()`, `ti()` and an isotropic `s(x, z)`.
3. When the main effects of an ANOVA decomposition are interpretable (independent vs dependent covariates).
4. The caveats of `anova.gam` $p$-values; AIC for non-nested models.
5. Concurvity: what it measures and what it does to standard errors.
6. Building intervals on the link scale and transforming them.

## R

Knit the three files in ``.

## Reading summaries

- [Wood Ch. 5 — Smoothers](../21-splines/21-wood-ch5-summary.md)
- [Wood Ch. 6 — GAM theory](../24-gams-theory/24-wood-ch6-summary.md)
- [Wood Ch. 7 — GAMs in practice: mgcv](../26-lab-gams/26-wood-ch7-summary.md)
