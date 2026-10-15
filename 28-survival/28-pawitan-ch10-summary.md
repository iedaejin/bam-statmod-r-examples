# Pawitan (2001), Ch. 10 — Dealing with nuisance parameters

**Session(s):** 28 (also useful for 16, and for 3–5)  ·  **Source:** Pawitan, *In All Likelihood: Statistical Modelling and Inference Using Likelihood*, OUP, Ch. 10, pp. 273–296 (text pp. 273–294, exercises pp. 294–296)
**Reading time:** ~60 min (~25 min for the introduction and Sections 10.1–10.3)  ·  **Level:** core for the introduction and 10.1–10.3 (Session 28); recommended for 10.6, Example 10.12 (Session 16); optional for the rest

## Why read it
The Cox model has a regression parameter $\beta$ that we care about and a baseline hazard $h_0(t)$ that we do not: an infinite-dimensional **nuisance parameter**. This chapter is the general theory of how to get a likelihood for the parameter of interest when nuisance parameters are present, and why the obvious answer (the profile likelihood) can mislead. Note that the Cox partial likelihood itself is **not** in this chapter: it is in Pawitan 11.7, and 11.10 derives it as a profile likelihood (see the Ch. 11 summary). Profile likelihood was introduced in Pawitan 3.4 (Session 3). The same ideas give REML in Session 16.

## The big idea
Write the parameters as $(\theta,\eta)$, with $\theta$ of interest and $\eta$ a nuisance. The profile likelihood $L_p(\theta)=\max_\eta L(\theta,\eta)$ works in any model, but it treats $\hat\eta_\theta$ as if it were known, so it can be biased and too narrow, and with "infinitely many" nuisance parameters (their number grows with $n$) it can even be inconsistent. Better answers come from **true** likelihoods that do not contain $\eta$: a **marginal** likelihood (use only a part of the data whose distribution is free of $\eta$) or a **conditional** likelihood (condition on a statistic that absorbs $\eta$). When neither is available exactly, a **modified profile likelihood** corrects the profile; the simplest fallback, plugging in an estimate of $\eta$, is the **estimated likelihood**.

## Section by section

**Introduction (p. 273).** The normal variance shows the problem: $\hat\sigma^2=\frac1n\sum(x_i-\bar x)^2$ is biased, and the profile likelihood of $\sigma^2$ is exactly the likelihood you would have if $\mu$ were known to equal $\bar x$, so no price is paid for not knowing $\mu$. Bias is harmless with few nuisance parameters, serious when their number grows with $n$.

**10.1 Inconsistent likelihood estimates (p. 274).** The Neyman–Scott problem: pairs $y_{i1},y_{i2}\sim N(\mu_i,\sigma^2)$ for $N$ strata, one mean per stratum. The MLE is $\hat\sigma^2=\mathrm{RSS}/(2N)$, whose expectation is $\sigma^2/2$ however large $N$ is. A simulation with $N=20$ and true $\sigma^2=1$ shows the profile likelihood centred near 0.45 and giving the true value almost no support. A second example: matched pairs with binary outcomes and a stratum effect in a logistic model, where the usual MLE of the treatment log odds ratio tends to twice the true value.

**10.2 Ideal case: orthogonal parameters (p. 276).** If the likelihood factorises as $L_1(\theta)L_2(\eta)$, then $L_1$ is clearly the likelihood of $\theta$, and the profile likelihood finds it automatically. Example: two Poisson counts with $\theta=\lambda_y/\lambda_x$ and $\eta=\lambda_x+\lambda_y$. For normal data, $\bar x$ and $s^2$ are independent and $s^2$ alone gives a likelihood for $\sigma^2$ free of $\mu$: the first **marginal likelihood**.

**10.3 Marginal and conditional likelihood (p. 278).** The general construction: transform the data to $(v,w)$. If the distribution of $v$ depends only on $\theta$, $p_\theta(v)$ is a marginal likelihood; if the conditional distribution of $v$ given $w$ depends only on $\theta$, $p_\theta(v\mid w)$ is a conditional likelihood. Both are genuine probabilities of observed data, which is their advantage over the profile. They are worth using when they are simpler, lose little information, or when the full likelihood is inconsistent. Neyman–Scott solved: the within-pair differences $(y_{i1}-y_{i2})/\sqrt2\sim N(0,\sigma^2)$ give the unbiased ANOVA estimate. In exponential families, conditioning on the sufficient statistic of $\eta$ removes $\eta$; with a non-canonical parametrisation it may not. How much information is lost is hard to quantify; the chapter bounds it in the Neyman–Scott case.

**10.4 Comparing Poisson means (p. 281).** Given the total $x+y$, $y$ is binomial with probability $\theta/(1+\theta)$: a conditional likelihood equal to the profile likelihood of Section 4.6. Unlike the profile, a conditional likelihood depends on the sampling scheme (e.g. if large counts are only recorded as "at least 5"). Same treatment for the aspirin data.

**10.5 Comparing proportions (p. 283).** Conditioning a 2×2 table on its margins gives the noncentral hypergeometric likelihood of the log odds ratio (Fisher's exact test at $\theta=0$), close to the profile likelihood. For many sparse strata, conditioning removes the stratum effects (Mantel–Haenszel; McNemar for matched pairs) and corrects the biased example of 10.1.

**10.6 Modified profile likelihood\* (p. 286).** Using the approximate density of the MLE, the profile log-likelihood is corrected by subtracting half the log-determinant of the information on $\eta$ (plus a Jacobian term that is negligible when $\theta$ and $\eta$ are information-orthogonal). The correction equals what you get by integrating $\eta$ out with Laplace's approximation. Examples: for normal $\sigma^2$ it reproduces the marginal likelihood; for regression it gives the $n-p$ divisor (Example 10.11); and for variance components, **Example 10.12 shows that the modified profile likelihood is REML**.

**10.7 Estimated likelihood (p. 292).** Plug in any reasonable $\hat\eta$: simple, but it ignores the uncertainty in $\hat\eta$. A theorem (Gong and Samaniego) gives the correct asymptotic variance; with the MLE of an orthogonal $\eta$ no correction is needed.

## Key results to know
1. Profile likelihood: $L_p(\theta)=L(\theta,\hat\eta_\theta)$, $\hat\eta_\theta=\arg\max_\eta L(\theta,\eta)$.
2. Neyman–Scott: with one mean per pair, $\mathrm E(\hat\sigma^2_{\text{ML}})=\sigma^2/2$ for every $N$; the marginal likelihood of the differences gives $\hat\sigma^2=\frac1N\sum_i(y_{i1}-y_{i2})^2/2$, unbiased.
3. Marginal likelihood $p_\theta(v)$; conditional likelihood $p_\theta(v\mid w)$.
4. Two Poisson counts: $y\mid x+y\sim\mathrm{Bin}\{x+y,\ \theta/(1+\theta)\}$, $\theta=\lambda_y/\lambda_x$.
5. Modified profile (orthogonal case): $\ell_m(\theta)=\ell_p(\theta)-\tfrac12\log|I_{\eta\eta}(\theta,\hat\eta_\theta)|$.
6. REML (Example 10.12): for $y\sim N(X\beta,V(\theta))$, $\ell_R(\theta)=\ell_p(\theta)-\tfrac12\log|X^\top V^{-1}X|+\text{const}$, with $\hat\beta_\theta$ the GLS estimate. Here Pawitan's $\theta$ is the vector of variance components, as in deck 16.
7. Normal regression: maximising the modified profile likelihood of $\sigma^2$ gives $\hat\sigma^2=\mathrm{RSS}/(n-p)$.

## Connect to class
- Session 28, frames "The Cox model" (the baseline hazard as an infinite-dimensional nuisance) and "Partial likelihood: derivation". The deck builds the partial likelihood as a product of conditional probabilities of who fails at each event time; Pawitan 11.7 calls the ranking likelihood a marginal likelihood, and 11.10 obtains it by profiling out $h_0$. This chapter explains why removing $h_0$ is legitimate.
- Session 16, frames "Why ML underestimates variances", "Error contrasts" and "Deriving the REML criterion". The deck integrates $\beta$ out (exact for Gaussian data); Example 10.12 reaches the same criterion as a modified profile likelihood, and 10.6 explains why both routes agree (Laplace).
- Sessions 3–5: profile likelihood (Pawitan 3.4) and the unbiased $\hat\sigma^2=\mathrm{RSS}/(n-p)$.

## Read carefully / safe to skim
- **Read carefully:** the introduction, 10.1, 10.2 and 10.3 (Session 28 reading list); Example 10.12 in 10.6 (Session 16).
- **Skim:** 10.4–10.5 (but know the McNemar/Mantel–Haenszel idea), the general derivation in 10.6 (starred), 10.7.

## Check yourself
1. Show that the profile likelihood of $\sigma^2$ in an iid normal sample is the likelihood you would have if $\mu$ were known to be $\bar x$. Why is that a problem?
2. In the Neyman–Scott setting, derive $\mathrm E(\hat\sigma^2_{\text{ML}})=\sigma^2/2$. Why does collecting more pairs not help?
3. What is the difference between a marginal and a conditional likelihood? Classify the "within-pair differences" likelihood.
4. Explain in words why the REML correction $-\tfrac12\log|X^\top V^{-1}X|$ "pays" for estimating $\beta$.
5. Why is the Cox baseline hazard called a nuisance parameter, and why can a profile likelihood with an infinite-dimensional nuisance still work in that case?
