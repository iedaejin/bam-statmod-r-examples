# Session 23 — Exercises

**Course:** Statistical Modelling (BAM), Spring 2027 · Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Use $\alpha=0.05$ where needed. Exercises 1–4 are by hand; 5–7 use R (`mgcv`, `MASS`).

### Exercise 1 (identifiability)
Consider the additive model $y_i=\beta_0+f_1(x_{i1})+f_2(x_{i2})+\varepsilon_i$.
(a) Show that $(\beta_0,f_1,f_2)$ is not identifiable without constraints.
(b) With the constraints $\sum_i f_j(x_{ij})=0$, $j=1,2$, show that the penalized least-squares estimate of $\beta_0$ is $\bar y$.
(c) Does (b) still hold for a Poisson GAM with log link? Explain.

### Exercise 2 (backfitting equations)
Let $A_1,A_2$ be $n\times n$ smoother matrices with $A_j=B_j(B_j^\top B_j+\lambda_jS_j)^{-1}B_j^\top$.
(a) Show that the minimiser of $Q=\lVert\boldsymbol y-\beta_0\mathbf 1-B_1\boldsymbol\beta_1-B_2\boldsymbol\beta_2\rVert^2+\lambda_1\boldsymbol\beta_1^\top S_1\boldsymbol\beta_1+\lambda_2\boldsymbol\beta_2^\top S_2\boldsymbol\beta_2$ satisfies $\boldsymbol f_1=A_1(\boldsymbol y-\beta_0\mathbf 1-\boldsymbol f_2)$ and $\boldsymbol f_2=A_2(\boldsymbol y-\beta_0\mathbf 1-\boldsymbol f_1)$.
(b) Suppose $A_1\mathbf 1=\mathbf 1$ and $A_2\mathbf 1=\mathbf 1$, and that $(\boldsymbol f_1,\boldsymbol f_2)$ is a fixed point of the uncentred backfitting equations with $\beta_0=0$. Show that $(\boldsymbol f_1+c\mathbf 1,\ \boldsymbol f_2-c\mathbf 1)$ is also a fixed point for every $c$. What does centring achieve?

### Exercise 3 (convergence rate and correlated covariates)
Let $x_1,x_2$ be centred, with sample correlation $r$, and use the projection smoothers $A_j=x_j(x_j^\top x_j)^{-1}x_j^\top$ (straight-line fits without intercept).
(a) Show that backfitting converges to the least-squares fit of $y$ on $(x_1,x_2)$.
(b) Show that the error in $\boldsymbol f_1$ is multiplied by $r^2$ at each full sweep.
(c) How many sweeps are needed to reduce the error by a factor $10^{6}$ when $r=0.5$? When $r=0.95$?

### Exercise 4 (AIC on a common scale)
A Gaussian GAM for $\log(\text{Ozone})$ has AIC $166.40$, a Gamma GAM with log link for Ozone has AIC $918.13$, and $\sum_{i=1}^{111}\log y_i=379.17$.
(a) Derive $\text{AIC}_Y=\text{AIC}_{\log Y}+2\sum_i\log y_i$.
(b) Which model has the lower AIC on the Ozone scale, and by how much?

### Exercise 5 (reading output, R)
Fit `m <- gam(log(Ozone) ~ s(Solar.R) + s(Wind) + s(Temp), data = aq, method = "REML")` on the 111 complete cases.
(a) Report the edf of each smooth and say which effect is closest to linear.
(b) Use `predict(..., type = "lpmatrix")` to estimate the change in $\log$(Ozone) when Wind goes from 5 to 15 mph, at Solar.R $=207$ and Temp $=79$. Give a 95% interval for the ratio of median ozone.
(c) Refit with the default `method`. Which smooth changes most? (Session 24 explains why.)

### Exercise 6 (Gamma GAM, R)
Fit the Gamma GAM with log link of the deck.
(a) Estimate the ratio of **mean** ozone at 90 °F versus 70 °F (Solar.R $=207$, Wind $=9.7$) with a 95% interval.
(b) Compare with the ratio of **median** ozone from the log-response model (2.58). Why are the two quantities different in principle?

### Exercise 7 (binomial GAM, R)
Use `pima <- rbind(MASS::Pima.tr, MASS::Pima.te)` and fit `type ~ s(glu) + s(bmi) + s(age) + s(ped)` with `family = binomial`, `method = "REML"`.
(a) Which smooth has edf $=1$? Compute the odds ratio for glucose 150 vs 100 mg/dl, with a 95% interval, and compare with the linear logistic GLM.
(b) Compute the odds ratio for age 45 vs 25 (glu $=120$, bmi $=32$, ped $=0.4$) and the two fitted probabilities.
(c) Compare AIC of the GLM and the GAM.
