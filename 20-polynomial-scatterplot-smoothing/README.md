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
2. **Class notes:** Chapter 14, *Polynomial regression and scatterplot smoothing* in the [class notes](../class-notes/StatMod-class-notes.pdf) — full derivations, worked R examples and solved exercises.
3. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
4. **Lab:** [Lab_05_Smoothing_Splines](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_05_Smoothing_Splines) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
5. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.
6. **Problem set of this block:** [PS5-smoothing](../problem-sets/PS5-smoothing.pdf) — theory, R and interpretation; deadline and solutions on Blackboard.

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

**Recommended reading**

- Eilers, P. H. C. and Marx, B. D. (2021). *Practical Smoothing: The Joys of P-splines*. Cambridge University Press. https://doi.org/10.1017/9781108610247  
  → Ch. 1 Introduction (pp. 1–5)
- Pawitan, Y. (2001). *In All Likelihood: Statistical Modelling and Inference Using Likelihood*. Oxford University Press. https://doi.org/10.1093/oso/9780198507659.001.0001  
  → Ch. 18 Nonparametric smoothing (pp. 473–502)
- Faraway, J. J. (2014). *Linear Models with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/b17144  
  → Ch. 9 Transformation (pp. 133–147)

**Original papers** (optional: where the methods come from)

- Cleveland, W. S. (1979). Robust Locally Weighted Regression and Smoothing Scatterplots. *Journal of the American Statistical Association* 74(368), 829–836. https://doi.org/10.1080/01621459.1979.10481038

---
[← All sessions](../README.md)
