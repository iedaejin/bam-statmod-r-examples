# Session 23 — Introduction to Generalized Additive Models

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **State** the additive model and the GAM $g(\mu_i)=\beta_0+\sum_j f_j(x_{ij})$ with its identifiability constraints.
2. **Diagnose** from residual plots when a linear predictor misses a non-linear effect.
3. **Derive** backfitting as the block-wise (Gauss–Seidel) solution of the penalized normal equations, including $\beta_0$ and centring.
4. **Interpret** `summary()` (edf, Ref.df, $F$/$\chi^2$, $p$) and partial-effect plots of a `gam()` fit.
5. **Choose** a response scale or family and **compare** models by AIC on a common scale.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_06_GAMs](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_06_GAMs) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`23-backfitting.Rmd`](23-backfitting.Rmd) · [`.R`](23-backfitting.R) | Backfitting an additive model by hand | Backfitting in R; Backfitting versus `gam()` |
| [`23-gam-motivation.Rmd`](23-gam-motivation.Rmd) · [`.R`](23-gam-motivation.R) | Why additive models? LM residuals on airquality | Fitting a GAM with `mgcv::gam()`; The `summary()` output |
| [`23-first-gams.Rmd`](23-first-gams.Rmd) · [`.R`](23-first-gams.R) | First GAMs with mgcv: Gaussian, Gamma and binomial | Partial-effect plots; Gamma GAM with a log link; Two models for a positive, skewed response; A binomial GAM: diabetes in Pima women; Pima: one linear and one non-linear effect |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

---
[← All sessions](../README.md)
