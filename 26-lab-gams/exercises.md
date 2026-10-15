# Session 26 — Exercises

**Course:** Statistical Modelling (BAM), Spring 2027 · Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

For pairs who finish early, or as practice before Session 27. Code: `26-lab06-extensions.Rmd`.

### Task 1 (Gamma interaction model)
Refit the `ti(Temp, Wind)` model with `family = Gamma(link = "log")` on `Ozone`. Compare its AIC with the additive Gamma GAM. Compute the ratio of **mean** ozone at 90 vs 70 °F (Wind 10, Solar.R 207) and compare it with the ratio of medians from the lab (3.58).
*Check:* AIC goes from 918.1 to 899.7.

### Task 2 (shrinkage)
Refit the lab's `ti` model with `select = TRUE`. Which terms keep most of their edf? Does any term shrink to zero?

### Task 3 (month effect)
Add `Month` as a factor to the `ti` model. Its Wald test gives $p=0.16$, yet AIC decreases from 137.9 to 135.7. Explain how both can be true, and decide whether to keep `Month`.
