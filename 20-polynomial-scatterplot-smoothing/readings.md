# Session 20 — Readings

**Topic:** Polynomial regression and scatterplot smoothing
**Course:** Statistical Modelling (BAM), Spring 2027
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Chapter numbers follow the editions listed in the syllabus. Check section numbers against the library copy.

## Required

| Source | Sections | Focus |
|--------|----------|-------|
| Eilers & Marx (2021), *Practical Smoothing: The Joys of P-splines* | Ch. 1 (Introduction) | The smoothing problem, why polynomials and local methods are not enough, the motivation for penalized bases used in Session 21. |
| Faraway (2014), *Linear Models with R*, 2nd ed. | Ch. 9 (Transformation): the sections on polynomials and splines | Polynomial regression as a linear model; orthogonal polynomials with `poly()`; first look at splines. |
| Pawitan (2001), *In All Likelihood* | Ch. 18 (Nonparametric smoothing), opening sections | Smoothing as estimation of a function; the smoothing parameter as a bias–variance compromise. |

## Optional

- Wood (2017), *Generalized Additive Models*, 2nd ed., Section 4.2 (univariate smoothing): basis expansions, penalties and choosing $\lambda$ by cross-validation. Good preparation for Session 21.
- Cleveland (1979), "Robust locally weighted regression and smoothing scatterplots", *Journal of the American Statistical Association* 74, 829–836: the original LOWESS paper.
- Wand & Jones (1995), *Kernel Smoothing*, Ch. 5: bias and variance of Nadaraya–Watson and local linear estimators, including the design-density term.

## What to focus on

1. Why a polynomial fit is **global**: one coefficient vector serves all $x$, so local features compete and the ends are unstable.
2. The difference between numerical conditioning (fixed by orthogonal polynomials) and statistical instability (not fixed).
3. Every smoother in this session is linear, $\hat f = S y$; know how to write $S$ for kNN, Nadaraya–Watson and local linear regression.
4. Effective degrees of freedom $\mathrm{tr}(S)$, and the leave-one-out shortcut $(y_i - \hat f_i)/(1 - S_{ii})$.
5. Why smoothers must be compared at equal effective df.

## R

Knit `20-polynomial-regression.Rmd`, `20-local-smoothers.Rmd` and `20-smoother-matrix-cv.Rmd` before Session 21.
