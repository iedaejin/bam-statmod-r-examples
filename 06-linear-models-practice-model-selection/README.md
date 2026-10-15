# Session 6 — Linear Models in Practice and Model Selection

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Interpret** coefficients of numeric predictors, factors and interactions, including where two group lines cross.
2. **Derive** the omitted-variable bias formula and **explain** sign reversals such as `pop75` in `savings`.
3. **Justify** the hierarchical principle by invariance to shifting and rescaling.
4. **Compare** models with $F$ tests, AIC and BIC, and **state** what each criterion targets.
5. **Write** the glmnet objective and **choose** $\lambda$ by cross-validation with fixed folds.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_02_Linear_Models](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_02_Linear_Models) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`06-confounding.Rmd`](06-confounding.Rmd) · [`.R`](06-confounding.R) | Confounding, omitted-variable bias and collinearity | Same data, opposite signs: `pop75` in `savings`; Confounding in R |
| [`06-categorical-interactions.Rmd`](06-categorical-interactions.Rmd) · [`.R`](06-categorical-interactions.R) | Categorical predictors, interactions and the hierarchical principle | Factors in R: coding, baseline, joint test; Where the lines cross; Fitted lines at three horsepower values; Hierarchy in numbers (`mtcars`) |
| [`06-model-selection.Rmd`](06-model-selection.Rmd) · [`.R`](06-model-selection.R) | Model selection with AIC, BIC and Mallows' Cp | Stepwise selection in R |
| [`06-regularization.Rmd`](06-regularization.Rmd) · [`.R`](06-regularization.R) | Ridge, lasso and elastic net with glmnet | Lasso with fixed folds in R; Coefficient paths and the CV curve |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Faraway Ch. 5 — Explanation](06-faraway-ch5-summary.md)
- [Faraway Ch. 10 — Model Selection](06-faraway-ch10-summary.md)
- [Faraway Ch. 11 — Shrinkage Methods](06-faraway-ch11-summary.md)
- [Faraway Ch. 14 — Categorical Predictors](06-faraway-ch14-summary.md)

---
[← All sessions](../README.md)
