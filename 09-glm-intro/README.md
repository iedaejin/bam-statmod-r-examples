# Session 9 — Introduction to Generalized Linear Models

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Write** the Bernoulli, binomial, Poisson, normal and gamma distributions in exponential-family form $f(y;\theta,\phi)=\exp\{[y\theta-b(\theta)]/a(\phi)+c(y,\phi)\}$.
2. **Derive** $\mathrm{E}[Y]=b'(\theta)$ and $\mathrm{Var}(Y)=b''(\theta)\,a(\phi)$ from the two score identities.
3. **Identify** the random component, the linear predictor and the link of a GLM, and the canonical link.
4. **Interpret** logistic coefficients as odds ratios and Poisson coefficients (with an offset) as rate ratios.
5. **Choose** a classification threshold from misclassification costs on training data and evaluate it once on held-out data.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_03_GLMs](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_03_GLMs) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`09-logistic-birthwt.Rmd`](09-logistic-birthwt.Rmd) · [`.R`](09-logistic-birthwt.R) | Logistic regression: low birth weight | The linear probability model breaks the range; Fit the logistic model; Output; Odds ratios with profile-likelihood intervals; Predicted probabilities |
| [`09-poisson-ships.Rmd`](09-poisson-ships.Rmd) · [`.R`](09-poisson-ships.R) | Poisson regression with an offset: ship damage | Counts with unequal exposure; Fit the rate model; Rate ratios |
| [`09-exponential-family.Rmd`](09-exponential-family.Rmd) · [`.R`](09-exponential-family.R) | The exponential family in R | Check the identities numerically; Three inverse links for binary data; Mean–variance relationships |
| [`09-classification-pima.Rmd`](09-classification-pima.Rmd) · [`.R`](09-classification-pima.R) | From probabilities to decisions | Choose on training data, evaluate on test data; ROC curves and the leakage trap |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

---
[← All sessions](../README.md)
