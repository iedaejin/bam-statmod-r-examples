# Session 28 — Censored and Survival Data

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **State** the types of censoring (right, left, interval) and the non-informative censoring assumption.
2. **Derive** the relations between $S$, $f$, $h$ and $H$, and the likelihood $\prod f(y_i)^{\delta_i} S(y_i)^{1-\delta_i}$.
3. **Compute** the exponential MLE $\hat\lambda = \sum\delta_i/\sum y_i$ with its standard error, and a Kaplan–Meier table with Greenwood standard errors by hand.
4. **Derive** the Cox partial likelihood for distinct event times and **interpret** hazard ratios.
5. **Diagnose** non-proportional hazards with `cox.zph()` and $\log\{-\log \hat S(t)\}$ plots, and **choose** a remedy (stratification, time-varying coefficient).

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_08_Survival](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_08_Survival) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`28-kaplan-meier.Rmd`](28-kaplan-meier.Rmd) · [`.R`](28-kaplan-meier.R) | Kaplan–Meier and the log-rank test | Censoring in ten patients; The Kaplan–Meier curve; Kaplan–Meier in R; Kaplan–Meier by treatment and by cell type; Log-rank test in R |
| [`28-exponential-likelihood.Rmd`](28-exponential-likelihood.Rmd) · [`.R`](28-exponential-likelihood.R) | Likelihood with right censoring: the exponential model | Exponential model in R; Does a constant hazard fit? |
| [`28-cox-model.Rmd`](28-cox-model.Rmd) · [`.R`](28-cox-model.R) | Cox proportional hazards model | Worked example: a toy partial likelihood; Cox model in R; Hazard ratios with 95% intervals |
| [`28-ph-diagnostics.Rmd`](28-ph-diagnostics.Rmd) · [`.R`](28-ph-diagnostics.R) | Checking proportional hazards and fixing a violation | Testing PH in the veteran model; Scaled Schoenfeld residuals for `karno`; Remedies in R; The Karnofsky effect over time |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Pawitan Ch. 11 — Complex data structure](28-pawitan-ch11-summary.md) (Sections 11.5–11.7)
- [Pawitan Ch. 10 — Dealing with nuisance parameters](28-pawitan-ch10-summary.md) (optional; Sections 10.1–10.3, nuisance parameters — the Cox partial likelihood itself is in Ch. 11)

---
[← All sessions](../README.md)
