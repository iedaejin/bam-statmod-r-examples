# Session 10 — Fitting Generalized Linear Models

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Derive** the score, the Fisher information $\mathcal I(\beta)=X^\top WX/a(\phi)$ and the IRLS update of a GLM.
2. **Implement** IRLS in R and reproduce `glm()` to $10^{-8}$.
3. **Compute** deviances, likelihood-ratio tests, AIC and the Pearson dispersion estimate from printed output.
4. **Diagnose** a fit with Pearson, deviance and randomized quantile residuals.
5. **Detect** overdispersion and **choose** between quasi-Poisson and negative binomial models.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **Class notes:** Chapter 9, *Fitting and inference for GLMs* in the [class notes](../class-notes/StatMod-class-notes.pdf) — full derivations, worked R examples and solved exercises.
3. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
4. **Lab:** [Lab_03_GLMs](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_03_GLMs) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
5. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.
6. **Problem set of this block:** [PS3-glm](../problem-sets/PS3-glm.pdf) — theory, R and interpretation; deadline and solutions on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`10-irls-by-hand.Rmd`](10-irls-by-hand.Rmd) · [`.R`](10-irls-by-hand.R) | IRLS by hand | Convergence on `birthwt`; IRLS in R (1/2); IRLS in R (2/2); It reproduces `glm()` |
| [`10-deviance-inference.Rmd`](10-deviance-inference.Rmd) · [`.R`](10-deviance-inference.R) | Likelihood inference and deviance | Worked example: is race needed? |
| [`10-residuals.Rmd`](10-residuals.Rmd) · [`.R`](10-residuals.R) | Residuals for GLMs | Binary data: residual bands are not misfit; Randomized quantile residuals in R |
| [`10-overdispersion-quine.Rmd`](10-overdispersion-quine.Rmd) · [`.R`](10-overdispersion-quine.R) | Overdispersion: school absences | Genuinely overdispersed: `MASS::quine`; Quasi-Poisson vs negative binomial on `quine`; Which variance function?; Residual check; Expected zeros |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Wood Ch. 3 — Generalized linear models](../09-glm-intro/09-wood-ch3-summary.md)
- [Pawitan Ch. 6 — Modelling relationships: regression models](../09-glm-intro/09-pawitan-ch6-summary.md) (§6.6–6.7: deviance and IWLS; in the Session 9 folder)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

**Recommended reading**

- Wood, S. N. (2017). *Generalized Additive Models: An Introduction with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315370279  
  → Ch. 3 Generalized linear models (pp. 101–160)

**Original papers** (optional: where the methods come from)

- Dunn, P. K. and Smyth, G. K. (1996). Randomized Quantile Residuals. *Journal of Computational and Graphical Statistics* 5(3), 236–244. https://doi.org/10.1080/10618600.1996.10474708
- Wedderburn, R. W. M. (1974). Quasi-likelihood functions, generalized linear models, and the Gauss—Newton method. *Biometrika* 61(3), 439–447. https://doi.org/10.1093/biomet/61.3.439

---
[← All sessions](../README.md)
