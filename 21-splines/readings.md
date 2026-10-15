# Session 21 — Readings

**Topic:** Splines: regression and smoothing splines, bases and knots, roughness penalties, P-splines
**Course:** Statistical Modelling (BAM), Spring 2027
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Chapter numbers follow the editions listed in the syllabus. Check section numbers against the library copy.

## Required

| Source | Sections | Focus |
|--------|----------|-------|
| Eilers & Marx (2021), *Practical Smoothing: The Joys of P-splines* | Ch. 2 (bases, penalties and likelihoods) | B-splines, the difference penalty, the P-spline normal equations, effective dimension. Run a few of the book's `JOPS` examples. |
| Eilers & Marx (2021) | Ch. 3 (optimal smoothing) | Choosing $\lambda$: cross-validation, GCV and AIC; the effective dimension as $\mathrm{tr}(S_\lambda)$. |
| Wood (2017), *Generalized Additive Models*, 2nd ed. | Sections 4.2–4.3 | Basis expansions, penalizing wiggliness, choosing $\lambda$ by cross-validation; first additive model. |
| Wood (2017) | Sections 5.1–5.3 | Smoothing splines (natural cubic splines are the smoothest interpolators), penalized regression splines, P-splines in `mgcv`. |

## Optional

- Green & Silverman (1994), *Nonparametric Regression and Generalized Linear Models: A Roughness Penalty Approach*, Ch. 2: the smoothing-spline theorem in full.
- de Boor (1978/2001), *A Practical Guide to Splines*: the B-spline recursion and its properties.
- Eilers & Marx (1996), "Flexible smoothing with B-splines and penalties", *Statistical Science* 11, 89–121: the original P-spline paper, with the polynomial-reproduction and moment properties.

## What to focus on

1. The truncated power basis and why it is badly conditioned; B-splines span the same space.
2. The Cox–de Boor recursion; local support; partition of unity.
3. The smoothing-spline theorem and its integration-by-parts proof.
4. The P-spline estimator $\hat\theta = (B^\top B + \lambda D_d^\top D_d)^{-1}B^\top y$, $S_\lambda$, and $\mathrm{edf} = \mathrm{tr}(S_\lambda)$, including its limits $c$ and $d$.
5. The conditions under which the difference penalty reproduces polynomials and conserves moments.
6. GCV and AIC as functions of $\lambda$.

## R

Knit `21-regression-splines.Rmd`, `21-bsplines-psplines.Rmd` and `21-smoothing-splines.Rmd`. The lab in Session 22 assumes you can run `psfit()` from the second file.

## Reading summaries

- [Wood Ch. 5 — Smoothers](21-wood-ch5-summary.md)
- [Wood Ch. 4 — Introducing GAMs](../23-gams-intro/23-wood-ch4-summary.md)
- [Eilers & Marx (1996) — Flexible smoothing with B-splines and penalties](21-eilers-marx-1996-summary.md) (stands in for Eilers & Marx, 2021, Ch. 2–3)
- [Pawitan Ch. 18 — Nonparametric smoothing](../20-polynomial-scatterplot-smoothing/20-pawitan-ch18-summary.md) (in the Session 20 folder)
