# Session 20 — Polynomial Regression and Scatterplot Smoothing

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Explain** why high-degree global polynomials are unstable near the boundaries.
2. **Derive** the Nadaraya–Watson and local linear estimators as weighted least squares.
3. **Write** a smoother as $\hat f = S y$ and **compute** its effective degrees of freedom $\mathrm{tr}(S)$.
4. **Derive** the leave-one-out shortcut $(y_i - \hat f_i)/(1 - S_{ii})$ and use LOOCV and GCV to choose $h$.
5. **Compare** smoothers fairly at equal effective df and **interpret** the bias–variance trade-off.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_05_Smoothing_Splines](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_05_Smoothing_Splines) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`20-polynomial-regression.Rmd`](20-polynomial-regression.Rmd) · [`.R`](20-polynomial-regression.R) | Polynomial regression on the motorcycle data | The conversion in R |
| [`20-local-smoothers.Rmd`](20-local-smoothers.Rmd) · [`.R`](20-local-smoothers.R) | Local smoothers: bins, neighbours, kernels and LOESS | Kernel smoothing in R |
| [`20-smoother-matrix-cv.Rmd`](20-smoother-matrix-cv.Rmd) · [`.R`](20-smoother-matrix-cv.R) | Smoother matrices, effective df and cross-validation | Worked example (continued): residuals and criteria; Choosing $h$ in R |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Faraway Ch. 9 — Transformation](20-faraway-ch9-summary.md)
- [Pawitan Ch. 18 — Nonparametric smoothing](20-pawitan-ch18-summary.md)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

- Cleveland, W. S. (1979). Robust Locally Weighted Regression and Smoothing Scatterplots. *Journal of the American Statistical Association* 74(368), 829–836. https://doi.org/10.1080/01621459.1979.10481038
- Cleveland, W. S. and Devlin, S. J. (1988). Locally Weighted Regression: An Approach to Regression Analysis by Local Fitting. *Journal of the American Statistical Association* 83(403), 596–610. https://doi.org/10.1080/01621459.1988.10478639
- Craven, P. and Wahba, G. (1978). Smoothing noisy data with spline functions: Estimating the correct degree of smoothing by the method of generalized cross-validation. *Numerische Mathematik* 31(4), 377–403. https://doi.org/10.1007/bf01404567
- Eilers, P. H. C. and Marx, B. D. (1996). Flexible smoothing with B-splines and penalties. *Statistical Science* 11(2), 89–121. https://doi.org/10.1214/ss/1038425655
- Eilers, P. H. C. and Marx, B. D. (2021). *Practical Smoothing: The Joys of P-splines*. Cambridge University Press. https://doi.org/10.1017/9781108610247
- Fan, J. (1992). Design-adaptive Nonparametric Regression. *Journal of the American Statistical Association* 87(420), 998–1004. https://doi.org/10.1080/01621459.1992.10476255
- Hastie, T., Tibshirani, R. and Friedman, J. (2009). *The Elements of Statistical Learning*, 2nd ed. Springer New York. https://doi.org/10.1007/978-0-387-84858-7
- Nadaraya, E. A. (1964). On Estimating Regression. *Theory of Probability & Its Applications* 9(1), 141–142. https://doi.org/10.1137/1109020
- Silverman, B. W. (1985). Some Aspects of the Spline Smoothing Approach to Non-Parametric Regression Curve Fitting. *Journal of the Royal Statistical Society Series B: Statistical Methodology* 47(1), 1–21. https://doi.org/10.1111/j.2517-6161.1985.tb01327.x
- Wand, M. P. and Jones, M. C. (1995). *Kernel Smoothing*. Chapman and Hall/CRC. https://doi.org/10.1201/b14876

---
[← All sessions](../README.md)
