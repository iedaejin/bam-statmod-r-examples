# Session 6 — Exercises

**Topic:** Linear models in practice and model selection
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Notation: $X$ is $n\times p$ including the intercept column; $\mathrm{RSS}$ residual sum of squares; $k$ = number of estimated parameters in AIC/BIC.

## 1. Interaction with a factor

`lm(mpg ~ wt * am, data = mtcars)` with `am` a factor (`automatic` baseline, `manual`), `wt` in 1000 lb:

```
            Estimate Std. Error t value Pr(>|t|)
(Intercept)  31.4161     3.0201  10.402  4.0e-11
wt           -3.7859     0.7856  -4.819  4.6e-05
ammanual     14.8784     4.2640   3.489  0.00162
wt:ammanual  -5.2984     1.4447  -3.667  0.00102
```

(a) Write the fitted line for each transmission type.
(b) At what weight do the two lines cross? For which weights does the model predict higher mpg for manual cars?
(c) If `wt` is replaced by `wt_c = wt - 3`, which of the four coefficients change, and what are their new values? Interpret the new `ammanual` coefficient.
(d) The interaction $F$ statistic from `anova(lm(mpg ~ wt + am), lm(mpg ~ wt * am))` is 13.45. Show how it relates to the table.

## 2. Omitted-variable bias (derivation and numbers)

(a) Let the true model be $y=X_1\beta_1+X_2\beta_2+\varepsilon$ and let $\tilde\beta_1=(X_1^\top X_1)^{-1}X_1^\top y$. Derive $E[\tilde\beta_1]$.
(b) Show the in-sample identity $\tilde\beta_1=\hat\beta_1+\hat\Delta\hat\beta_2$, where $(\hat\beta_1,\hat\beta_2)$ are from the long regression and $\hat\Delta=(X_1^\top X_1)^{-1}X_1^\top X_2$.
(c) In `savings`, `lm(sr ~ pop75 + pop15)` gives $\hat\beta_{75}=-1.934$, $\hat\beta_{15}=-0.471$, and `lm(pop15 ~ pop75)` gives slope $-6.441$. Compute the slope of `lm(sr ~ pop75)` without fitting it.
(d) Give one condition under which omitting $X_2$ causes no bias for $\beta_1$, and explain why including an irrelevant but correlated $X_2$ still has a cost.

## 3. The hierarchical principle (proof)

(a) Show that for any $c$, $\operatorname{span}\{\mathbf 1,x,x^2\}=\operatorname{span}\{\mathbf 1,x-c,(x-c)^2\}$, but in general $\operatorname{span}\{\mathbf 1,x^2\}\ne\operatorname{span}\{\mathbf 1,(x-c)^2\}$. What does this imply for the fitted values and RSS?
(b) In $E[y]=\beta_0+\beta_1x_1+\beta_2x_2+\beta_3x_1x_2$, substitute $x_1=x_1'+c_1$, $x_2=x_2'+c_2$. Express the new coefficients $(\beta_0',\beta_1',\beta_2',\beta_3')$ in terms of the old ones.
(c) For `mpg ~ wt * hp`: $\hat\beta=(49.808,\,-8.2166,\,-0.12010,\,0.027848)$. Compute the coefficients after centring `wt` at 3 and `hp` at 150, and interpret $\hat\beta_1'$.

## 4. Coding a factor

`lm(mpg ~ cyl, data = mtcars)` with `cyl` a factor. The group means of `mpg` are 26.664 (4 cyl, $n=11$), 19.743 (6 cyl, $n=7$), 15.100 (8 cyl, $n=14$).

(a) Under treatment coding (baseline 4), write the $3$ distinct rows of $X$ and give the three coefficients.
(b) Under `contr.sum`, the dummy columns are $(1,0,-1)$ and $(0,1,-1)$ for levels (4, 6, 8). Write the three rows of $X$ and find the coefficients. What does the intercept estimate? Is it the overall mean of `mpg` (20.091)?
(c) Show that both codings give the same fitted values. Which quantities do not depend on the coding?

## 5. AIC, BIC and $C_p$ by hand

For `prostate` ($n=97$), three models:

| Model | Predictors | $p$ (columns incl. intercept) | RSS |
|---|---|---|---|
| A | all 8 | 9 | 44.163 |
| B | lcavol, lweight, age, lbph, svi | 6 | 45.526 |
| C | lcavol, lweight, svi | 4 | 47.785 |

(a) Compute $-2\hat\ell=n\log(2\pi)+n\log(\mathrm{RSS}/n)+n$, AIC and BIC for each model ($k=p+1$). Which model does each criterion choose?
(b) Compute `extractAIC` $=n\log(\mathrm{RSS}/n)+2p$ for each model and check that its differences equal the AIC differences.
(c) Compute Mallows' $C_p=\mathrm{RSS}_p/\hat\sigma^2_A-n+2p$ with $\hat\sigma^2_A=\mathrm{RSS}_A/(n-9)$. Compare each $C_p$ with $p$.
(d) Test model C against model A with an $F$ test. Does the conclusion agree with BIC?

## 6. Lasso and ridge (derivation)

Consider the glmnet objective with no intercept, $\frac{1}{2n}\lVert y-X\beta\rVert^2+\lambda\left[\frac{1-\alpha}{2}\lVert\beta\rVert_2^2+\alpha\lVert\beta\rVert_1\right]$.

(a) Ridge ($\alpha=0$): derive the minimiser and show it exists even when $X^\top X$ is singular.
(b) Lasso ($\alpha=1$) with orthonormal design $X^\top X=nI$: show that the problem separates into $p$ one-dimensional problems and that $\hat\beta_j=\operatorname{sign}(z_j)(|z_j|-\lambda)_+$ with $z_j=x_j^\top y/n$.
(c) Under the same design, what does ridge do to $z_j$? Explain why the lasso sets coefficients exactly to zero and ridge does not.

## 7. Cross-validation with fixed folds (R)

Use `faraway::prostate`, `x <- as.matrix(prostate[, 1:8])`, `y <- prostate$lpsa`.

(a) Run `cv.glmnet(x, y)` three times after `set.seed(1)`, `set.seed(2)`, `set.seed(3)` and record `lambda.min` and `lambda.1se`. What changes and why?
(b) Create `foldid` with `set.seed(606); foldid <- sample(rep(1:10, length.out = 97))` and compare the minimum CV error for $\alpha\in\{0,0.25,0.5,0.75,1\}$ on these folds. Why must the folds be the same across $\alpha$?
(c) Refit with one predictor rescaled (`lweight * 100`) with and without `standardize = TRUE`. Explain the difference.

## 8. Explanation or prediction?

For each task, say whether it is mainly explanation or prediction, which tool you would use to choose the model (prior specification, $F$ tests, AIC, BIC, CV/lasso) and what you would report.

(a) A health agency wants a score that predicts PSA from routine clinical measures for triage.
(b) A researcher asks whether seminal vesicle invasion (`svi`) is associated with PSA after adjusting for tumour volume and prostate weight.
(c) An economist asks whether the age structure of a population is associated with its savings rate, controlling for income growth.
