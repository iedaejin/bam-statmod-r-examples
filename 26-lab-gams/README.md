# Session 26 — Computer Lab — GAMs with `mgcv`

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Diagnose** from residual plots when a linear predictor misses non-linear effects.
2. **Choose** a response scale or family and **compare** them by AIC on a common scale.
3. **Fit** GAMs with REML and **check** them with `gam.check()` and `concurvity()`.
4. **Compare** an additive model with `te(Temp, Wind)` and `ti(Temp, Wind)`.
5. **Communicate** a GAM through predictions with honest intervals.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_06_GAMs](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_06_GAMs) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`26-lab06-extensions.Rmd`](26-lab06-extensions.Rmd) · [`.R`](26-lab06-extensions.R) | Lab 06 extensions: Gamma family, shrinkage and a parametric month effect | — |
| [`26-lab06-walkthrough.Rmd`](26-lab06-walkthrough.Rmd) · [`.R`](26-lab06-walkthrough.R) | Lab 06 walk-through: from LM to GAM on airquality | — |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Wood Ch. 7 — GAMs in practice: mgcv](26-wood-ch7-summary.md)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

- Pedersen, E. J., Miller, D. L., Simpson, G. L. and Ross, N. (2019). Hierarchical generalized additive models in ecology: an introduction with mgcv. *PeerJ* 7, e6876. https://doi.org/10.7717/peerj.6876
- Ramsay, T. O., Burnett, R. T. and Krewski, D. (2003). The Effect of Concurvity in Generalized Additive Models Linking Mortality to Ambient Particulate Matter. *Epidemiology* 14(1), 18–23. https://doi.org/10.1097/00001648-200301000-00009
- Wood, S. N. (2006). Low‐Rank Scale‐Invariant Tensor Product Smooths for Generalized Additive Mixed Models. *Biometrics* 62(4), 1025–1036. https://doi.org/10.1111/j.1541-0420.2006.00574.x
- Wood, S. N. (2011). Fast Stable Restricted Maximum Likelihood and Marginal Likelihood Estimation of Semiparametric Generalized Linear Models. *Journal of the Royal Statistical Society Series B: Statistical Methodology* 73(1), 3–36. https://doi.org/10.1111/j.1467-9868.2010.00749.x
- Wood, S. N. (2017). *Generalized Additive Models: An Introduction with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315370279

---
[← All sessions](../README.md)
