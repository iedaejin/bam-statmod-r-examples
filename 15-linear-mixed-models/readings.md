# Session 15 — Readings

**Topic:** Linear mixed models: grouped data, fixed vs random effects, random intercepts and slopes, variance components
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Section numbers follow the editions listed in the syllabus. Check them against the library copy.

## Required

| Text | Sections | Focus |
|------|----------|-------|
| Wood (2017), *Generalized Additive Models: An Introduction with R*, 2nd ed. | Ch. 2.1–2.3 | 2.1: mixed models for balanced data (the one-way random-effects model, why it is a model for the covariance); 2.3: the general LMM $y = X\beta + Zb + \varepsilon$ and its marginal distribution |
| Pawitan (2001), *In All Likelihood* | Ch. 17, first sections (simple random-effects models; normal linear mixed models) | The one-way random-effects model, variance components and the likelihood view of random effects |

## Optional

| Text | Sections | Why |
|------|----------|-----|
| Faraway (2016), *Extending the Linear Model with R*, 2nd ed. | Ch. 10 (random effects) and Ch. 11 (repeated measures and longitudinal data) | Very applied, with `lme4` code; good second reading |
| Gelman and Hill (2007), *Data Analysis Using Regression and Multilevel/Hierarchical Models* | Ch. 12 | The clearest account of complete, no and partial pooling |
| Bates, Mächler, Bolker and Walker (2015), "Fitting linear mixed-effects models using lme4", *Journal of Statistical Software* 67(1) | Sections 1–2 | The formula syntax `(x | g)` and how `lmer` builds $Z$ |

## What to focus on

1. Why the observations of one subject are correlated, and what this does to `lm()` standard errors.
2. The difference between a fixed group effect (a parameter for each level; no assumption about its relation to $X$) and a random group effect (a draw from $N(0,\sigma_b^2)$, independent of $X$).
3. Derive by hand: $\Var(y_{ij})$, $\Cov(y_{ij},y_{ik})$ and the ICC in the random-intercept model.
4. The marginal model $y\sim N(X\beta, ZGZ^\top + \sigma^2 I)$: random effects enter only through the covariance.
5. How to read a standard deviation of random intercepts or slopes in the units of $y$.

## Study pack

- `15-exercises.md` — exercises for this session
- R examples: `../15-pooling.Rmd`, `../15-random-intercept-slope.Rmd`

## Next

**Session 16 — Estimation and inference for LMMs:** ML and REML, GLS, BLUPs and shrinkage, tests for fixed effects and variance components. Read Wood Ch. 2.

## Reading summaries

- [Wood Ch. 2 — Linear mixed models](15-wood-ch2-summary.md)
- [Pawitan Ch. 17 — Random and mixed effects models](15-pawitan-ch17-summary.md)
