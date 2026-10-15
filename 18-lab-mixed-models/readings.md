# Session 18 — Readings

**Topic:** Mixed models in R: `lmer()`, `lme()`, `glmer()`
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

## Required

| Text | Sections | Focus |
|------|----------|-------|
| Wood (2017), *Generalized Additive Models*, 2nd ed. | Ch. 2.5 (linear mixed models in R) | `lme()` and `lmer()` syntax, reading the output, REML vs ML |
| Wood (2017) | Ch. 3.5 (GLMMs with R) | `glmer()` and `glmmPQL()` |
| Lab text | `R Labs/bam-statmod-labs/Lab_04_Mixed_Models/lab.qmd` | Work through all six parts |

## Optional

| Text | Sections | Why |
|------|----------|-----|
| Bates, Mächler, Bolker and Walker (2015), "Fitting linear mixed-effects models using lme4", *Journal of Statistical Software* 67(1) | Sections 1–2, 5 | Formula syntax and the output of `lmer` |
| Faraway (2016), *Extending the Linear Model with R*, 2nd ed. | Ch. 10–11, 13 | More worked examples with `lme4` |

## What to focus on

1. Grouping variables must be factors; `(x | g)` vs `(x || g)`.
2. When a comparison needs ML, and how `anova()` handles it.
3. The boundary correction for variance-component tests.
4. `ranef()` vs `coef()`; the shrinkage factor.
5. `exp(fixef())` of a GLMM is a conditional odds ratio.

## Deliverable

Upload the `.txt` from `tutorial.Rmd` to Blackboard **before Session 19**.

## Next

**Session 19 — Mixed-model exercises.** Revise Sessions 15–17.

## Reading summaries

- [Wood Ch. 2 — Linear mixed models](../15-linear-mixed-models/15-wood-ch2-summary.md)
- [Wood Ch. 3, GLMM sections — Generalized linear mixed models](../17-glmm/17-wood-ch3-glmm-summary.md)
