# Session 7 — Computer Lab — Linear Models and Diagnostics in R

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Fit** and **interpret** a multiple regression in R, with confidence intervals and a nested $F$ test.
2. **Diagnose** a fit: residual plots, leverage, studentized residuals with a Bonferroni cut-off, Cook's distance, VIF.
3. **Assess** what an influential point changes, and **justify** whether to keep it.
4. **Compare** stepwise (AIC, BIC) and lasso models on a test set that was not used for fitting, tuning or standardizing.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_02_Linear_Models](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_02_Linear_Models) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`07-lab-part1-savings.Rmd`](07-lab-part1-savings.Rmd) · [`.R`](07-lab-part1-savings.R) | Lab 02 walk-through, Part 1: inference and diagnostics | Setup; Part 1.1–1.2: fit, intervals, nested $F$ test; Part 1.3: the four default diagnostic plots; Part 1.4: leverage, outliers, influence; Part 1.5: collinearity |
| [`07-lab-part2-prostate.Rmd`](07-lab-part2-prostate.Rmd) · [`.R`](07-lab-part2-prostate.R) | Lab 02 walk-through, Part 2: selection and the lasso | Part 2.1: split, then step with AIC and BIC; Part 2.2: lasso with fixed folds; Part 2.3: one honest comparison |

The scripts read the CSV files in [`data/`](data/) with relative paths. Set the working directory to this folder (open it as an RStudio project, or *Session → Set Working Directory → To Source File Location*).

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Faraway Ch. 6 — Diagnostics](07-faraway-ch6-summary.md)
- [Faraway Ch. 7 — Problems with the Predictors](07-faraway-ch7-summary.md)
- [Faraway Ch. 10 — Model Selection](../06-linear-models-practice-model-selection/06-faraway-ch10-summary.md) (Session 6)
- [Faraway Ch. 11 — Shrinkage Methods](../06-linear-models-practice-model-selection/06-faraway-ch11-summary.md) (Session 6)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

**Recommended reading**

- Faraway, J. J. (2014). *Linear Models with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/b17144  
  → Ch. 6 Diagnostics (pp. 73–98); Ch. 7 Problems with the predictors (pp. 99–111)

---
[← All sessions](../README.md)
