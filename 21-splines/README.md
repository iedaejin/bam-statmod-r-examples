# Session 21 — Splines

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Construct** truncated power and B-spline bases and **compute** B-spline values with the Cox–de Boor recursion.
2. **Prove** that the minimizer of the penalized criterion with $\int f''^2$ is a natural cubic spline.
3. **Derive** the P-spline estimator, its smoother $S_\lambda$ and $\mathrm{edf} = \mathrm{tr}(S_\lambda)$.
4. **State** and **prove** the polynomial-reproduction and moment properties of the difference penalty, with their conditions.
5. **Choose** $\lambda$ by GCV or AIC and **check** a hand-coded P-spline against `mgcv`.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_05_Smoothing_Splines](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_05_Smoothing_Splines) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`21-bsplines-psplines.Rmd`](21-bsplines-psplines.Rmd) · [`.R`](21-bsplines-psplines.R) | B-splines and P-splines from scratch | Building a B-spline basis in R; A P-spline in a few lines; Check against `mgcv` |
| [`21-regression-splines.Rmd`](21-regression-splines.Rmd) · [`.R`](21-regression-splines.R) | Regression splines: truncated powers, bs() and ns() | — |
| [`21-smoothing-splines.Rmd`](21-smoothing-splines.Rmd) · [`.R`](21-smoothing-splines.R) | Smoothing splines and penalized truncated power splines | — |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

---
[← All sessions](../README.md)
