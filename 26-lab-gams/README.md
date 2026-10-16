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
2. **Class notes:** Chapter 16, *Generalized additive models*; Chapter 17, *GAM theory*; Chapter 18, *Advanced GAMs* in the [class notes](../class-notes/StatMod-class-notes.pdf) — full derivations, worked R examples and solved exercises.
3. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
4. **Lab:** [Lab_06_GAMs](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_06_GAMs) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
5. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.
6. **Problem set of this block:** [PS6-gams](../problem-sets/PS6-gams.pdf) — theory, R and interpretation; deadline and solutions on Blackboard.

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

**Recommended reading**

- Wood, S. N. (2017). *Generalized Additive Models: An Introduction with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315370279  
  → Ch. 7 GAMs in practice: mgcv (pp. 325–403)

---
[← All sessions](../README.md)
