# Session 11 — Exercises

**Topic:** Lab 03 extensions
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

These tasks extend Lab 03. They are not graded; solutions are discussed in Session 12.

## Task 1 — Cross-validated threshold

On the **training** births only, use 5-fold cross-validation (`set.seed(2027)`) to estimate, for each threshold on a grid from 0.05 to 0.95, the expected cost with $C_{FP}=1$, $C_{FN}=3$. Choose the threshold that minimises the cross-validated cost, then evaluate it once on the test births. Compare with $c^*=0.25$. Why might the two differ?

## Task 2 — Probit and complementary log-log

Refit the `birthwt` model with `binomial(link = "probit")` and `binomial(link = "cloglog")`. Compare AICs and the fitted probabilities with the logit fit. Which coefficients keep an odds-ratio interpretation?

## Task 3 — A count model with an interaction

For `ships`, add the interaction `type:period` to the Poisson model. Test it with an LR test and with a quasi-Poisson $F$ test. How many cells inform each interaction coefficient, and what does that imply about how much you should trust the result?
