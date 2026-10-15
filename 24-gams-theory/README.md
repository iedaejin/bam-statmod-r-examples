# Session 24 — GAM Theory

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Derive** the PIRLS update from the penalized log-likelihood $\ell(\beta)-\tfrac12\sum_j\lambda_j\beta^\top S_j\beta$.
2. **Explain** why sum-to-zero constraints are needed and how `mgcv` imposes them.
3. **Diagnose** an inadequate basis dimension with `gam.check()` (k-index).
4. **Compare** GCV, UBRE, REML and ML for choosing $\lambda$, and **choose** REML with a reason.
5. **Compute** edf $=\operatorname{tr}(F)$ and posterior credible intervals, and **interpret** approximate $p$-values with their caveats.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_06_GAMs](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_06_GAMs) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`24-penalized-fitting.Rmd`](24-penalized-fitting.Rmd) · [`.R`](24-penalized-fitting.R) | Bases, penalties, identifiability, PIRLS and edf | The smoothing parameter controls the fit; PIRLS by hand reproduces `gam()` |
| [`24-smoothing-selection.Rmd`](24-smoothing-selection.Rmd) · [`.R`](24-smoothing-selection.R) | Choosing smoothing parameters, k, and inference | $k$ too small: a simulated example; `gam.check()` on the airquality model; The criteria as functions of $\lambda$; Three criteria on the three-smooth model; Posterior draws of `s(Wind)`; Effective df of a `loess` fit: `trace.hat`, not `enp` |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Wood Ch. 6 — GAM theory](24-wood-ch6-summary.md)
- [Wood Ch. 5 — Smoothers](../21-splines/21-wood-ch5-summary.md)

---
[← All sessions](../README.md)
