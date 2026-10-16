# Session 18 — Computer Lab — Mixed Models in R

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Fit** LMMs with `lmer()` and `lme()` and **interpret** their variance components.
2. **Choose** REML or ML for each comparison and **test** a random slope with the boundary correction.
3. **Compute** BLUPs and the shrinkage factor, and **draw** a shrinkage plot.
4. **Diagnose** an LMM with residuals and predicted random effects.
5. **Fit** a binomial GLMM and **distinguish** conditional from marginal effects.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **Class notes:** Chapter 11, *Linear mixed models*; Chapter 12, *Estimation and inference for linear mixed models*; Chapter 13, *Generalized linear mixed models* in the [class notes](../class-notes/StatMod-class-notes.pdf) — full derivations, worked R examples and solved exercises.
3. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
4. **Lab:** [Lab_04_Mixed_Models](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_04_Mixed_Models) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
5. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.
6. **Problem set of this block:** [PS4-mixed-models](../problem-sets/PS4-mixed-models.pdf) — theory, R and interpretation; deadline and solutions on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`18-lab-walkthrough.Rmd`](18-lab-walkthrough.Rmd) · [`.R`](18-lab-walkthrough.R) | Lab 04 walk-through: lmer, lme and glmer | Setup; Part 1: three ways to pool |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Wood Ch. 2 — Linear mixed models](../15-linear-mixed-models/15-wood-ch2-summary.md)
- [Wood Ch. 3, GLMM sections — Generalized linear mixed models](../17-glmm/17-wood-ch3-glmm-summary.md)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

**Recommended reading**

- Wood, S. N. (2017). *Generalized Additive Models: An Introduction with R*, 2nd ed. Chapman and Hall/CRC. https://doi.org/10.1201/9781315370279  
  → Ch. 2 Linear mixed models (pp. 61–100); Ch. 3 Generalized linear models (pp. 101–160)

---
[← All sessions](../README.md)
