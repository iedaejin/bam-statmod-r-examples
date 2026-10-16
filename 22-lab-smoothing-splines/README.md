# Session 22 — Computer Lab — Smoothing and Splines

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Fit** polynomial, kernel, LOESS, regression-spline, smoothing-spline and P-spline smoothers in R.
2. **Choose** a smoothing parameter by shuffled $K$-fold CV and by GCV, and **explain** why fold order matters.
3. **Implement** a P-spline from $B$, $D_d$ and $\lambda$, and **verify** it against `mgcv`.
4. **Compare** smoothers at equal effective df.
5. **Diagnose** non-constant variance from the residuals and **state** its consequences.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_05_Smoothing_Splines](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_05_Smoothing_Splines) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`22-cv-pitfalls.Rmd`](22-cv-pitfalls.Rmd) · [`.R`](22-cv-pitfalls.R) | Cross-validating a smoother: three pitfalls | — |
| [`22-heteroscedasticity.Rmd`](22-heteroscedasticity.Rmd) · [`.R`](22-heteroscedasticity.R) | Non-constant variance in the motorcycle data | — |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Eilers & Marx (1996) — Flexible smoothing with B-splines and penalties](../21-splines/21-eilers-marx-1996-summary.md) (stands in for Eilers & Marx, 2021, Ch. 2–3; in the Session 21 folder)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

- Cleveland, W. S. (1979). Robust Locally Weighted Regression and Smoothing Scatterplots. *Journal of the American Statistical Association* 74(368), 829–836. https://doi.org/10.1080/01621459.1979.10481038
- Craven, P. and Wahba, G. (1978). Smoothing noisy data with spline functions: Estimating the correct degree of smoothing by the method of generalized cross-validation. *Numerische Mathematik* 31(4), 377–403. https://doi.org/10.1007/bf01404567
- Eilers, P. H. C. and Marx, B. D. (1996). Flexible smoothing with B-splines and penalties. *Statistical Science* 11(2), 89–121. https://doi.org/10.1214/ss/1038425655
- Eilers, P. H. C. and Marx, B. D. (2021). *Practical Smoothing: The Joys of P-splines*. Cambridge University Press. https://doi.org/10.1017/9781108610247
- Silverman, B. W. (1985). Some Aspects of the Spline Smoothing Approach to Non-Parametric Regression Curve Fitting. *Journal of the Royal Statistical Society Series B: Statistical Methodology* 47(1), 1–21. https://doi.org/10.1111/j.2517-6161.1985.tb01327.x

---
[← All sessions](../README.md)
