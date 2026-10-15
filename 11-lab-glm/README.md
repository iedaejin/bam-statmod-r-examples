# Session 11 — Computer Lab — GLMs in R

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Fit** binomial and Poisson GLMs with `glm()`, including an offset.
2. **Interpret** odds ratios and rate ratios with profile-likelihood intervals.
3. **Compare** nested models with likelihood-ratio ($\chi^2$) and $F$ tests.
4. **Choose** a classification threshold on training data and **evaluate** it on held-out data.
5. **Diagnose** overdispersion and residual patterns, and **justify** quasi-Poisson vs negative binomial.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
3. **Lab:** [Lab_03_GLMs](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_03_GLMs) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
4. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`11-binary-toolkit.Rmd`](11-binary-toolkit.Rmd) · [`.R`](11-binary-toolkit.R) | A toolkit for binary GLMs | Odds ratios on the right scale; Testing a block of predictors; Thresholds: choose on training, evaluate on test; The threshold trades sensitivity for specificity |
| [`11-count-toolkit.Rmd`](11-count-toolkit.Rmd) · [`.R`](11-count-toolkit.R) | A toolkit for count GLMs | Poisson for a rate; Overdispersion checks; Randomized quantile residuals |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Wood Ch. 3 — Generalized linear models](../09-glm-intro/09-wood-ch3-summary.md)

---
[← All sessions](../README.md)
