# Session 13 — Readings

**Course:** Statistical Modelling (BAM), IE University — Spring 2027
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Chapter numbers follow the editions listed in the syllabus. Check section numbers
against the library copy.

## Required (revision, not new reading)

| Source | Sections | Focus |
|---|---|---|
| Pawitan (2001), *In All Likelihood* | Ch. 2 (likelihood), Ch. 3 (likelihood intervals and tests), Ch. 9 (large-sample results: Wald, score, LR) | Observed vs expected information; why the three tests differ in small samples |
| Faraway (2014), *Linear Models with R*, 2nd ed. | Ch. 2 (estimation), Ch. 3 (inference), Ch. 4 (prediction), Ch. 10 (model selection) | $\hat\beta$, $\mathrm{Var}(\hat\beta)$, $t$ and $F$ tests, AIC/BIC |
| Wood (2017), *Generalized Additive Models*, 2nd ed. | Sec. 3.1 (GLM theory: exponential family, IRLS, deviance), Sec. 3.2 (GLM inference) | $b'(\theta)$, $V(\mu)$, IRLS weights, deviance and $\phi$ |

## Practice

- `13-practice-problems.md` — a full mock midterm (5 problems, 100 points, 2 hours). Do it under exam conditions.
- The exercise sessions: `08-exercises-linear-models/readings/08-exercises.md` and `12-exercises-glm/readings/12-exercises.md`.
- `13-review-practice.Rmd` — checks every number of the review deck in R (for practice only; the midterm uses no software).

## Optional

- Pawitan (2001), Ch. 4 (basic models and simple applications) and Ch. 6 (regression models) for more likelihood examples.
- Faraway (2014), Ch. 6 (diagnostics) if residual plots and Cook's distance are still unclear.

## What to focus on

1. Write $\ell(\theta)$, $S(\theta)$, $I(\theta)$ and $\mathcal{I}(\theta)$ quickly and correctly for a one-parameter model.
2. Know the three tests by heart and when they agree.
3. Read `summary(lm)` and `summary(glm)` output line by line, including interactions and offsets.
4. Put any density in exponential-family form and derive $\mu$, $V(\mu)$, the canonical link and the IRLS weights.
