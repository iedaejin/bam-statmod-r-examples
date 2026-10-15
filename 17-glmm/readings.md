# Session 17 — Readings

**Topic:** Generalized linear mixed models: definition, likelihood approximations, conditional vs marginal effects
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Section numbers follow the editions listed in the syllabus. Check them against the library copy.

## Required

| Text | Sections | Focus |
|------|----------|-------|
| Wood (2017), *Generalized Additive Models*, 2nd ed. | Ch. 3.4 (generalized linear mixed models) | The GLMM, why the likelihood needs approximation, the Laplace approximation and PQL |
| Wood (2017) | Ch. 3.5 (GLMMs with R), skim | `glmmPQL` and `glmer` in practice |
| Pawitan (2001), *In All Likelihood* | Ch. 17, sections on generalized linear mixed models and approximate likelihood | The integral likelihood and its Laplace approximation, from the likelihood viewpoint of this course |

## Optional

| Text | Sections | Why |
|------|----------|-----|
| Faraway (2016), *Extending the Linear Model with R*, 2nd ed. | Ch. 13 (mixed effect models for nonnormal responses) | Applied GLMM examples in R, PQL vs Laplace vs quadrature |
| Agresti (2013), *Categorical Data Analysis*, 3rd ed. | Ch. 13 | The clearest discussion of conditional vs marginal (population-averaged) effects |
| Zeger, Liang and Albert (1988), *Biometrics* 44, 1049–1060 | Section 3 | Origin of the attenuation approximation $\beta_M\approx\beta_C/\sqrt{1+c^2\sigma_b^2}$ |

## What to focus on

1. $\E[y\mid b] = g^{-1}(X\beta + Zb)$: the GLMM is specified conditionally on $b$.
2. Why the likelihood is an integral without closed form, and how the Laplace approximation replaces it by a Gaussian integral.
3. The roles of `nAGQ` (adaptive quadrature) and of PQL.
4. Conditional vs marginal effects, and the attenuation of logistic coefficients.
5. Overdispersion created by random effects; the observation-level random effect.

## Study pack

- `17-exercises.md`
- R examples: `../17-cbpp-glmm.Rmd`, `../17-marginal-vs-conditional.Rmd`, `../17-poisson-olre.Rmd`

## Next

**Session 18 — Computer lab (Lab 04).** Bring a laptop with `lme4`, `nlme` and `learnr` installed.

## Reading summaries

- [Wood Ch. 3, GLMM sections — Generalized linear mixed models](17-wood-ch3-glmm-summary.md)
- [Pawitan Ch. 17 — Random and mixed effects models](../15-linear-mixed-models/15-pawitan-ch17-summary.md) (in the Session 15 folder)
