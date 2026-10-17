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
2. **Class notes:** Chapter 8, *Exponential families and generalized linear models* in the [class notes](../class-notes/StatMod-class-notes.pdf) — full derivations, worked R examples and solved exercises.
3. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
4. **Lab:** [Lab_03_GLMs](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_03_GLMs) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
5. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.
6. **Problem set of this block:** [PS3-glm](../problem-sets/PS3-glm.pdf) — theory, R and interpretation; deadline and solutions on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`09-logistic-birthwt.Rmd`](09-logistic-birthwt.Rmd) · [`.R`](09-logistic-birthwt.R) | Logistic regression: low birth weight | The linear probability model breaks the range; Fit the logistic model; Output; Odds ratios with profile-likelihood intervals; Predicted probabilities |
| [`09-poisson-ships.Rmd`](09-poisson-ships.Rmd) · [`.R`](09-poisson-ships.R) | Poisson regression with an offset: ship damage | Counts with unequal exposure; Fit the rate model; Rate ratios |
| [`09-exponential-family.Rmd`](09-exponential-family.Rmd) · [`.R`](09-exponential-family.R) | The exponential family in R | Check the identities numerically; Three inverse links for binary data; Mean–variance relationships |
| [`09-classification-pima.Rmd`](09-classification-pima.Rmd) · [`.R`](09-classification-pima.R) | From probabilities to decisions | Choose on training data, evaluate on test data; ROC curves and the leakage trap |

Open `09-glm-intro.Rproj` first, so that RStudio works inside this folder (never use `setwd()`). Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Wood Ch. 3 — Generalized linear models](09-wood-ch3-summary.md)
- [Pawitan Ch. 4 — Basic models and simple applications](09-pawitan-ch4-summary.md)
- [Pawitan Ch. 6 — Modelling relationships: regression models](09-pawitan-ch6-summary.md)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

**Recommended reading**

- Wood, S. N. (2017). *Generalized Additive Models: An Introduction with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315370279  
  → Ch. 3 Generalized linear models (pp. 101–160)
- Pawitan, Y. (2001). *In All Likelihood: Statistical Modelling and Inference Using Likelihood*. Oxford University Press. https://doi.org/10.1093/oso/9780198507659.001.0001  
  → Ch. 4 Basic models and simple applications (pp. 73–116); Ch. 6 Modelling relationships: regression models (pp. 149–192)

**Original papers** (optional: where the methods come from)

- Nelder, J. A. and Wedderburn, R. W. M. (1972). Generalized Linear Models. *Journal of the Royal Statistical Society. Series A (General)* 135(3), 370. https://doi.org/10.2307/2344614

---
[← All sessions](../README.md)
