# Session 16 — Readings

**Topic:** Estimation and inference for LMMs: GLS, ML and REML, BLUPs, tests, diagnostics
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Section numbers follow the editions listed in the syllabus. Check them against the library copy.

## Required

| Text | Sections | Focus |
|------|----------|-------|
| Wood (2017), *Generalized Additive Models*, 2nd ed. | Ch. 2.4 | Maximum likelihood for LMMs: the marginal likelihood, $\hat\beta$ by GLS, profile likelihood, REML, the "BLUP" of the random effects and the link to penalised least squares |
| Wood (2017) | Ch. 2.5 | Linear mixed models in R: `lme()` and `lmer()`, reading their output |
| Pawitan (2001), *In All Likelihood* | Ch. 17 (joint estimation of $\beta$ and $b$; computing the variance components) | Henderson's mixed model equations from a likelihood point of view |

## Optional

| Text | Sections | Why |
|------|----------|-----|
| Faraway (2016), *Extending the Linear Model with R*, 2nd ed. | Ch. 10 (estimation, inference, predicting random effects, diagnostics) | Applied treatment of LRTs, the boundary problem and parametric bootstrap |
| Pinheiro and Bates (2000), *Mixed-Effects Models in S and S-PLUS* | Ch. 2 | The original account of ML/REML computation in `nlme` |
| Theory note | `../notes/theory/LMM-Variance-Components-Estimation.pdf` | Longer derivations of ML, REML and the mixed model equations |

## What to focus on

1. The GLS estimator and its variance $(X^\top V^{-1}X)^{-1}$.
2. The REML criterion $\ell_R = \ell_P - \tfrac12\log|X^\top V^{-1}X| + \text{const}$ and the special case $\text{RSS}/(n-p)$.
3. REML is *less* biased than ML, not unbiased in general.
4. The BLUP $\tilde b = GZ^\top V^{-1}(y-X\hat\beta)$ and the random-intercept shrinkage factor.
5. Which comparisons need ML (different fixed effects) and why a variance component test is non-standard (50:50 mixture).

## Study pack

- `16-exercises.md`
- R examples: `../16-gls-ml-reml.Rmd`, `../16-blup-shrinkage.Rmd`, `../16-inference-diagnostics.Rmd`

## Next

**Session 17 — GLMMs.** Read Wood Ch. 3.4.
