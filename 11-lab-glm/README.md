# Session 11 — Computer Lab — GLMs in R

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Fit** binomial and Poisson GLMs with `glm()`, including an offset.
2. **Interpret** odds ratios and rate ratios with profile-likelihood intervals.
3. **Compare** nested models with likelihood-ratio ($\chi^2$) and $F$ tests.
4. **Choose** a classification threshold on training data and **evaluate** it on held-out data.
5. **Diagnose** overdispersion and residual patterns, and **justify** quasi-Poisson vs negative binomial.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_03_GLMs](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_03_GLMs) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`11-binary-toolkit.Rmd`](11-binary-toolkit.Rmd) · [`.R`](11-binary-toolkit.R) | A toolkit for binary GLMs | Odds ratios on the right scale; Testing a block of predictors; Thresholds: choose on training, evaluate on test; The threshold trades sensitivity for specificity |
| [`11-count-toolkit.Rmd`](11-count-toolkit.Rmd) · [`.R`](11-count-toolkit.R) | A toolkit for count GLMs | Poisson for a rate; Overdispersion checks; Randomized quantile residuals |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Wood Ch. 3 — Generalized linear models](../09-glm-intro/09-wood-ch3-summary.md)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

- Cameron, A. C. and Trivedi, P. K. (1990). Regression-based tests for overdispersion in the Poisson model. *Journal of Econometrics* 46(3), 347–364. https://doi.org/10.1016/0304-4076(90)90014-k
- Dunn, P. K. and Smyth, G. K. (1996). Randomized Quantile Residuals. *Journal of Computational and Graphical Statistics* 5(3), 236–244. https://doi.org/10.1080/10618600.1996.10474708
- Faraway, J. J. (2016). *Extending the Linear Model with R: Generalized Linear, Mixed Effects and Nonparametric Regression Models*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315382722
- Fawcett, T. (2006). An introduction to ROC analysis. *Pattern Recognition Letters* 27(8), 861–874. https://doi.org/10.1016/j.patrec.2005.10.010
- Hosmer, D. W., Lemeshow, S. and Sturdivant, R. X. (2013). *Applied Logistic Regression*, 3rd ed. Wiley. https://doi.org/10.1002/9781118548387
- McCullagh, P. and Nelder, J. A. (1989). *Generalized Linear Models*, 2nd ed. Chapman and Hall; reissued 2019, Routledge. https://doi.org/10.1201/9780203753736
- Nelder, J. A. and Wedderburn, R. W. M. (1972). Generalized Linear Models. *Journal of the Royal Statistical Society. Series A (General)* 135(3), 370. https://doi.org/10.2307/2344614
- Venables, W. N. and Ripley, B. D. (2002). *Modern Applied Statistics with S*, 4th ed. Springer New York. https://doi.org/10.1007/978-0-387-21706-2

---
[← All sessions](../README.md)
