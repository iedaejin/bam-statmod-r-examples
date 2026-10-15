# Session 22 — Readings

**Topic:** Computer lab: smoothers, regression and smoothing splines, choosing smoothing parameters, comparison and diagnostics (Lab 05)
**Course:** Statistical Modelling (BAM), Spring 2027
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Chapter numbers follow the editions listed in the syllabus. Check section numbers against the library copy.

## Required

| Source | Sections | Focus |
|--------|----------|-------|
| Eilers & Marx (2021), *Practical Smoothing: The Joys of P-splines* | Ch. 2 | Building $B$ and $D_d$, the P-spline normal equations, effective dimension. Compare your `pspline()` with the book's code. |
| Eilers & Marx (2021) | Ch. 3 | Choosing $\lambda$ by cross-validation, GCV and AIC; what to look for in residuals. |
| Lab text | `R Labs/bam-statmod-labs/Lab_05_Smoothing_Splines/lab.qmd` | Work through all sections before or during the session. |

## Optional

- Wood (2017), *Generalized Additive Models*, 2nd ed., Section 5.3 (P-splines in `mgcv`, the `bs = "ps"` basis) and the `mgcv` help page `?smooth.construct.ps.smooth.spec` (what `k` and `m` mean).
- Silverman (1985), "Some aspects of the spline smoothing approach to non-parametric curve fitting", *Journal of the Royal Statistical Society, Series B* 47, 1–52: the paper that introduced the motorcycle data, including its discussion of non-constant variance.

## What to focus on

1. Why cross-validation folds must be shuffled on sorted data, and why `predict.loess()` needs `surface = "direct"` inside CV.
2. Computing $\mathrm{edf} = \mathrm{tr}(S)$ for each method and comparing smoothers at equal edf.
3. The P-spline estimator in code, and how to check it against `mgcv` (same knots, same criterion).
4. Reading residual plots for non-constant variance and stating its consequences.

## R

`22-cv-pitfalls.Rmd` and `22-heteroscedasticity.Rmd` go beyond the lab; the second is needed for extension exercise 1.
