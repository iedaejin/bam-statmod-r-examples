# Session 16 — Estimation and Inference for LMMs

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Derive** the GLS estimator $\hat\beta = (X^\top V^{-1}X)^{-1}X^\top V^{-1}y$ from the marginal likelihood.
2. **Derive** the REML criterion and **explain** why REML is less biased than ML.
3. **Derive** the BLUP and **compute** the shrinkage factor $n_i\sigma_b^2/(n_i\sigma_b^2+\sigma^2)$.
4. **Choose** ML or REML for a given comparison and **test** a variance component on the boundary.
5. **Diagnose** an LMM with conditional residuals and predicted random effects.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_04_Mixed_Models](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_04_Mixed_Models) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`16-gls-ml-reml.Rmd`](16-gls-ml-reml.Rmd) · [`.R`](16-gls-ml-reml.R) | GLS, ML and REML by hand | GLS by hand reproduces `lmer`; The criterion by hand equals `lme4`'s; ML and REML likelihoods for $\sigma_b$; A simulation: 6 groups of 4 observations |
| [`16-blup-shrinkage.Rmd`](16-blup-shrinkage.Rmd) · [`.R`](16-blup-shrinkage.R) | BLUPs and shrinkage | Shrinkage in `sleepstudy`; Unbalanced data: keep only Days 0–1 for six subjects |
| [`16-inference-diagnostics.Rmd`](16-inference-diagnostics.Rmd) · [`.R`](16-inference-diagnostics.R) | Inference and diagnostics for LMMs | Likelihood ratio test for a fixed effect: ML fits; The mixture by simulation; Random slope for `sleepstudy`; Diagnostics for `(Days | Subject)`; Diagnostics in R |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Wood Ch. 2 — Linear mixed models](../15-linear-mixed-models/15-wood-ch2-summary.md)
- [Pawitan Ch. 17 — Random and mixed effects models](../15-linear-mixed-models/15-pawitan-ch17-summary.md) (in the Session 15 folder)
- [Pawitan Ch. 10 — Dealing with nuisance parameters](../28-survival/28-pawitan-ch10-summary.md) (optional: Section 10.6, Example 10.12 derives REML as a modified profile likelihood; in the Session 28 folder)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

- Bates, D., Mächler, M., Bolker, B. and Walker, S. (2015). Fitting Linear Mixed-Effects Models Using lme4. *Journal of Statistical Software* 67(1), 1–48. https://doi.org/10.18637/jss.v067.i01
- Faraway, J. J. (2016). *Extending the Linear Model with R: Generalized Linear, Mixed Effects and Nonparametric Regression Models*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315382722
- Harville, D. A. (1977). Maximum Likelihood Approaches to Variance Component Estimation and to Related Problems. *Journal of the American Statistical Association* 72(358), 320–338. https://doi.org/10.1080/01621459.1977.10480998
- Henderson, C. R. (1975). Best Linear Unbiased Estimation and Prediction under a Selection Model. *Biometrics* 31(2), 423–447. https://doi.org/10.2307/2529430
- Kenward, M. G. and Roger, J. H. (1997). Small Sample Inference for Fixed Effects from Restricted Maximum Likelihood. *Biometrics* 53(3), 983–997. https://doi.org/10.2307/2533558
- Laird, N. M. and Ware, J. H. (1982). Random-Effects Models for Longitudinal Data. *Biometrics* 38(4), 963–974. https://doi.org/10.2307/2529876
- Patterson, H. D. and Thompson, R. (1971). Recovery of inter-block information when block sizes are unequal. *Biometrika* 58(3), 545–554. https://doi.org/10.1093/biomet/58.3.545
- Pawitan, Y. (2001). *In All Likelihood: Statistical Modelling and Inference Using Likelihood*. Oxford University Press. https://doi.org/10.1093/oso/9780198507659.001.0001
- Pinheiro, J. C. and Bates, D. M. (2000). *Mixed-Effects Models in S and S-PLUS*. Springer. https://doi.org/10.1007/b98882
- Robinson, G. K. (1991). That BLUP is a Good Thing: The Estimation of Random Effects. *Statistical Science* 6(1), 15–32. https://doi.org/10.1214/ss/1177011926
- Self, S. G. and Liang, K.-Y. (1987). Asymptotic Properties of Maximum Likelihood Estimators and Likelihood Ratio Tests under Nonstandard Conditions. *Journal of the American Statistical Association* 82(398), 605–610. https://doi.org/10.1080/01621459.1987.10478472
- Stram, D. O. and Lee, J. W. (1994). Variance Components Testing in the Longitudinal Mixed Effects Model. *Biometrics* 50(4), 1171–1177. https://doi.org/10.2307/2533455
- Wood, S. N. (2017). *Generalized Additive Models: An Introduction with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315370279

---
[← All sessions](../README.md)
