# Session 22 — Computer Lab — Smoothing and Splines

Statistical Modelling (BAM), IE University, Spring 2027 · Prof. Dae-Jin Lee

## By the end of this session you should be able to

1. **Fit** polynomial, kernel, LOESS, regression-spline, smoothing-spline and P-spline smoothers in R.
2. **Choose** a smoothing parameter by shuffled $K$-fold CV and by GCV, and **explain** why fold order matters.
3. **Implement** a P-spline from $B$, $D_d$ and $\lambda$, and **verify** it against `mgcv`.
4. **Compare** smoothers at equal effective df.
5. **Diagnose** non-constant variance from the residuals and **state** its consequences.

## How to follow this session

1. **Before class:** read the required texts in [readings.md](readings.md).
2. **Class notes:** Chapter 14, *Polynomial regression and scatterplot smoothing*; Chapter 15, *Splines and penalized splines* in the [class notes](../class-notes/StatMod-class-notes.pdf) — full derivations, worked R examples and solved exercises.
3. **In class:** open this folder in RStudio (or Positron) and run the scripts below in order. When a slide says *Follow: r-examples/…*, run the matching chunk and compare the output.
4. **Lab:** [Lab_05_Smoothing_Splines](https://github.com/iedaejin/bam-statmod-labs/tree/main/Lab_05_Smoothing_Splines) — work through `lab.qmd`, then submit the `.txt` from `tutorial.Rmd` on Blackboard before the next session.
5. **After class:** try the problems in [exercises.md](exercises.md). Solutions are discussed in class or released on Blackboard.
6. **Problem set of this block:** [PS5-smoothing](../problem-sets/PS5-smoothing.pdf) — theory, R and interpretation; deadline and solutions on Blackboard.

## R scripts, in class order

| Script | What it does | Used in the slides |
|---|---|---|
| [`22-cv-pitfalls.Rmd`](22-cv-pitfalls.Rmd) · [`.R`](22-cv-pitfalls.R) | Cross-validating a smoother: three pitfalls | — |
| [`22-heteroscedasticity.Rmd`](22-heteroscedasticity.Rmd) · [`.R`](22-heteroscedasticity.R) | Non-constant variance in the motorcycle data | — |

Each `.Rmd` has a matching `.R` with the same code: knit the `.Rmd` for a report, or run the `.R` line by line during class.

## Reading summaries

Study guides to the recommended readings: what each chapter says, the key results in course notation, and questions to check yourself. They point you to the book; they do not replace it.

- [Eilers & Marx (1996) — Flexible smoothing with B-splines and penalties](../21-splines/21-eilers-marx-1996-summary.md) (stands in for Eilers & Marx, 2021, Ch. 2–3; in the Session 21 folder)

## References

Cited in the slides. Every entry was checked against Crossref (DOI) or Open Library (ISBN).

**Recommended reading**

- Eilers, P. H. C. and Marx, B. D. (2021). *Practical Smoothing: The Joys of P-splines*. Cambridge University Press. https://doi.org/10.1017/9781108610247  
  → Ch. 2 Bases, penalties, and likelihoods (pp. 6–35); Ch. 3 Optimal smoothing in action (pp. 36–58)

---
[← All sessions](../README.md)
