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
2. **Class notes:** Chapter 13, *Generalized linear mixed models* in the [class notes](../class-notes/StatMod-class-notes.pdf) — full derivations, worked R examples and solved exercises.
3. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
4. **Lab:** [Lab_04_Mixed_Models](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_04_Mixed_Models) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
5. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.
6. **Problem set of this block:** [PS4-mixed-models](../problem-sets/PS4-mixed-models.pdf) — theory, R and interpretation; deadline and solutions on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`17-cbpp-glmm.Rmd`](17-cbpp-glmm.Rmd) · [`.R`](17-cbpp-glmm.R) | A binomial GLMM: cbpp | A binomial GLM is overdispersed; Fitting `cbpp`: Laplace; Laplace vs quadrature vs PQL; `cbpp`: which probability? |
| [`17-marginal-vs-conditional.Rmd`](17-marginal-vs-conditional.Rmd) · [`.R`](17-marginal-vs-conditional.R) | Conditional vs marginal effects in a logistic GLMM | Conditional and marginal curves; Checking the approximation by simulation |
| [`17-poisson-olre.Rmd`](17-poisson-olre.Rmd) · [`.R`](17-poisson-olre.R) | Poisson GLMM with an observation-level random effect | A Poisson example: `lme4::grouseticks`; Fitting the OLRE model |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Wood Ch. 3, GLMM sections — Generalized linear mixed models](17-wood-ch3-glmm-summary.md)
- [Pawitan Ch. 17 — Random and mixed effects models](../15-linear-mixed-models/15-pawitan-ch17-summary.md) (in the Session 15 folder)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

**Recommended reading**

- Wood, S. N. (2017). *Generalized Additive Models: An Introduction with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315370279  
  → Ch. 3 Generalized linear models (pp. 101–160) — sections on GLMMs

**Original papers** (optional: where the methods come from)

- Breslow, N. E. and Clayton, D. G. (1993). Approximate Inference in Generalized Linear Mixed Models. *Journal of the American Statistical Association* 88(421), 9–25. https://doi.org/10.1080/01621459.1993.10594284
- Zeger, S. L., Liang, K.-Y. and Albert, P. S. (1988). Models for Longitudinal Data: A Generalized Estimating Equation Approach. *Biometrics* 44(4), 1049–1060. https://doi.org/10.2307/2531734

---
[← All sessions](../README.md)
