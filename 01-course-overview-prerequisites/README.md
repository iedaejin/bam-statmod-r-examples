# Session 1 — Course Introduction and Prerequisite Review

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Describe** the structure, assessment rules and GenAI policy of the course.
2. **State** the mean and variance of the distributions used in the course and **derive** them for the Poisson and the gamma.
3. **Compute** $\mathbb E[AY]$ and $\mathrm{Var}(AY) = A\Sigma A^\top$ for a random vector.
4. **Derive** the normal equations $X^\top X\beta = X^\top y$ from the gradient of $(y - X\beta)^\top(y - X\beta)$ and **state** when their solution is unique.
5. **Classify** a stationary point with the second derivative or the Hessian, and **write** a second-order Taylor expansion.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_00_Reproducible_R](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_00_Reproducible_R) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`01-distributions.Rmd`](01-distributions.Rmd) · [`.R`](01-distributions.R) | Probability distributions in R | d, p, q, r in R; Checking $A\bSigma A\T$ by simulation |
| [`01-matrix-algebra.Rmd`](01-matrix-algebra.Rmd) · [`.R`](01-matrix-algebra.R) | Matrix algebra for linear models | Normal equations in R |
| [`01-calculus-optimization.Rmd`](01-calculus-optimization.Rmd) · [`.R`](01-calculus-optimization.R) | Derivatives and optimization | Score, information and a numerical check in R |
| [`01-setup.Rmd`](01-setup.Rmd) · [`.R`](01-setup.R) | Setup | Next session and before it |
| [`01-review.R`](01-review.R) | R script | — |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Pawitan Ch. 1 — Introduction](01-pawitan-ch1-summary.md)
- [Faraway Ch. 1 — Introduction](01-faraway-ch1-summary.md)

---
[← All sessions](../README.md)
