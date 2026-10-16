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
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_03_GLMs](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_03_GLMs) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

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

- Aitkin, M. (1978). The Analysis of Unbalanced Cross-Classifications. *Journal of the Royal Statistical Society. Series A (General)* 141(2), 195–211. https://doi.org/10.2307/2344453
- Akaike, H. (1974). A new look at the statistical model identification. *IEEE Transactions on Automatic Control* 19(6), 716–723. https://doi.org/10.1109/tac.1974.1100705
- Cameron, A. C. and Trivedi, P. K. (1990). Regression-based tests for overdispersion in the Poisson model. *Journal of Econometrics* 46(3), 347–364. https://doi.org/10.1016/0304-4076(90)90014-k
- Dunn, P. K. and Smyth, G. K. (1996). Randomized Quantile Residuals. *Journal of Computational and Graphical Statistics* 5(3), 236–244. https://doi.org/10.1080/10618600.1996.10474708
- Faraway, J. J. (2016). *Extending the Linear Model with R: Generalized Linear, Mixed Effects and Nonparametric Regression Models*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315382722
- Lambert, D. (1992). Zero-Inflated Poisson Regression, with an Application to Defects in Manufacturing. *Technometrics* 34(1), 1–14. https://doi.org/10.2307/1269547
- McCullagh, P. and Nelder, J. A. (1989). *Generalized Linear Models*, 2nd ed. Chapman and Hall; reissued 2019, Routledge. https://doi.org/10.1201/9780203753736
- Mullahy, J. (1986). Specification and testing of some modified count data models. *Journal of Econometrics* 33(3), 341–365. https://doi.org/10.1016/0304-4076(86)90002-3
- Nelder, J. A. and Wedderburn, R. W. M. (1972). Generalized Linear Models. *Journal of the Royal Statistical Society. Series A (General)* 135(3), 370. https://doi.org/10.2307/2344614
- Venables, W. N. and Ripley, B. D. (2002). *Modern Applied Statistics with S*, 4th ed. Springer New York. https://doi.org/10.1007/978-0-387-21706-2
- Wedderburn, R. W. M. (1974). Quasi-likelihood functions, generalized linear models, and the Gauss—Newton method. *Biometrika* 61(3), 439–447. https://doi.org/10.1093/biomet/61.3.439
- Wood, S. N. (2017). *Generalized Additive Models: An Introduction with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315370279

---
[← All sessions](../README.md)
