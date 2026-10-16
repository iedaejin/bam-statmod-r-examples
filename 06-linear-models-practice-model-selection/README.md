# Session 6 — Linear Models in Practice and Model Selection

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Interpret** coefficients of numeric predictors, factors and interactions, including where two group lines cross.
2. **Derive** the omitted-variable bias formula and **explain** sign reversals such as `pop75` in `savings`.
3. **Justify** the hierarchical principle by invariance to shifting and rescaling.
4. **Compare** models with $F$ tests, AIC and BIC, and **state** what each criterion targets.
5. **Write** the glmnet objective and **choose** $\lambda$ by cross-validation with fixed folds.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_02_Linear_Models](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_02_Linear_Models) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`06-confounding.Rmd`](06-confounding.Rmd) · [`.R`](06-confounding.R) | Confounding, omitted-variable bias and collinearity | Same data, opposite signs: `pop75` in `savings`; Confounding in R |
| [`06-categorical-interactions.Rmd`](06-categorical-interactions.Rmd) · [`.R`](06-categorical-interactions.R) | Categorical predictors, interactions and the hierarchical principle | Factors in R: coding, baseline, joint test; Where the lines cross; Fitted lines at three horsepower values; Hierarchy in numbers (`mtcars`) |
| [`06-model-selection.Rmd`](06-model-selection.Rmd) · [`.R`](06-model-selection.R) | Model selection with AIC, BIC and Mallows' Cp | Stepwise selection in R |
| [`06-regularization.Rmd`](06-regularization.Rmd) · [`.R`](06-regularization.R) | Ridge, lasso and elastic net with glmnet | Lasso with fixed folds in R; Coefficient paths and the CV curve |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Faraway Ch. 5 — Explanation](06-faraway-ch5-summary.md)
- [Faraway Ch. 10 — Model Selection](06-faraway-ch10-summary.md)
- [Faraway Ch. 11 — Shrinkage Methods](06-faraway-ch11-summary.md)
- [Faraway Ch. 14 — Categorical Predictors](06-faraway-ch14-summary.md)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

- Akaike, H. (1974). A new look at the statistical model identification. *IEEE Transactions on Automatic Control* 19(6), 716–723. https://doi.org/10.1109/tac.1974.1100705
- Berk, R., Brown, L., Buja, A., et al. (2013). Valid post-selection inference. *The Annals of Statistics* 41(2), 802–837. https://doi.org/10.1214/12-aos1077
- Breiman, L. (2001). Statistical Modeling: The Two Cultures. *Statistical Science* 16(3), 199–231. https://doi.org/10.1214/ss/1009213726
- Burnham, K. P. and Anderson, D. R. (2004). Multimodel Inference: Understanding AIC and BIC in Model Selection. *Sociological Methods & Research* 33(2), 261–304. https://doi.org/10.1177/0049124104268644
- Faraway, J. J. (2014). *Linear Models with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/b17144
- Friedman, J., Hastie, T. and Tibshirani, R. (2010). Regularization Paths for Generalized Linear Models via Coordinate Descent. *Journal of Statistical Software* 33(1), 1–22. https://doi.org/10.18637/jss.v033.i01
- Hastie, T., Tibshirani, R. and Friedman, J. (2009). *The Elements of Statistical Learning*, 2nd ed. Springer New York. https://doi.org/10.1007/978-0-387-84858-7
- Hoerl, A. E. and Kennard, R. W. (1970). Ridge Regression: Biased Estimation for Nonorthogonal Problems. *Technometrics* 12(1), 55–67. https://doi.org/10.1080/00401706.1970.10488634
- Kutner, M. H., Nachtsheim, C. J., Neter, J. and Li, W. (2005). *Applied Linear Statistical Models*, 5th ed. McGraw-Hill/Irwin. ISBN 0072386886
- Mallows, C. L. (1973). Some comments on $C_p$. *Technometrics* 15(4), 661–675. https://doi.org/10.1080/00401706.1973.10489103
- Schwarz, G. (1978). Estimating the Dimension of a Model. *The Annals of Statistics* 6(2), 461–464. https://doi.org/10.1214/aos/1176344136
- Shmueli, G. (2010). To Explain or to Predict?. *Statistical Science* 25(3), 289–310. https://doi.org/10.1214/10-sts330
- Tibshirani, R. (1996). Regression Shrinkage and Selection Via the Lasso. *Journal of the Royal Statistical Society Series B: Statistical Methodology* 58(1), 267–288. https://doi.org/10.1111/j.2517-6161.1996.tb02080.x
- Zou, H. and Hastie, T. (2005). Regularization and Variable Selection Via the Elastic Net. *Journal of the Royal Statistical Society Series B: Statistical Methodology* 67(2), 301–320. https://doi.org/10.1111/j.1467-9868.2005.00503.x

---
[← All sessions](../README.md)
