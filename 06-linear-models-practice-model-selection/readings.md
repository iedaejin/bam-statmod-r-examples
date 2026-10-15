# Session 6 — Readings

**Topic:** Linear models in practice and model selection
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Chapter numbers follow Faraway (2014), 2nd ed. Check section numbers against the library copy.

## Required

| Text | Chapter | Focus |
|------|---------|-------|
| Faraway (2014), *Linear Models with R*, 2nd ed. | Ch. 5 (Explanation) | Interpreting coefficients, confounding, causal vs observational language |
| | Ch. 10 (Model selection) | Hierarchical models, testing-based procedures and their problems, AIC, BIC, $C_p$, adjusted $R^2$ (prostate data) |
| | Ch. 11 (Shrinkage methods) | Ridge regression, lasso; read the parts on ridge and lasso, skim principal components and PLS |
| | Ch. 14 (Categorical predictors) | Factors with two and more levels, dummy coding, interactions with a factor, alternative codings |

## Optional

- Kutner et al. (2005), *Applied Linear Statistical Models*, 5th ed., Ch. 8 (qualitative predictors, interactions) and Ch. 9 (model selection, $C_p$).
- Hastie, Tibshirani and Wainwright (2015), *Statistical Learning with Sparsity*, Ch. 2 — the lasso for linear models, soft thresholding, cross-validation.
- Shmueli (2010), "To explain or to predict?", *Statistical Science* 25(3) — the two goals of modelling.
- Breiman (2001), "Statistical modeling: the two cultures", *Statistical Science* 16(3) — read in Session 2; revisit with selection in mind.

## What to focus on

1. A coefficient's meaning depends on which other variables are in the model (Faraway Ch. 5).
2. The omitted-variable bias formula and when it is zero.
3. Why main effects must stay when an interaction or a square is in the model.
4. What AIC and BIC estimate, and why $p$-values after selection are not valid (Faraway Ch. 10).
5. The glmnet objective; why predictors are standardized; how $\lambda$ is chosen (Faraway Ch. 11 and the `glmnet` vignette).

## Reading questions

1. Faraway's savings example: why does the `pop75` coefficient change sign when `pop15` is added?
2. If a factor has 4 levels, how many columns does it add to $X$ under treatment coding? Why not 4?
3. What does it mean for BIC to be "consistent", and why is AIC not?
4. Why can ridge regression be computed even when $X^\top X$ is singular?

## Next

**Session 7 — Computer lab (Lab 02).** Bring a laptop with R, `faraway`, `car`, `glmnet` and `learnr` installed.
