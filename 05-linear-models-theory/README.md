# Session 5 — Linear Models in Theory

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Derive** the normal equations and the least-squares estimator $\hat\beta=(X^\top X)^{-1}X^\top y$.
2. **Prove** that $H=X(X^\top X)^{-1}X^\top$ is a symmetric idempotent projection with $\operatorname{tr}H=p$, and use it to show $E[\mathrm{RSS}]=\sigma^2(n-p)$.
3. **Compute** standard errors, $t$ statistics, confidence intervals and nested-model $F$ tests from RSS and $(X^\top X)^{-1}$.
4. **Diagnose** a fitted model with residual plots, leverage, studentized residuals and Cook's distance.
5. **Distinguish** a confidence interval for the mean response from a prediction interval.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_02_Linear_Models](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_02_Linear_Models) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`05-inference.Rmd`](05-inference.Rmd) · [`.R`](05-inference.R) | Inference for linear-model coefficients | Fit in R; Standard errors by hand; $F$ test: do `pop75` and `dpi` add anything?; Minus twice the log-likelihood, and a check in R |
| [`05-diagnostics-prediction.Rmd`](05-diagnostics-prediction.Rmd) · [`.R`](05-diagnostics-prediction.R) | Diagnostics and prediction | Savings: residual plots; Leverage, studentized residuals and influence together; Diagnostics in R; Cook's distance and what Libya changes; Worked example: a country with `pop15`=35, `pop75`=2, `dpi`=1000, `ddpi`=3 |
| [`05-least-squares.Rmd`](05-least-squares.Rmd) · [`.R`](05-least-squares.R) | Least squares in matrix form | Normal equations, $H$ and QR in R |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Faraway Ch. 2 — Estimation](05-faraway-ch2-summary.md)
- [Faraway Ch. 3 — Inference](05-faraway-ch3-summary.md)
- [Faraway Ch. 4 — Prediction](05-faraway-ch4-summary.md)
- [Faraway Ch. 6 — Diagnostics](../07-lab-linear-models-diagnostics/07-faraway-ch6-summary.md) (in the Session 7 folder)
- [Pawitan Ch. 6 — Modelling relationships: regression models](../09-glm-intro/09-pawitan-ch6-summary.md) (optional; in the Session 9 folder)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

- Belsley, D. A., Kuh, E. and Welsch, R. E. (1980). *Regression Diagnostics: Identifying Influential Data and Sources of Collinearity*. Wiley. https://doi.org/10.1002/0471725153
- Cook, R. D. (1977). Detection of Influential Observation in Linear Regression. *Technometrics* 19(1), 15–18. https://doi.org/10.1080/00401706.1977.10489493
- Faraway, J. J. (2014). *Linear Models with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/b17144
- Kutner, M. H., Nachtsheim, C. J., Neter, J. and Li, W. (2005). *Applied Linear Statistical Models*, 5th ed. McGraw-Hill/Irwin. ISBN 0072386886

---
[← All sessions](../README.md)
