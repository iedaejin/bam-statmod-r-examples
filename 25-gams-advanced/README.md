# Session 25 — Advanced GAMs

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Construct** a tensor-product smooth from marginal bases and penalties, and **explain** its scale invariance.
2. **Specify** an ANOVA decomposition with `ti()` and **judge** when its main effects are interpretable.
3. **Compare** GAMs by AIC and approximate tests, aware of their caveats; **use** `select = TRUE`.
4. **Diagnose** concurvity and residual problems (`concurvity()`, `gam.check()`, residuals vs covariates and time).
5. **Interpret** and **visualise** fitted GAMs on the link and response scales.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_06_GAMs](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_06_GAMs) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`25-tensor-anova.Rmd`](25-tensor-anova.Rmd) · [`.R`](25-tensor-anova.R) | Tensor products, ANOVA decompositions and model comparison | Units matter for `s(x, z)`, not for `te(x, z)`; The tensor-product model for ozone; ANOVA decomposition for ozone; Surface and interaction component; Approximate tests with `anova.gam` |
| [`25-concurvity-selection.Rmd`](25-concurvity-selection.Rmd) · [`.R`](25-concurvity-selection.R) | Concurvity and term selection | Shrinkage selection: `select = TRUE`; A simulation; Same truth, different designs |
| [`25-diagnostics-visualization.Rmd`](25-diagnostics-visualization.Rmd) · [`.R`](25-diagnostics-visualization.R) | Residual diagnostics, interpretation and visualisation | `gam.check()` on the interaction model; Residuals in time order and against fitted values; Predicted median ozone by temperature and wind; A contrast with its uncertainty; Visualisation tools |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Wood Ch. 5 — Smoothers](../21-splines/21-wood-ch5-summary.md)
- [Wood Ch. 6 — GAM theory](../24-gams-theory/24-wood-ch6-summary.md)
- [Wood Ch. 7 — GAMs in practice: mgcv](../26-lab-gams/26-wood-ch7-summary.md)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

- Buja, A., Hastie, T. and Tibshirani, R. (1989). Linear Smoothers and Additive Models. *The Annals of Statistics* 17(2), 453–510. https://doi.org/10.1214/aos/1176347115
- Marra, G. and Wood, S. N. (2011). Practical variable selection for generalized additive models. *Computational Statistics & Data Analysis* 55(7), 2372–2387. https://doi.org/10.1016/j.csda.2011.02.004
- Ramsay, T. O., Burnett, R. T. and Krewski, D. (2003). The Effect of Concurvity in Generalized Additive Models Linking Mortality to Ambient Particulate Matter. *Epidemiology* 14(1), 18–23. https://doi.org/10.1097/00001648-200301000-00009
- Wood, S. N. (2006). Low‐Rank Scale‐Invariant Tensor Product Smooths for Generalized Additive Mixed Models. *Biometrics* 62(4), 1025–1036. https://doi.org/10.1111/j.1541-0420.2006.00574.x
- Wood, S. N. (2011). Fast Stable Restricted Maximum Likelihood and Marginal Likelihood Estimation of Semiparametric Generalized Linear Models. *Journal of the Royal Statistical Society Series B: Statistical Methodology* 73(1), 3–36. https://doi.org/10.1111/j.1467-9868.2010.00749.x
- Wood, S. N. (2013). On p-values for smooth components of an extended generalized additive model. *Biometrika* 100(1), 221–228. https://doi.org/10.1093/biomet/ass048
- Wood, S. N. (2017). *Generalized Additive Models: An Introduction with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315370279
- Wood, S. N., Pya, N. and Säfken, B. (2016). Smoothing Parameter and Model Selection for General Smooth Models. *Journal of the American Statistical Association* 111(516), 1548–1563. https://doi.org/10.1080/01621459.2016.1180986

---
[← All sessions](../README.md)
