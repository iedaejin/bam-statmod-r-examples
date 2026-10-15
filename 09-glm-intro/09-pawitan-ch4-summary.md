# Pawitan (2001), Ch. 4 — Basic models and simple applications

**Session(s):** 9 (also useful for 3–4, 10–12 and 17)  ·  **Source:** Pawitan, *In All Likelihood: Statistical Modelling and Inference Using Likelihood*, OUP, Ch. 4, pp. 73–116 (text pp. 73–107, exercises pp. 107–116)
**Reading time:** ~90 min (~30 min for Sections 4.2, 4.5 and 4.9 only)  ·  **Level:** core for 4.9 and the overdispersion sections 4.2 and 4.5; optional for the rest

## Why read it
Session 9 needs one fact above all: every GLM family is a member of the exponential family, whose cumulant function $b(\theta)$ fixes the mean–variance relationship. This chapter introduces the one-sample building blocks (binomial, Poisson, normal, gamma), shows where they fail (overdispersion), and then collects them into the exponential family. Chapter 6 (separate summary) turns each block into a regression model.

## The big idea
A probability model separates a systematic pattern from random variation. The simplest models (binomial, Poisson) tie the variance to the mean, and real data often have more variation than that, typically because the success probability or the rate varies between units. The exponential dispersion family keeps the convenient mean structure, $\mu=b'(\theta)$, and adds a free dispersion parameter $\phi$, so that the variance becomes $\phi\,V(\mu)$. Every example is analysed with likelihood plots and profile likelihoods (Chapters 2–3).

## Section by section

**4.1 Binomial or Bernoulli models (p. 73).** Bernoulli sequences, the binomial and grouped binomial data (Geissler's 19th-century counts of boys in Saxon families with 12 children). Negative binomial sampling (keep going until a fixed number of successes) gives the same likelihood as binomial sampling: the likelihood ignores the stopping rule.

**4.2 Binomial model with under- or overdispersion (p. 76).** A Pearson goodness-of-fit check on Geissler's data shows too many families with few or many boys. Theory: if the independent trials that make up one count have different probabilities, the variance falls below $n\bar p(1-\bar p)$; if $X$ is drawn from a *mixture* of binomials with different $p_i$, the variance exceeds it. A wrong binomial assumption gives standard errors that are too small or too large. Pointers to Section 4.9 (dispersion models) and Section 17.1 (random effects).

**4.3 Comparing two proportions (p. 78).** A 2×2 table (a gene and the spread of breast cancer) analysed three ways: the $\chi^2$ test, Fisher's exact test, and the profile likelihood of the **log odds ratio**, chosen because its likelihood is the most regular in small samples. With a zero cell the MLE is infinite and the likelihood interval becomes one-sided. Combining several 2×2 tables by adding log-likelihoods works only for a few strata (the fix is in Section 10.5).

**4.4 Poisson model (p. 82).** The Poisson as the limit of the binomial with large $n$ and small $p$. Examples: yearly earthquake counts; monthly terrorism incidents, checked with a Poisson plot of $\log(\hat p_k\,k!)$ against $k$, which exposes one extreme month and shows how sensitive the likelihood is to it.

**4.5 Poisson with overdispersion (p. 84).** Accident counts among factory workers fit the Poisson badly. If the rate $\mu$ itself varies across individuals, the marginal variance is $\mathrm E\mu+\mathrm{Var}(\mu)$; with gamma-distributed rates the marginal law is the **negative binomial**, which fits the accident data well. The mean accident rate is the same under both models, but its likelihood and standard error differ.

**4.6–4.7 Traffic deaths and aspirin data (pp. 86–88).** Profile likelihood of the ratio of two Poisson rates (traffic deaths; the aspirin trial of Session 2), and the Delta method as a quadratic approximation of that likelihood.

**4.8 Continuous data (p. 89).** Normal model (MLE of $\sigma^2$ divides by $n$), Michelson's speed-of-light data, QQ-plots, the two-sample $t$ test, and the gamma model with mean $\mu$ and dispersion $\phi=1/\text{shape}$.

**4.9 Exponential family (p. 95).** The core section. The general form $\log p_\theta(x)=\sum_i\eta_i(\theta)T_i(x)-A(\theta)+c(x)$; full vs curved families; normal, Poisson and truncated Poisson as examples; exponential tilting, which shows that $A(\theta)$ (the cumulant generating function) carries the moments. Then the **exponential dispersion model**, the form used for GLMs, with canonical parameter $\theta$ and dispersion $\phi$. Example: paint defects on 20 cars have sample variance far above the mean; $\phi$ is estimated by moments and its significance checked by Monte Carlo. The starred **approximate likelihood** replaces the unknown $c(x,\phi)$ by a formula built from the **deviance** (the extended quasi-likelihood of Nelder and Pregibon), giving $\hat\phi$ as the average deviance. A starred subsection links the existence of a sufficient estimate to the exponential family.

**4.10 Box–Cox transformation family (p. 102).** Transform $y$ to normality with $(y^\lambda-1)/\lambda$; choose $\lambda$ from its profile likelihood and keep to simple values ($-1,0,\tfrac12,1,2$). A flat profile likelihood means the family is not informative (EU population sizes: the log transform wins).

**4.11 Location–scale family (p. 104).** Heavy-tailed alternatives to the normal (Cauchy, $t$, logistic, Laplace), compared by AIC; choosing a model is harder than fitting it.

## Key results to know
1. Exponential dispersion model (course notation): $f(y;\theta,\phi)=\exp\{[y\theta-b(\theta)]/a(\phi)+c(y,\phi)\}$. Pawitan writes $A(\theta)$ for $b(\theta)$, $\phi$ for $a(\phi)$ and $x$ for the observation.
2. $\mu=\mathrm E(Y)=b'(\theta)$ and $\mathrm{Var}(Y)=a(\phi)\,b''(\theta)=a(\phi)V(\mu)$. Pawitan states these and leaves the proof to Exercise 4.30; Deck 09 derives them from the two score identities (Pawitan Ch. 8).
3. Members: normal $\theta=\mu$, $b(\theta)=\theta^2/2$, $\phi=\sigma^2$; Poisson $\theta=\log\mu$, $b(\theta)=e^\theta$, $\phi=1$; gamma with mean $\mu$ and dispersion $\phi$ (course shape $\nu=1/\phi$), $\mathrm{Var}(Y)=\phi\mu^2$.
4. Overdispersion from mixing: Poisson with random mean gives $\mathrm{Var}(Y)=\mathrm E\mu+\mathrm{Var}(\mu)$; gamma mixing gives the negative binomial, $\mathrm{Var}(Y)=\mu+\mu^2/k$ (Pawitan's $\alpha$ is our size $k$).
5. Log odds ratio for a 2×2 table: $\hat\theta=\log\dfrac{x(n-y)}{y(m-x)}$, $\ \mathrm{se}(\hat\theta)=\sqrt{\tfrac1x+\tfrac1y+\tfrac1{m-x}+\tfrac1{n-y}}$.
6. Extended quasi-likelihood: $\ell(\mu,\phi)\approx-\tfrac12\log\{2\pi\phi V(y)\}-D(y,\mu)/(2\phi)$, so $\hat\phi=\frac1n\sum_i D(y_i,\hat\mu_i)$.
7. Delta method: $\mathrm{Var}\{h(\hat\psi)\}\approx h'(\psi)^2\mathrm{Var}(\hat\psi)$.
8. Box–Cox profile: $\ell(\lambda)=-\tfrac n2\log\hat\sigma^2(\lambda)+(\lambda-1)\sum_i\log y_i+\text{const}$. Here $\lambda$ is the transformation parameter, not a rate or a smoothing parameter.

## Connect to class
- Deck 09, frames "The exponential family (dispersion form)", "Mean and variance from $b(\theta)$", "Gamma (mean $\mu$, shape $\nu$)" and "Summary of the four families"; `09-exponential-family.Rmd` simulates the mean–variance relationships. Reading question 1 (gamma in exponential-family form) uses the parametrisation of Section 4.8.
- Sections 4.2 and 4.5 prepare overdispersion in Session 10 and Lab 03 (quasi-Poisson, negative binomial), and the observation-level random effect in Session 17.
- The log odds ratio of Section 4.3 is the parameter of logistic regression (Session 9); the person-time rates of 4.6–4.7 reappear as offsets in Poisson regression and in Session 28.
- The profile likelihoods throughout are practice for Sessions 3–4. Pawitan works with likelihood plots; the deck works with formulas and R output.

## Read carefully / safe to skim
- **Read carefully:** 4.9 up to and including the approximate likelihood; 4.2 and 4.5 (how overdispersion arises); the log odds ratio in 4.3.
- **Skim:** 4.1, 4.4, 4.6–4.8, 4.10–4.11 (good worked examples, not needed for the exam); the starred subsection on minimal sufficiency.

## Check yourself
1. Write the Poisson and the binomial (with $n$ trials) in exponential-dispersion form. Identify $\theta$, $b(\theta)$ and $a(\phi)$, and check that $b''(\theta)$ gives the right variance.
2. Show that if $Y\mid\mu\sim\text{Poisson}(\mu)$ and $\mu$ is random, then $\mathrm{Var}(Y)=\mathrm E\mu+\mathrm{Var}(\mu)$. What does this say about counts from individuals with different accident proneness?
3. Why does Pawitan prefer the log odds ratio to the risk difference or the relative risk as the parameter of interest for a small 2×2 table?
4. Explain in words why adding a dispersion parameter $\phi$ changes the standard errors but not the point estimate of the mean.
5. A Box–Cox profile likelihood is almost flat over $0\le\lambda\le2$. What should you conclude?
