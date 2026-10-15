# Session 17 — Generalized Linear Mixed Models

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Write** a GLMM for clustered binomial or count data, conditional on the random effects.
2. **Explain** why the GLMM likelihood has no closed form and **derive** the Laplace approximation.
3. **Compare** Laplace, adaptive Gauss–Hermite quadrature and PQL fits.
4. **Distinguish** conditional from marginal effects and **derive** the logistic attenuation $\beta_M\approx\beta_C/\sqrt{1+0.346\,\sigma_b^2}$.
5. **Interpret** `glmer` output on the odds-ratio or rate-ratio scale.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_04_Mixed_Models](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_04_Mixed_Models) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`17-cbpp-glmm.Rmd`](17-cbpp-glmm.Rmd) · [`.R`](17-cbpp-glmm.R) | A binomial GLMM: cbpp | A binomial GLM is overdispersed; Fitting `cbpp`: Laplace; Laplace vs quadrature vs PQL; `cbpp`: which probability? |
| [`17-marginal-vs-conditional.Rmd`](17-marginal-vs-conditional.Rmd) · [`.R`](17-marginal-vs-conditional.R) | Conditional vs marginal effects in a logistic GLMM | Conditional and marginal curves; Checking the approximation by simulation |
| [`17-poisson-olre.Rmd`](17-poisson-olre.Rmd) · [`.R`](17-poisson-olre.R) | Poisson GLMM with an observation-level random effect | A Poisson example: `lme4::grouseticks`; Fitting the OLRE model |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

---
[← All sessions](../README.md)
