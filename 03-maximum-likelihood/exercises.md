# Session 3 — Exercises

**Topic:** Maximum likelihood estimation
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Notation as in the slides: $\ell(\theta)$ log-likelihood, $S(\theta)$ score, $I(\theta)=-\ell''(\theta)$ observed information (whole sample), $\mathcal I(\theta)=\mathbb E[I(\theta)]$ expected information, $\mathrm{se}(\hat\theta)=I(\hat\theta)^{-1/2}$.

---

## Exercise 1 — Geometric model (derivation)

Let $y_1,\dots,y_n$ be iid with $P(Y=y)=\theta(1-\theta)^y$, $y=0,1,2,\dots$, $0<\theta<1$ (number of failures before the first success). You may use $\mathbb E(Y)=(1-\theta)/\theta$.

1. Write $\ell(\theta)$ and derive the MLE $\hat\theta$.
2. Compute $I(\theta)$ and $\mathcal I(\theta)$. Show that $I(\hat\theta)=\mathcal I(\hat\theta)$.
3. With $n=20$ and $\sum_i y_i=60$, compute $\hat\theta$, $I(\hat\theta)$ and $\mathrm{se}(\hat\theta)$.

---

## Exercise 2 — Score identities for the Poisson (short proof)

For $y_1,\dots,y_n\stackrel{iid}{\sim}\mathrm{Pois}(\lambda)$:

1. Show directly that $\mathbb E[S(\lambda)]=0$ and $\mathrm{Var}[S(\lambda)]=\mathcal I(\lambda)=n/\lambda$.
2. Show that $\mathbb E[I(\lambda)]=\mathcal I(\lambda)$, and that $I(\hat\lambda)=\mathcal I(\hat\lambda)$ but $I(\lambda)\neq\mathcal I(\lambda)$ in general.
3. State the approximate distribution of $\hat\lambda$ and of $\sqrt n(\hat\lambda-\lambda)$. Which information appears in each?

---

## Exercise 3 — Three tests by hand (aircondit)

The 12 air-conditioning failure times have $\sum_i y_i=1297$ hours. Assume $y_i\stackrel{iid}{\sim}$ Exponential with mean $\mu$, so $\ell(\mu)=-n\log\mu-\sum_i y_i/\mu$. Test $H_0:\mu=60$ hours.

1. Compute the Wald statistic $W=(\hat\mu-\mu_0)^2I(\hat\mu)$, the score statistic $S_c=S(\mu_0)^2/\mathcal I(\mu_0)$ and $LR=2\{\ell(\hat\mu)-\ell(\mu_0)\}$, with their $\chi^2_1$ p-values.
2. Repeat the Wald test using the rate $\lambda=1/\mu$ as the parameter ($H_0:\lambda=1/60$). What changes, and what does not?
3. Which statistic(s) would you report, and why?

---

## Exercise 4 — One Newton–Raphson step (gamma shape)

For the gamma model of the aircondit data, the profile score and information for the shape are
$S(\alpha)=n\{\log\alpha-\psi(\alpha)-\log\bar y+\overline{\log y}\}$ and $I(\alpha)=n\{\psi'(\alpha)-1/\alpha\}$.
Use $n=12$, $\log\bar y=4.6829$, $\overline{\log y}=3.8286$, $\psi(1)=-0.5772$, $\psi'(1)=1.6449$.

1. Starting from $\alpha_0=1$, compute $S(\alpha_0)$, $I(\alpha_0)$ and $\alpha_1$.
2. Explain why Newton–Raphson and Fisher scoring take identical steps in this problem.
3. Derive $\hat\beta(\alpha)=\alpha/\bar y$ from $\partial\ell/\partial\beta=0$.

---

## Exercise 5 — Invariance and the delta method

Counts $y_1,\dots,y_{25}\stackrel{iid}{\sim}\mathrm{Pois}(\lambda)$ with $\sum_i y_i=50$.

1. Find the MLE of $p_0=P(Y=0)=e^{-\lambda}$.
2. Use the delta method, $\mathrm{se}\{g(\hat\lambda)\}\approx|g'(\hat\lambda)|\,\mathrm{se}(\hat\lambda)$, to find $\mathrm{se}(\hat p_0)$.
3. Give a 95% interval for $p_0$ by transforming the likelihood interval for $\lambda$. Why is this better than $\hat p_0\pm1.96\,\mathrm{se}(\hat p_0)$ near the boundary?

---

## Exercise 6 — Normal model with two parameters (nhtemp)

For `nhtemp` ($n=60$): $\hat\mu=51.16$, $\hat\sigma^2=1.5751$.

1. Using $I(\hat\mu,\hat\sigma^2)=\mathrm{diag}\{n/\hat\sigma^2,\ n/(2\hat\sigma^4)\}$, compute $\mathrm{se}(\hat\mu)$ and $\mathrm{se}(\hat\sigma^2)$.
2. Use the delta method to get $\mathrm{se}(\hat\sigma)$.
3. If you fit the model in `optim()` with parameters $(\mu,\log\sigma)$, what standard error should `solve(fit$hessian)` give for $\log\hat\sigma$? Show that it does not depend on the data.

---

## Exercise 7 — Weibull vs exponential in R

The Weibull density with shape $k$ and scale $s$ is $f(y)=\frac ks\left(\frac ys\right)^{k-1}e^{-(y/s)^k}$; $k=1$ is the exponential.

1. Write the negative log-likelihood for the aircondit data with parameters $(\log k,\log s)$ and maximise it with `optim(method = "BFGS", hessian = TRUE)`.
2. Report $\hat k$, $\hat s$, the maximised log-likelihood and $\mathrm{se}(\hat k)$ (delta method).
3. Test $H_0:k=1$ with the LR test. Compare with the gamma result in the slides.
4. Give a 95% Wald interval for $k$ computed on the $\log k$ scale.

---

## Exercise 8 — Identifiability and the boundary (conceptual)

1. Suppose $y_i\sim N(ab,1)$ with both $a$ and $b$ unknown. Which function of $(a,b)$ is identifiable? What happens to the Hessian of $-\ell$ at any maximiser?
2. In a two-component normal mixture $p\,N(\mu_1,\sigma_1^2)+(1-p)\,N(\mu_2,\sigma_2^2)$, give two different parameter vectors that define the same distribution.
3. You observe 0 successes in 20 Bernoulli trials. Why does the usual Wald interval fail? Compute the 95% likelihood interval.

---

## Exercise 9 — Censored exponential lifetimes (preview of Session 28)

Eight components are tested. Failure times (hours) are $5,\ 12,\ 20,\ 31,\ 52$; three other components were removed from the test, still working, at $8,\ 25,\ 40$ hours (right-censored). Assume exponential lifetimes with rate $\lambda$.

1. Write the contribution of a failure and of a censored component to the likelihood, and show $\ell(\lambda)=d\log\lambda-\lambda\sum t_i$, where $d$ is the number of failures and the sum runs over all 8 components.
2. Find $\hat\lambda$, $I(\hat\lambda)$, $\mathrm{se}(\hat\lambda)$ and a 95% Wald interval.
3. Test $H_0:\lambda=0.04$ with the likelihood-ratio statistic.
4. Compute $1/\bar t$ (all 8 times) and $d/\sum_{\text{failures}}t_i$. Why are both wrong? Which direction is the bias?
5. Check your answers in R with `survival::survreg(Surv(t, delta) ~ 1, dist = "exponential")`.
