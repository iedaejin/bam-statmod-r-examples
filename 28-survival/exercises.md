# Session 28 — Exercises

**Topic:** Censored and survival data
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Notation: $T$ event time, $C$ censoring time, $y_i = \min(T_i, C_i)$, $\delta_i = \mathbf 1\{T_i \le C_i\}$, $d = \sum_i \delta_i$. A `+` marks a censored time. Exercises 1–6 are for paper; 7–8 need R (`library(survival)`).

## Exercise 1 — Relations between $S$, $h$ and $H$

(a) Starting from the definition $h(t) = \lim_{\Delta\to 0} P(t \le T < t+\Delta \mid T \ge t)/\Delta$, show that $h(t) = f(t)/S(t) = -\frac{d}{dt}\log S(t)$ and hence $S(t) = \exp\{-H(t)\}$.

(b) The Weibull hazard is $h(t) = k\lambda(\lambda t)^{k-1}$, $k, \lambda > 0$. Find $H(t)$, $S(t)$, $f(t)$ and the median. For which $k$ is the hazard increasing?

(c) Prove that if $T$ is continuous with cumulative hazard $H$, then $H(T) \sim \text{Exp}(1)$.

## Exercise 2 — The exponential distribution

(a) Show that the exponential distribution is memoryless: $P(T > t+s \mid T > t) = P(T > s)$.

(b) Show that the exponential is the only continuous distribution on $[0,\infty)$ with a constant hazard.

(c) A patient has survived 200 days. Under the exponential model fitted to the veteran data ($\hat\lambda = 0.00768$ per day), what is the estimated probability that the patient survives another 90 days? Comment on whether this is plausible given the Weibull fit ($\hat k = 0.85$).

## Exercise 3 — Censored likelihood: exponential and Weibull

Six patients: 2, 3+, 5, 5, 8+, 11 (months).

(a) Write the likelihood under the exponential model and compute $\hat\lambda$, $\mathrm{se}(\hat\lambda)$ and the estimated $S(5)$.

(b) Assume a Weibull model with **known** shape $k = 2$ and unknown $\lambda$, $S(t) = \exp\{-(\lambda t)^2\}$. Derive $\hat\lambda$ in closed form and compute it. Compute $\hat S(5)$.

(c) Explain why the information about $\lambda$ in (a) depends on $d$ and not on $n$.

## Exercise 4 — Kaplan–Meier by hand

Use the six patients of Exercise 3.

(a) Build the Kaplan–Meier table ($t_j$, $n_j$, $d_j$, $\hat S(t_j)$).

(b) Compute Greenwood's standard error of $\hat S(5)$.

(c) Give the estimated median survival. Can the mean survival be estimated without a model? Why or why not?

(d) Compare $\hat S_{KM}(5)$ with the exponential estimate of Exercise 3(a).

## Exercise 5 — Log-rank test by hand

Group A ($x = 0$): 3, 5, 7+, 9. Group B ($x = 1$): 4+, 6, 8, 10, 12+.

(a) For each distinct death time give $n_j$, $n_{1j}$ (at risk in B), $d_j$, $d_{1j}$, $E_{1j}$ and $V_{1j}$.

(b) Compute $O_1 - E_1$, $V_1$ and the log-rank statistic. What do you conclude at the 5% level?

## Exercise 6 — Cox partial likelihood and the score test

Use the data of Exercise 5 with the model $h(t \mid x) = h_0(t) e^{\beta x}$.

(a) Write the partial likelihood $L_p(\beta)$ explicitly (six factors).

(b) Show that for one binary covariate with no tied death times the score at $\beta = 0$ equals $O_1 - E_1$ and the information at $\beta = 0$ equals $V_1$. Conclude that the score test is the log-rank test.

(c) Check in R: `coxph(Surv(t, s) ~ x)`; compare `summary(fit)$sctest` with `survdiff()`. Interpret $\hat\beta$ as a hazard ratio.

(d) Show that under PH, $S(t \mid x) = S_0(t)^{\exp(x^\top\beta)}$ and $\log\{-\log S(t \mid x)\} = \log H_0(t) + x^\top\beta$.

## Exercise 7 — Veteran trial: full model and PH (R)

(a) Fit `coxph(Surv(time, status) ~ trt + celltype + karno + diagtime + age + prior, data = veteran)` (make `trt` and `prior` factors). Which covariates add little? Interpret the hazard ratio for `karno` per 10 points.

(b) Run `cox.zph()`. Which covariates violate PH?

(c) Fit the model with a step-function effect of `karno` (cuts at 90 and 180 days, `survSplit()`) and stratification on `celltype`. Does the global PH test improve? What is lost by stratifying on `celltype`?

## Exercise 8 — Interpretation memo (R)

Write a 150-word memo for a clinical audience on the veteran trial: does the test treatment work, which patients die sooner, and how does the effect of the Karnofsky score change over follow-up? Report hazard ratios with 95% CIs and medians with CIs. Avoid the words "probability" and "risk" when you mean "hazard".
