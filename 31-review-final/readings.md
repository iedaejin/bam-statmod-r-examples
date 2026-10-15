# Session 31 — Readings

**Course:** Statistical Modelling (BAM), IE University — Spring 2027
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Chapter numbers follow the editions listed in the syllabus; check them against the library copy.

## Required (revision)

| Source | Sections | Focus |
|---|---|---|
| Wood (2017), *Generalized Additive Models*, 2nd ed. | Ch. 2 (LMMs), Sec. 3.4 (GLMMs), Ch. 4--5 (smoothers, bases, penalties), Ch. 6.1--6.2, 6.6 (smoothing-parameter selection, GAMMs), Ch. 7 (GAMs in practice) | Penalties as random effects; REML for $\lambda$; edf |
| Pawitan (2001), *In All Likelihood* | Ch. 10 (partial likelihood), Ch. 11 (censored data), Ch. 17 (random effects) | Partial likelihood; BLUP |
| Eilers & Marx (2021), *Practical Smoothing* | Ch. 2--3 | P-splines, difference penalties |

## Practice

- `../31-review-practice.Rmd` — reproduces the six problems of the review deck.
- Labs 03--08 (`Lab_03_GLMs` … `Lab_08_Survival`): Part II uses the same functions.

## Optional

- Faraway (2016), *Extending the Linear Model with R*, 2nd ed., chapters on mixed models and GAMs, for more worked examples.

## What to focus on

1. The decision chart: response type × grouping × shape → model.
2. Which comparison tool when (nested/non-nested, REML/ML, boundary tests).
3. Interpretation: conditional vs marginal effects, BLUP shrinkage, edf, hazard ratios.
4. Diagnostics per model class.
