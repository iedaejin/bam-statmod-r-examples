# Session 5 — Exercises

**Topic:** Linear models in theory
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Notation: $y=X\beta+\varepsilon$, $X$ is $n\times p$ including the intercept column, $H=X(X^\top X)^{-1}X^\top$, $e=y-\hat y$, $\mathrm{RSS}=e^\top e$, $\hat\sigma^2=\mathrm{RSS}/(n-p)$.

Exercises 3, 5 and 6 use the savings model `lm(sr ~ pop15 + pop75 + dpi + ddpi, data = faraway::savings)`, $n=50$, $p=5$:

```
              Estimate Std. Error t value Pr(>|t|)
(Intercept) 28.5660865  7.3545161   3.884 0.000334
pop15       -0.4611931  0.1446422  -3.189 0.002603
pop75       -1.6914977  1.0835989  -1.561 0.125530
dpi         -0.0003369  0.0009311  -0.362 0.719173
ddpi         0.4096949  0.1961971   2.088 0.042471
Residual standard error: 3.803 on 45 degrees of freedom
```

## 1. Simple regression as a special case (derivation)

Let $X=[\mathbf 1,\,x]$ with $x=(x_1,\dots,x_n)^\top$. Write $S_{xx}=\sum_i(x_i-\bar x)^2$ and $S_{xy}=\sum_i(x_i-\bar x)(y_i-\bar y)$.

(a) Write $X^\top X$ and $X^\top y$ explicitly and solve the normal equations to show $\hat\beta_1=S_{xy}/S_{xx}$ and $\hat\beta_0=\bar y-\hat\beta_1\bar x$.
(b) Compute $(X^\top X)^{-1}$ and deduce $\mathrm{Var}(\hat\beta_1)=\sigma^2/S_{xx}$ and $\mathrm{Var}(\hat\beta_0)=\sigma^2\left(\frac1n+\frac{\bar x^2}{S_{xx}}\right)$.
(c) For `sr ~ pop15` in the savings data, $\bar x=35.09$, $\bar y=9.671$, $S_{xx}=4103.95$, $S_{xy}=-915.25$ and $\hat\sigma=4.030$. Compute $\hat\beta_1$, $\hat\beta_0$ and $\mathrm{se}(\hat\beta_1)$.

## 2. Properties of the hat matrix (short proofs)

(a) Show that $I-H$ is symmetric and idempotent with $\operatorname{tr}(I-H)=n-p$.
(b) Show that $h_{ii}=\sum_{j}h_{ij}^2$ and deduce $0\le h_{ii}\le1$.
(c) Suppose $X$ contains a column of ones. Show that $H\mathbf 1=\mathbf 1$, that $\sum_i e_i=0$, and that $h_{ii}\ge 1/n$. (Hint for the last part: $H-\frac1n\mathbf 1\mathbf 1^\top$ is also a projection.)

## 3. Inference by hand

Use the savings output above. $t_{45,0.975}=2.014$.

(a) Test $H_0:\beta_{\texttt{pop75}}=0$ at the 5% level and give a 95% confidence interval for $\beta_{\texttt{pop75}}$.
(b) The model without `pop15` has $\mathrm{RSS}_0=797.72$. The full model has $\mathrm{RSS}=650.71$. Compute the $F$ statistic for dropping `pop15` and verify that it equals the square of the $t$ value in the table.
(c) Using $\mathrm{RSS}/\sigma^2\sim\chi^2_{n-p}$, construct a 95% confidence interval for $\sigma^2$. ($\chi^2_{45,0.025}=28.37$, $\chi^2_{45,0.975}=65.41$.)

## 4. Maximum likelihood and bias

(a) Starting from the normal log-likelihood $\ell(\beta,\sigma^2)$, derive $\hat\sigma^2_{\text{ML}}=\mathrm{RSS}/n$.
(b) Show that $E[\hat\sigma^2_{\text{ML}}]=\sigma^2(n-p)/n$. For which $n$ and $p$ does the bias matter?
(c) Show that $-2\ell(\hat\beta,\hat\sigma^2_{\text{ML}})=n\log(2\pi)+n\log(\mathrm{RSS}/n)+n$ and evaluate it for the savings model.

## 5. Cook's distance

You may use the leave-one-out identity $\hat\beta_{(i)}-\hat\beta=-\dfrac{(X^\top X)^{-1}x_i e_i}{1-h_{ii}}$, where $x_i^\top$ is row $i$ of $X$.

(a) Show that $D_i=\dfrac{(\hat\beta_{(i)}-\hat\beta)^\top X^\top X(\hat\beta_{(i)}-\hat\beta)}{p\hat\sigma^2}=\dfrac{r_i^2}{p}\,\dfrac{h_{ii}}{1-h_{ii}}$, with $r_i$ the standardized residual.
(b) For Libya, $e_i=-2.830$ and $h_{ii}=0.5315$. Compute $r_i$ and $D_i$.
(c) Explain in two sentences why Libya has the largest Cook's distance although its residual is small.

## 6. Mean response and prediction

For a new country with `pop15 = 35`, `pop75 = 2`, `dpi = 1000`, `ddpi = 3`, $x_0^\top(X^\top X)^{-1}x_0=0.02825$ and $\hat y_0=9.934$.

(a) Compute a 95% CI for $E[y_0]$ and a 95% prediction interval for $y_0$.
(b) Derive $\mathrm{Var}(y_0-\hat y_0)$, stating where independence is used.
(c) What happens to the width of each interval as $n\to\infty$ with the design "growing proportionally" ($X^\top X/n\to Q$ positive definite)?

## 7. Simulation in R

Use the savings design matrix `X <- model.matrix(fit)` and true coefficients `beta <- coef(fit)`.

(a) Simulate 4000 response vectors $y=X\beta+\varepsilon$ with $\varepsilon\sim N(0,16 I)$. Check that the average RSS is close to $16(n-p)$ and that the 95% CI for $\beta_{\texttt{pop15}}$ covers the truth about 95% of the time. Use `set.seed(505)`.
(b) Repeat with heteroscedastic errors: standard deviation $4\,z_i^2/\overline{z^2}$, where $z_i$ is the standardized `pop15` (so the standard deviations average 4). What happens to the coverage? Which assumption fails and which result of today's session no longer holds?
