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
2. **Class notes:** Chapter 7, *Linear models in practice and model selection* in the [class notes](../class-notes/StatMod-class-notes.pdf) — full derivations, worked R examples and solved exercises.
3. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
4. **Lab:** [Lab_02_Linear_Models](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_02_Linear_Models) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
5. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.
6. **Problem set of this block:** [PS2-linear-models](../problem-sets/PS2-linear-models.pdf) — theory, R and interpretation; deadline and solutions on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`06-confounding.Rmd`](06-confounding.Rmd) · [`.R`](06-confounding.R) | Confounding, omitted-variable bias and collinearity | Same data, opposite signs: `pop75` in `savings`; Confounding in R |
| [`06-categorical-interactions.Rmd`](06-categorical-interactions.Rmd) · [`.R`](06-categorical-interactions.R) | Categorical predictors, interactions and the hierarchical principle | Factors in R: coding, baseline, joint test; Where the lines cross; Fitted lines at three horsepower values; Hierarchy in numbers (`mtcars`) |
| [`06-model-selection.Rmd`](06-model-selection.Rmd) · [`.R`](06-model-selection.R) | Model selection with AIC, BIC and Mallows' Cp | Stepwise selection in R |
| [`06-regularization.Rmd`](06-regularization.Rmd) · [`.R`](06-regularization.R) | Ridge, lasso and elastic net with glmnet | Lasso with fixed folds in R; Coefficient paths and the CV curve |

Open `06-linear-models-practice-model-selection.Rproj` first, so that RStudio works inside this folder (never use `setwd()`). Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Faraway Ch. 5 — Explanation](06-faraway-ch5-summary.md)
- [Faraway Ch. 10 — Model Selection](06-faraway-ch10-summary.md)
- [Faraway Ch. 11 — Shrinkage Methods](06-faraway-ch11-summary.md)
- [Faraway Ch. 14 — Categorical Predictors](06-faraway-ch14-summary.md)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

**Recommended reading**

- Faraway, J. J. (2014). *Linear Models with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/b17144  
  → Ch. 5 Explanation (pp. 59–71); Ch. 10 Model selection (pp. 149–160); Ch. 11 Shrinkage methods (pp. 161–181); Ch. 14 Categorical predictors (pp. 205–222)

**Original papers** (optional: where the methods come from)

- Akaike, H. (1974). A new look at the statistical model identification. *IEEE Transactions on Automatic Control* 19(6), 716–723. https://doi.org/10.1109/tac.1974.1100705
- Schwarz, G. (1978). Estimating the Dimension of a Model. *The Annals of Statistics* 6(2), 461–464. https://doi.org/10.1214/aos/1176344136
- Tibshirani, R. (1996). Regression Shrinkage and Selection Via the Lasso. *Journal of the Royal Statistical Society Series B: Statistical Methodology* 58(1), 267–288. https://doi.org/10.1111/j.2517-6161.1996.tb02080.x

---
[← All sessions](../README.md)
