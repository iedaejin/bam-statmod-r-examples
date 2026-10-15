# Session 16 — Exercises

**Topic:** GLS, ML and REML, BLUPs, tests for LMMs
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Notation: $y\sim N(X\beta, V)$, $V = ZGZ^\top + \sigma^2 I$; random-intercept variance $\sigma_b^2$; groups $i = 1,\dots,m$ with $n_i$ observations.

## Exercise 1 — GLS as a weighted mean (derivation + computation)

Consider the random-intercept model with no covariate, $y_{ij} = \beta_0 + b_{0i} + \varepsilon_{ij}$, and possibly unequal $n_i$.

(a) Using $V_i^{-1} = \sigma^{-2}\bigl(I - \frac{\sigma_b^2}{\sigma^2+n_i\sigma_b^2}\mathbf 1\mathbf 1^\top\bigr)$, show that $\mathbf 1^\top V_i^{-1}\mathbf 1 = n_i/(\sigma^2 + n_i\sigma_b^2)$ and $\mathbf 1^\top V_i^{-1}y_i = n_i\bar y_{i\cdot}/(\sigma^2 + n_i\sigma_b^2)$.

(b) Deduce that the GLS estimator is a weighted mean of the group means,
$$\hat\beta_0 = \frac{\sum_i w_i\bar y_{i\cdot}}{\sum_i w_i},\qquad w_i = \frac{1}{\sigma_b^2 + \sigma^2/n_i},\qquad \Var(\hat\beta_0) = \Bigl(\sum_i w_i\Bigr)^{-1}.$$
Interpret $w_i$.

(c) Three groups have data $\{5, 7\}$, $\{4, 6, 8, 6\}$, $\{10\}$. With $\sigma_b^2 = 4$ and $\sigma^2 = 2$ compute $\hat\beta_0$, its standard error and the three BLUPs $\tilde b_{0i}$.

## Exercise 2 — REML in the linear model (derivation)

(a) For $y = X\beta + \varepsilon$, $\varepsilon\sim N(0,\sigma^2 I_n)$, show that $\E[\text{RSS}] = \sigma^2(n-p)$.

(b) Write $\ell_R(\sigma^2)$ for this model using $\ell_R = -\tfrac12[(n-p)\log2\pi + \log|V| + \log|X^\top V^{-1}X| + r^\top V^{-1}r]$, and show that it is maximised at $\text{RSS}/(n-p)$.

(c) Explain in two sentences why the REML likelihood of two models with different $X$ cannot be compared.

## Exercise 3 — ML, REML and ANOVA in a balanced one-way design (R + algebra)

The data `Dyestuff` (package `lme4`) give the yield of dyestuff for 5 preparations from each of $m = 6$ batches.

(a) Run `anova(lm(Yield ~ Batch, data = Dyestuff))` and compute the moment (ANOVA) estimators $\hat\sigma^2 = \text{MSW}$ and $\hat\sigma_b^2 = (\text{MSB} - \text{MSW})/n$.

(b) Fit `lmer(Yield ~ 1 + (1 | Batch))` with REML and with ML. Show that REML reproduces the ANOVA estimates and that the ML estimate of $\sigma_b^2$ equals $\bigl[(1-1/m)\text{MSB} - \text{MSW}\bigr]/n$.

(c) Which estimator of $\sigma_b^2$ is unbiased here, and why does this not contradict the statement "REML is not unbiased in general"?

## Exercise 4 — BLUPs by hand

For `Rail` (package `nlme`; 6 rails, 3 measurements each) the REML fit of `travel ~ 1 + (1 | Rail)` gives $\hat\beta_0 = 66.5$, $\hat\sigma_b^2 = 615.3$, $\hat\sigma^2 = 16.17$. Rail "2" has mean travel time 31.67.

(a) Compute the shrinkage factor and the BLUP of rail 2's random effect.

(b) Explain why the shrinkage is so small here. Keeping $n_i = 3$ and $\hat\sigma_b^2 = 615.3$, how large would $\sigma^2$ have to be for the BLUP to keep only half of the raw deviation?

(c) Check your answers with `ranef()`.

## Exercise 5 — Testing a variance component

(a) For `Dyestuff`, compute the LRT statistic for $H_0: \sigma_b^2 = 0$ with ML fits (`lm(Yield ~ 1)` vs the ML `lmer`). Give the naive and the boundary-corrected p-value.

(b) Explain why, under $H_0$, the LRT statistic equals 0 with probability about 1/2.

(c) For which observed values of $T$ do the naive $\chi^2_1$ test and the mixture test disagree at the 5% level?

## Exercise 6 — ML or REML?

For each comparison, say whether the two models should be fitted with ML or REML, and give the reference distribution of the LRT.

(a) `y ~ x + (1 | g)` vs `y ~ x + z + (1 | g)`.
(b) `y ~ x + (1 | g)` vs `y ~ x + (x | g)`.
(c) `y ~ x + (x || g)` vs `y ~ x + (x | g)` (the correlation only).
(d) `y ~ x` (with `lm`) vs `y ~ x + (1 | g)`.

## Exercise 7 — Diagnostics in R

Fit `lmer(Reaction ~ Days + (Days | Subject), sleepstudy)`.

(a) Draw the conditional residuals against fitted values and their normal QQ plot. Which three observations have the largest standardised residuals?

(b) Draw normal QQ plots of the predicted intercepts and slopes. Which subject has the largest predicted slope? Compare its slope with the one from its own `lm()` fit.

(c) Explain why the standard deviation of the 18 predicted slopes is smaller than $\hat\sigma_{b1}$.
