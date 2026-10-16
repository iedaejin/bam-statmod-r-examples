# Session 13 — Midterm Review

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Relate** likelihood, least squares and IRLS: show that the linear model is a GLM and that least squares is maximum likelihood.
2. **Compute** an MLE, its standard error and the Wald, score and LR statistics by hand.
3. **Interpret** printed `lm()` and `glm()` output, including interactions, offsets and dispersion.
4. **Compare** nested and non-nested models with $F$, LR, AIC and BIC.
5. **Diagnose** the classic mistakes before they cost points in the midterm.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** we work the problems in groups, by hand first. The R scripts that check the answers are published here after the session.

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

**Recommended reading**

- Pawitan, Y. (2001). *In All Likelihood: Statistical Modelling and Inference Using Likelihood*. Oxford University Press. https://doi.org/10.1093/oso/9780198507659.001.0001  
  → Ch. 2 Elements of likelihood inference (pp. 21–52); Ch. 3 More properties of the likelihood (pp. 53–72); Ch. 9 Large-sample results (pp. 231–271)
- Faraway, J. J. (2014). *Linear Models with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/b17144  
  → Ch. 2 Estimation (pp. 13–31); Ch. 3 Inference (pp. 33–50); Ch. 4 Prediction (pp. 51–58); Ch. 6 Diagnostics (pp. 73–98); Ch. 10 Model selection (pp. 149–160)
- Wood, S. N. (2017). *Generalized Additive Models: An Introduction with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315370279  
  → Ch. 3 Generalized linear models (pp. 101–160)

---
[← All sessions](../README.md)
