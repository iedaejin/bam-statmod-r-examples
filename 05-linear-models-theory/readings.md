# Session 5 — Readings

**Topic:** Linear models in theory — matrix formulation, least squares, inference, diagnostics, prediction
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Chapter numbers follow the editions below. Check section numbers against the library copy.

## Required

| Text | Chapters | Focus |
|------|----------|-------|
| Faraway (2014), *Linear Models with R*, 2nd ed. | Ch. 2 (Estimation) | Matrix representation, least squares, the hat matrix, QR decomposition, Gauss–Markov, $R^2$, identifiability |
| | Ch. 3 (Inference) | $t$ and $F$ tests, comparing nested models, confidence intervals for $\beta$ |
| | Ch. 4 (Prediction) | Confidence vs prediction intervals |
| | Ch. 6 (Diagnostics) | Residual plots, leverage, outliers and the Bonferroni test, Cook's distance (the `savings` data are the running example) |
| Kutner et al. (2005), *Applied Linear Statistical Models*, 5th ed. | Ch. 5 | Matrix approach to regression: random vectors, $E$ and Var of linear forms, the hat matrix |
| | Ch. 6 | Multiple regression: estimation, inference, $R^2$, intervals for the mean response and for a new observation |

## Optional

- Pawitan (2001), *In All Likelihood*, Ch. 6 — the normal linear model as a likelihood problem; profile likelihood of $\beta$ (§6.1). The $n-p$ divisor for $\sigma^2$ is justified in Example 10.11.
- Kutner et al. (2005), Ch. 10 — more diagnostics (DFFITS, DFBETAS, added-variable plots).
- Wood (2017), *Generalized Additive Models*, 2nd ed., Ch. 1 — a compact matrix treatment of the linear model, including the QR route to $\hat\beta$. It prepares the GAM block.

## What to focus on

1. Every result today comes from two facts: $\hat\beta$ is a linear function $Ay$ of $y$, and $H$ and $I-H$ are orthogonal projections.
2. Know which assumption each result needs (the A1–A4 table in the deck).
3. Be able to compute, from a printed `summary(lm)` table and an RSS value, any $t$ statistic, CI or nested $F$ test by hand. The midterm has no software.
4. Know what leverage, studentized residuals and Cook's distance measure, and how they relate: $D_i=\frac{r_i^2}{p}\frac{h_{ii}}{1-h_{ii}}$.

## Reading questions

1. Why does $\operatorname{rank}(X)=p$ guarantee that $X^\top X$ is invertible?
2. Which assumptions does the Gauss–Markov theorem use, and which does it not?
3. Why do studentized residuals follow a $t_{n-p-1}$ distribution and not $t_{n-p}$?
4. Why does a prediction interval not shrink to zero width as $n\to\infty$?

## Reading summaries

Study guides to the chapters above. They send you to the book; they do not replace it.

- [Faraway Ch. 2 — Estimation](05-faraway-ch2-summary.md)
- [Faraway Ch. 3 — Inference](05-faraway-ch3-summary.md)
- [Faraway Ch. 4 — Prediction](05-faraway-ch4-summary.md)
- [Faraway Ch. 6 — Diagnostics](../07-lab-linear-models-diagnostics/07-faraway-ch6-summary.md) (in the Session 7 folder)
- [Pawitan Ch. 6 — Modelling relationships: regression models](../09-glm-intro/09-pawitan-ch6-summary.md) (optional; in the Session 9 folder)

## Next

**Session 6 — Linear models in practice and model selection.** Read Faraway (2014) Ch. 5, 10, 11 and 14 before class.
