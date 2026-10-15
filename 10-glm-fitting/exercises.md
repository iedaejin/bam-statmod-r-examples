# Session 10 — Exercises

**Topic:** IRLS, deviance, residuals, overdispersion
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

## Exercise 1 — IRLS by hand (computation)

Counts $y=(0,1,1,2,6)$ are modelled as Poisson with an intercept only, $\log\mu=\beta_0$.

(a) Show that the IRLS weights are $w_i=\mu_i$ and the working response is $z_i=\eta_i+(y_i-\mu_i)/\mu_i$.
(b) Starting from $\beta_0^{(0)}=0$, compute $\beta_0^{(1)}$, $\beta_0^{(2)}$ and $\beta_0^{(3)}$ by hand (4 decimals).
(c) What is the MLE? Show that the update can be written $\beta_0^{(t+1)}=\beta_0^{(t)}+(\bar y-\mu^{(t)})/\mu^{(t)}$ and explain why the convergence is quadratic.

## Exercise 2 — Canonical link and separation (proof)

(a) For logistic regression show that the observed and expected information are equal, so IRLS is Newton–Raphson.
(b) Let $x=(1,2,3,4)$ and $y=(0,0,1,1)$ with model $\logit\mu_i=\beta_0+\beta_1x_i$. Show that $\ell(\beta)$ has no maximum: along $\beta_0=-2.5\beta_1$ it increases to 0 as $\beta_1\to\infty$.
(c) What does `glm()` report in this case, and how would you recognise it in the output?

## Exercise 3 — Deviances (derivation)

(a) Derive the Poisson deviance $D=2\sum_i\{y_i\log(y_i/\hat\mu_i)-(y_i-\hat\mu_i)\}$ from the saturated model.
(b) Show that with a log link and an intercept the second term sums to zero.
(c) Derive the deviance of a binomial model with $y_i$ successes out of $m_i$.
(d) For Bernoulli data with the logit link, show that $D=-2\sum_i\{\hat\mu_i\,\mathrm{logit}(\hat\mu_i)+\log(1-\hat\mu_i)\}$. (Hint: use the score equation $X^\top(y-\hat\mu)=0$.) Why does this make $D$ useless as a goodness-of-fit statistic?

## Exercise 4 — Analysis of deviance from output (computation)

Poisson models for `ships` (offset `log(service)`, $n=34$):

| Model | Residual deviance | Residual df | Pearson $X^2$ |
|---|---:|---:|---:|
| M1: intercept | 146.33 | 33 | 190.23 |
| M2: + type | 90.89 | 29 | 92.77 |
| M3: + year | 49.36 | 26 | 51.34 |
| M4: + period | 38.70 | 25 | 42.28 |

(a) Carry out the three sequential LR tests ($\chi^2$).
(b) Estimate $\phi$ from M4 and redo the test for `year` as an $F$ test. Does the conclusion change?
(c) The log-likelihoods are $-122.10,\ -94.38,\ -73.61,\ -68.28$. Compute the AICs and choose a model.
(d) Is there evidence of lack of fit for M4? State the test and its caveat.

## Exercise 5 — Quasi-Poisson standard errors (computation)

In M4 the type E coefficient is $0.32558$ with Poisson standard error $0.23588$.

(a) Compute the quasi-Poisson standard error, $t$ statistic and approximate $p$-value.
(b) Explain why the estimate does not change.

## Exercise 6 — Randomized quantile residuals (proof and computation)

(a) Let $Y$ be discrete with CDF $F$, and $U\mid Y=y\sim U(F(y-1),F(y))$. Prove that $U\sim U(0,1)$.
(b) For an observation $y=0$ with fitted Poisson mean $\hat\mu=2$, give the range of possible randomized quantile residuals.
(c) Why are Pearson residuals from a binary model arranged on two curves when plotted against $\hat\mu$?

## Exercise 7 — Overdispersion (derivation and R)

(a) Show that if $Y\mid\lambda\sim\mathrm{Poisson}(\lambda)$ and $\lambda\sim\mathrm{Gamma}(\text{shape }k,\text{ rate }k/\mu)$, then $Y$ is negative binomial with $\mathrm{E}[Y]=\mu$ and $\mathrm{Var}(Y)=\mu+\mu^2/k$. Derive the pmf.
(b) In R, simulate $n=500$ observations with `set.seed(2027)`, $x\sim U(0,1)$, $\mu=\exp(1+x)$, $\lambda\sim\mathrm{Gamma}(2,\,2/\mu)$, $y\sim\mathrm{Poisson}(\lambda)$. Fit a Poisson GLM; compute $\hat\phi$ and the Cameron–Trivedi test.
(c) Fit quasi-Poisson and `glm.nb`. Compare the standard errors of the slope and report $\hat k$. Is $\hat k$ close to the true value?

## Exercise 8 — Zero-inflated Poisson (derivation)

For the ZIP model $P(Y=0)=\pi+(1-\pi)e^{-\mu}$, $P(Y=y)=(1-\pi)e^{-\mu}\mu^y/y!$ for $y\ge1$:

(a) Show $\mathrm{E}[Y]=(1-\pi)\mu$ and $\mathrm{Var}(Y)=(1-\pi)\mu(1+\pi\mu)$.
(b) Conclude that a ZIP is overdispersed relative to a Poisson with the same mean.
(c) Why should you check for overdispersion before concluding that zeros are in excess?
