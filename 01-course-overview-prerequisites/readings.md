# Session 1 — Readings

**Topic:** Course introduction and prerequisite review
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Chapter and section numbers follow the editions in the syllabus. Check them against the library copy before publishing.

## Required

| Text | Sections | Notes |
|------|----------|-------|
| Pawitan (2001), *In All Likelihood* | Ch. 1, §1.1–1.5 (pp. 1–19) | What a statistical problem and a statistical model are; why uncertainty leads to likelihood. Read for ideas, not formulas. |
| Faraway (2014), *Linear Models with R*, 2nd ed. | Ch. 1 (Introduction) | Before you start, initial data analysis, when to use linear modelling. Run the R code. |

## Optional (for the prerequisite review)

| Text | Sections | Use it for |
|------|----------|-----------|
| Pawitan (2001) | Ch. 4, §4.1, 4.4, 4.8 | Binomial, Poisson and continuous models seen through the likelihood. A preview of session 3. |
| Faraway (2014) | Ch. 2, §2.1–2.4 | Matrix form of the linear model and least-squares estimation (session 5). |
| Kutner, Nachtsheim, Neter & Li (2005), *Applied Linear Statistical Models*, 5th ed. | Ch. 5 | Matrix approach to simple linear regression: random vectors, $\mathbb E[AY]$, $\mathrm{Var}(AY)$, normal equations. The most gentle matrix review. |
| Wood (2017), *Generalized Additive Models*, 2nd ed. | Appendix "Some matrix algebra" (Appendix B in the 2nd ed.; check) | Covariance matrices, QR, Cholesky, eigen and singular value decompositions. A reference for the whole term. |

## What to focus on

1. The mean and variance of the Bernoulli, binomial, Poisson, normal, exponential and gamma distributions, and how the variance depends on the mean.
2. $\mathbb E[A\boldsymbol Y] = A\mu$ and $\mathrm{Var}(A\boldsymbol Y) = A\Sigma A^\top$; the three properties of the multivariate normal used on the slides.
3. Rank, invertibility and positive definiteness of $X^\top X$; the difference between the normal equations $X^\top X\beta = X^\top y$ and their solution $\hat\beta = (X^\top X)^{-1}X^\top y$.
4. Second-order Taylor expansions; classifying stationary points with the second derivative or the Hessian.

## Reading questions

1. Pawitan §1.2: what makes a problem *statistical* rather than purely mathematical?
2. Pawitan §1.4–1.5: why do different schools of inference disagree, and where does the likelihood sit between them?
3. Faraway Ch. 1: list three checks you would do on a dataset before fitting any model.
4. Why is the Poisson model a strong assumption for count data? What simple check does the `discoveries` example suggest?

## Study pack

- `01-diagnostic-review.md` — 10 ungraded questions (done in class).
- `01-exercises.md` — 8 exercises (derivations, hand computation, R).
- R examples: `01-setup.Rmd`, `01-distributions.Rmd`, `01-matrix-algebra.Rmd`, `01-calculus-optimization.Rmd` (each with a plain `.R` version) and the one-script summary `01-review.R`.

## Reading summaries

Study guides to the chapters above. They send you to the book; they do not replace it.

- [Pawitan Ch. 1 — Introduction](01-pawitan-ch1-summary.md)
- [Faraway Ch. 1 — Introduction](01-faraway-ch1-summary.md)

## Next

**Session 2 — Introduction to statistical modelling:** models as approximations, assumptions, variability, data quality and reproducible analysis in R. Lab 00 (`Lab_00_Reproducible_R`, `nhtemp` data).
