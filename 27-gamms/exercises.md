# Session 27 — Exercises

**Course:** Statistical Modelling (BAM), Spring 2027 · Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Exercises 1–5 are by hand; 6–8 use R (`mgcv`, `nlme`, `splines`).

### Exercise 1 (the variance ratio)
In $y=X\alpha+Zb+\varepsilon$ with $b\sim N(0,\sigma_b^2I)$ and $\varepsilon\sim N(0,\sigma^2I)$ independent:
(a) Write $\log f(y\mid b)+\log f(b)$.
(b) Show that maximising it over $(\alpha,b)$ is a penalized least-squares problem and identify $\lambda$.
(c) Write the resulting linear system (Henderson's mixed-model equations).

### Exercise 2 (reparametrisation)
Let $S=D_2^\top D_2$ for $K=12$, with eigen-decomposition $S=U\Sigma U^\top$, $U=[U_0\;U_+]$.
(a) What are the dimensions of $U_0$, $U_+$, $\Sigma_+$, $X$ and $Z=BU_+\Sigma_+^{-1/2}$ when $n=100$?
(b) Show that $\beta=U_0\alpha_0+U_+\Sigma_+^{-1/2}b$ gives $\beta^\top S\beta=b^\top b$.
(c) Is the map $(\alpha_0,b)\mapsto\beta$ one-to-one? Justify.

### Exercise 3 (the null space and $[\mathbf 1,x]$)
(a) Show that $D_2\beta=0$ if and only if $\beta_k=a+ck$ for constants $a,c$.
(b) For cubic B-splines on equally spaced knots, $\sum_kB_k(x)=1$ and $\sum_k t_k^*B_k(x)=x$, where the knot averages $t_k^*$ are equally spaced. Deduce that $B\beta$ is a linear function of $x$ for every $\beta$ in the null space, so $BU_0$ spans the same space as $[\mathbf 1,x]$.

### Exercise 4 (random intercepts as a smooth)
For `height ~ s(age) + s(Subject, bs = "re")` on Oxboys, `gam.vcomp()` gives $\hat\sigma_b=8.097$ and $\hat\sigma=1.281$.
(a) Write the penalty of the `re` term and the corresponding $\lambda$. Compute $\lambda$.
(b) Compute the intraclass correlation.
(c) With 9 observations per boy, the BLUP of a boy's intercept shrinks his mean residual by the factor $9\sigma_b^2/(9\sigma_b^2+\sigma^2)$. Compute it and comment.

### Exercise 5 (choosing the software)
For each situation say whether you would use `gam(..., bs = "re")`, `gamm()` or `gamm4()`, and why:
(a) random intercepts and *correlated* random slopes, Gaussian response;
(b) a Poisson count response with 2,000 crossed random effects;
(c) daily data with an AR(1) residual process.

### Exercise 6 (numerical check, R)
Repeat the check of `27-smoother-mixed-model.Rmd` for `log(Ozone)` on `Temp` with 27 segments ($K=30$). Report $\hat\sigma^2/\hat\sigma_b^2$ from `lme()`, $\hat\lambda$ from `gam(..., paraPen = ...)`, and the edf. Does the edf change much compared with $K=20$? Why?

### Exercise 7 (random slopes, R)
Fit `gamm(height ~ s(age), random = list(Subject = ~1))` and `gamm(height ~ s(age), random = list(Subject = ~1 + age))` by REML.
(a) Compare them with `anova()` on the `$lme` components. Report the LR statistic.
(b) Why is the usual $\chi^2_2$ reference distribution conservative here?

### Exercise 8 (serial correlation, R)
For `log(Ozone) ~ s(Solar.R) + s(Wind) + s(Temp)` on the 111 complete airquality days, add `correlation = corAR1(form = ~ day)` in `gamm()` (with `day` the day of the season).
(a) Report $\hat\phi$ and the LR test against independent errors.
(b) Show with `corMatrix()` that days 4 and 7 have correlation $\phi^3$.
(c) Do the edf of the smooths change? Interpret.
