# Session 15 — Exercises

**Topic:** Linear mixed models: structure, marginal covariance, fixed vs random effects
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Notation: groups $i=1,\dots,m$, observations $j=1,\dots,n_i$; $b\sim N(0,G)$, $\varepsilon\sim N(0,\sigma^2I)$, $V = ZGZ^\top+\sigma^2I$; random-intercept variance $\sigma_b^2$.

## Exercise 1 — Design effect (derivation)

Consider the balanced random-intercept model without covariates, $y_{ij} = \beta_0 + b_{0i} + \varepsilon_{ij}$, with $n_i = n$ for all $i$.

(a) Show that the subject mean $\bar y_{i\cdot}$ has variance $\sigma_b^2 + \sigma^2/n$.

(b) Show that the grand mean $\bar y = \frac1m\sum_i \bar y_{i\cdot}$ has variance
$$\Var(\bar y) = \frac{\sigma_b^2+\sigma^2}{mn}\,\bigl[1+(n-1)\,\mathrm{ICC}\bigr].$$

(c) The bracket is called the *design effect*. Using the `sleepstudy` random-intercept estimates ($\hat\sigma_b^2 = 1378.2$, $\hat\sigma^2 = 960.5$, $n=10$, $m=18$), compute it and the "effective sample size" $mn/[1+(n-1)\mathrm{ICC}]$.

## Exercise 2 — Writing $Z$, $G$ and $V$

Two subjects are each measured at $x = 0, 1, 2$. The model is $y_{ij} = \beta_0+b_{0i} + (\beta_1+b_{1i})x_{ij} + \varepsilon_{ij}$ with $(b_{0i},b_{1i})^\top \sim N(0, G)$, $G = \begin{pmatrix}\sigma_{b0}^2 & \sigma_{b01}\\ \sigma_{b01} & \sigma_{b1}^2\end{pmatrix}$.

(a) Write $y$, $X$, $\beta$, $Z$, $b$ and the full $G$ (of size $4\times 4$).

(b) Show that $V$ is block diagonal and give the $3\times 3$ block $V_1$ entry by entry.

(c) With the `sleepstudy` REML estimates $\hat\sigma_{b0}^2 = 612.1$, $\hat\sigma_{b01} = 9.60$, $\hat\sigma_{b1}^2 = 35.07$, $\hat\sigma^2 = 654.9$, compute $V_1$ and the implied correlation between the measurements at $x=0$ and $x=2$.

## Exercise 3 — Where is the variance smallest? (short proof)

In the random-intercept-and-slope model, show that $\Var(y_{ij})$, as a function of $x_{ij}$, is minimised at $x^\ast = -\sigma_{b01}/\sigma_{b1}^2$, and give the minimum value. Compute $x^\ast$ for `sleepstudy` and comment.

## Exercise 4 — Fixed or random?

For each study say whether the grouping factor in *italics* should be a fixed or a random effect, and justify in one or two sentences.

(a) Yield of wheat is measured on 40 plots in 8 *farms* randomly chosen from a region; fertiliser type (A/B) is randomised within farms.

(b) Exam marks of students in the 3 *degree programmes* of a faculty; the dean wants to compare these three programmes.

(c) Daily sales in 120 *stores* of a chain over a year; managers of better stores are more likely to adopt a promotion (the covariate of interest).

(d) Blood pressure measured 6 times on each of 50 *patients* in a drug trial.

## Exercise 5 — Centring changes $\rho$ (derivation + R)

Let $x' = x - c$. Show that the random-intercept-and-slope model in $x$ is the same model in $x'$ with $b'_{0i} = b_{0i} + c\,b_{1i}$ and $b'_{1i}=b_{1i}$, and derive
$$\sigma_{b0}'^2 = \sigma_{b0}^2 + 2c\,\sigma_{b01} + c^2\sigma_{b1}^2,\qquad \sigma'_{b01} = \sigma_{b01} + c\,\sigma_{b1}^2.$$
Compute $\rho'$ for `sleepstudy` with $c = 4.5$ and check it in R with `lmer(Reaction ~ I(Days - 4.5) + (I(Days - 4.5) | Subject), sleepstudy)`. Compare the log-likelihoods of the two fits.

## Exercise 6 — One-way random effects in R

The data `Rail` (package `nlme`) contain 3 ultrasonic travel-time measurements (nanoseconds) on each of 6 railway rails.

(a) Fit `lmer(travel ~ 1 + (1 | Rail), data = Rail)`. Report $\hat\beta_0$, $\hat\sigma_b$, $\hat\sigma$ and the ICC. Interpret $\hat\sigma_b$ and $\hat\sigma$ in nanoseconds.

(b) Compare the standard error of $\hat\beta_0$ with the one from `lm(travel ~ 1, data = Rail)`. Which is right, and why?

(c) Verify the `lmer` standard error with the formula from Exercise 1(a): $\mathrm{se}(\hat\beta_0) = \sqrt{(\hat\sigma_b^2 + \hat\sigma^2/n)/m}$.
