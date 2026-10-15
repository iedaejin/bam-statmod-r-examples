# Session 17 — Exercises

**Topic:** Generalized linear mixed models
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Notation: group $i$, observation $j$; $\E[y\mid b] = g^{-1}(X\beta + Zb)$, $b\sim N(0,G)$; random-intercept variance $\sigma_b^2$.

## Exercise 1 — Moments of a Poisson random-intercept model (derivation)

Let $y_{ij}\mid b_{0i}\sim\text{Poisson}(\mu_{ij})$, $\log\mu_{ij} = \eta_{ij} + b_{0i}$, $b_{0i}\sim N(0,\sigma_b^2)$, $\eta_{ij} = x_{ij}^\top\beta$.

(a) Derive $\E[y_{ij}]$, $\Var(y_{ij})$ and $\Cov(y_{ij}, y_{ik})$ for $j\ne k$.

(b) Show that the correlation between two counts of the same group is positive and tends to 1 as both means grow, for fixed $\sigma_b^2>0$.

(c) Explain why the rate ratio $e^{\beta_1}$ has the same value on the conditional and the marginal scale, but the intercept does not.

## Exercise 2 — The Laplace approximation in one dimension (derivation + computation)

One count $y\mid b\sim\text{Poisson}(e^{\beta+b})$, $b\sim N(0,\sigma^2)$. The likelihood contribution is $L = \int f(y\mid b)\phi(b;0,\sigma^2)\,db$.

(a) Write $h(b) = \log f(y\mid b) + \log\phi(b)$. Show that the mode $\hat b$ solves $y - e^{\beta+\hat b} - \hat b/\sigma^2 = 0$ and that $-h''(\hat b) = e^{\beta+\hat b} + 1/\sigma^2$.

(b) Write the Laplace approximation to $L$.

(c) With $\beta = 0$, $\sigma = 1$: compute the mode and the approximation for $y = 3$ and for $y = 0$, and compare with `integrate()`. When is the approximation worse, and why?

## Exercise 3 — Attenuation (proof + computation)

(a) Prove that for the **probit** random-intercept model, $\E_b[\Phi(\eta + b)] = \Phi\bigl(\eta/\sqrt{1+\sigma_b^2}\bigr)$ exactly.

(b) For the logit link, use $\mathrm{expit}(t)\approx\Phi(ct)$ with $c = 16\sqrt3/(15\pi)$ to derive $\beta_M\approx\beta_C/\sqrt{1+0.346\,\sigma_b^2}$.

(c) Compute $\beta_M$ for $\beta_C = 0.8$ and $\sigma_b = 1, 2, 3$. For which $\sigma_b$ is the difference practically important?

## Exercise 4 — Reading `glmer` output (`cbpp`)

Use the output on the slides (`period` coefficients, $\hat\sigma_b = 0.642$, se of period4 $= 0.422$).

(a) Give the conditional odds ratio for period 4 vs period 1 with a 95% Wald interval, and interpret it.

(b) Compute the probability of a new case in period 4 for a typical herd ($b = 0$), and the approximate population-averaged probability using the attenuation formula. Check the latter with `integrate()`.

(c) Herd 14 has predicted effect $\hat b_{0,14} = 0.970$. What is its predicted probability in period 1?

## Exercise 5 — Counts with an OLRE in R (`grouseticks`)

(a) Fit `glmer(TICKS ~ YEAR + HEIGHT_s + (1 | LOCATION) + (1 | BROOD) + (1 | INDEX), family = poisson)` with `HEIGHT_s` the standardised altitude. Express the altitude effect as a rate ratio per 10 m.

(b) Interpret the coefficient of `YEAR96` as a rate ratio.

(c) Test whether the OLRE is needed (boundary-corrected LRT against the model without `(1 | INDEX)`).

## Exercise 6 — When Laplace struggles (simulation in R)

Simulate $m = 300$ pairs ($n_i = 2$) of binary responses from $\mathrm{logit}\,P(y_{ij}=1\mid b_{0i}) = -0.5 + x_{ij} + b_{0i}$, $x_{ij}\sim N(0,1)$, $b_{0i}\sim N(0, 2^2)$ (use `set.seed(2027)`). Fit the GLMM with `nAGQ = 1` and `nAGQ = 25` and compare $\hat\beta$ and $\hat\sigma_b$ with the truth. Explain the difference.

## Exercise 7 — Modelling choices (short answers)

A university records whether each student passes (1/0) each of 6 first-year courses; 900 students from 30 high schools.

(a) Write a GLMM with a fixed effect for "attended a summer bridge programme", random intercepts for student and for high school. What is $Z$'s structure?

(b) The coefficient of the bridge programme is $\hat\beta_C = 0.60$ and the total random-intercept variance is $\hat\sigma_{\text{student}}^2 + \hat\sigma_{\text{school}}^2 = 2.5$. Give the approximate population-averaged odds ratio. Which one would the rector want, and which one a student deciding whether to enrol?
