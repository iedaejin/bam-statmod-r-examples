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

---
[← All sessions](../README.md)
