# Session 7 — Exercises

**Topic:** Linear models, diagnostics and selection in R
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

These build on `lab.qmd`. They are not graded; bring your results to Session 8.

## 1. Partial-residual plots for the savings model

Use `car::crPlots(fit)` on the savings model. For each predictor, the plot shows $e+\hat\beta_jx_j$ against $x_j$ with the fitted line of slope $\hat\beta_j$.

(a) Show that the least-squares slope of $e+\hat\beta_jx_j$ on $x_j$ is exactly $\hat\beta_j$ (hint: $X^\top e=0$).
(b) Do any of the four plots suggest a non-linear relationship? Look at `pop15`: fit the model separately to countries with `pop15 > 35` and `pop15 < 35`. What do you conclude about the `pop15` effect?

## 2. Repeated splits and paired comparisons

Wrap Part 2 of the lab in a function `one_split(seed)` that returns the test MSE of full OLS, step AIC, step BIC, lasso `lambda.min` and lasso `lambda.1se`.

(a) Run it for seeds 1 to 50. Report the mean and SD of each method's test MSE.
(b) For lasso `lambda.min` vs full OLS, compute the 50 paired differences. Is their SD smaller than the SD of each method's MSE? Why does pairing help?
(c) Which conclusion about the methods do the 50 splits support that one split did not?

## 3. Elastic net over $\alpha$ with fixed folds

On the training data of the lab, compute the minimum CV error of `cv.glmnet` for $\alpha\in\{0,0.1,0.25,0.5,0.75,1\}$, (a) with the same `foldid` for all $\alpha$, and (b) with a fresh random split of folds for each $\alpha$ (no `foldid`). Repeat (b) a few times. Explain why (a) is the right way to choose $\alpha$, and evaluate only the chosen model on the test set.
