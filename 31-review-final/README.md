# Session 31 — Final Exam Review

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Relate** the models of the course through likelihood, penalties and random effects.
2. **Choose** a model (LM, GLM, LMM, GLMM, smoother, GAM, GAMM, Cox) from the question and the data structure.
3. **Compare** models with the right tool, including tests on the boundary and REML vs ML.
4. **Diagnose** each model class with its own checks.
5. **Interpret** BLUPs, conditional vs marginal effects, edf and hazard ratios correctly.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** we work the problems in groups, by hand first. The R scripts that check the answers are published here after the session.

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

**Recommended reading**

- Wood, S. N. (2017). *Generalized Additive Models: An Introduction with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315370279  
  → Ch. 2 Linear mixed models (pp. 61–100); Ch. 3 Generalized linear models (pp. 101–160); Ch. 4 Introducing GAMs (pp. 161–194); Ch. 5 Smoothers (pp. 195–248); Ch. 6 GAM theory (pp. 249–324); Ch. 7 GAMs in practice: mgcv (pp. 325–403)
- Pawitan, Y. (2001). *In All Likelihood: Statistical Modelling and Inference Using Likelihood*. Oxford University Press. https://doi.org/10.1093/oso/9780198507659.001.0001  
  → Ch. 11 Complex data structure (pp. 297–340)
- Eilers, P. H. C. and Marx, B. D. (2021). *Practical Smoothing: The Joys of P-splines*. Cambridge University Press. https://doi.org/10.1017/9781108610247  
  → Ch. 2 Bases, penalties, and likelihoods (pp. 6–35); Ch. 3 Optimal smoothing in action (pp. 36–58)

---
[← All sessions](../README.md)
