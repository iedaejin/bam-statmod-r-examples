# Session 26 — Readings

**Course:** Statistical Modelling (BAM), Spring 2027 · Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

## Required

| Source | Sections | Focus |
|---|---|---|
| Lab 06 `lab.qmd` | all | The guided analysis you complete in class |
| Wood (2017), *Generalized Additive Models*, 2nd ed. | Ch. 7, one worked example of your choice | How a GAM analysis is checked, compared and reported |
| Sessions 23–25 slides | — | `summary()` output, REML vs GCV, k-index, concurvity, `te`/`ti`, link-scale intervals |

## Optional

| Source | Focus |
|---|---|
| `?gam.check`, `?concurvity`, `?vis.gam` (`mgcv`) | What the software reports and how |
| `gratia` documentation: `draw()`, `appraise()` | ggplot2 versions of the standard GAM plots |

## What to focus on

1. Comparing models for $y$ and $\log y$ with the Jacobian.
2. Using `gam.check()` to ask *why* a k-index is low.
3. Reading main effects together with a `ti()` interaction.
4. Writing a short, numerical, non-causal interpretation.
