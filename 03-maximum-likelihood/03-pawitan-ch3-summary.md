# Pawitan (2001), Ch. 3 — More properties of the likelihood

**Session(s):** 3 (profile likelihood also in Lab 01, Session 4)  ·  **Source:** Pawitan, *In All Likelihood*, OUP, Ch. 3, pp. 53–72  
**Reading time:** ~50 min  ·  **Level:** core for §3.3–3.4; optional for §3.1–3.2 and §3.5

## Why read it

Real models have several parameters. This chapter extends the likelihood toolkit to many parameters (score vector, information matrix), introduces the **profile likelihood** for a parameter of interest with nuisance parameters, and explains why likelihood cut-offs must depend on the number of parameters. It also makes precise the sense in which the likelihood "contains all the information" (sufficiency).

## The big idea

The likelihood function is the most compact summary of the data that loses no information about $\theta$ (it is minimal sufficient). With several parameters we study one at a time by maximising out the others: the profile likelihood behaves like an ordinary one-parameter likelihood, but its curvature — and therefore the standard error — must account for the parameters we did not know. Calibration also changes with dimension: a likelihood ratio that is unusual for one parameter is common for ten.

## Section by section

**§3.1 Sufficiency.** A statistic $T$ is sufficient for $\theta$ if the conditional distribution of the data given $T$ does not involve $\theta$: once $T$ is known, the rest of the data could be simulated without knowing $\theta$, so it carries no further information. Sufficiency is always relative to a model; "the sample mean is sufficient" means nothing without one. Example: for iid Poisson data, $\sum_i y_i$ is sufficient. Theorem 3.1 (factorization) is the practical test. For the normal model it gives $\sum_i y_i$ and $\sum_i y_i^2$ as jointly sufficient for $(\mu,\sigma^2)$.

**§3.2 Minimal sufficiency.** There are many sufficient statistics (the whole data set is one); a minimal one is a function of every other. Theorem 3.2: the likelihood based on any sufficient statistic equals (up to a constant) the likelihood based on all the data, so **the likelihood function itself is minimal sufficient**. Example 3.5, uniform on $(\theta-1,\theta+1)$, is instructive: the minimal sufficient statistic is (min, max), there is no sufficient single estimate, the MLE is not unique, and the sample mean or median can even have zero likelihood. The subsection on the monotone likelihood ratio links minimal sufficiency to the score.

**§3.3 Multiparameter models.** No new definition is needed: $L(\theta)$ is still the probability of the data, now with $\theta\in\mathbb R^p$. Model complexity is measured by the number of parameters, not of observations. The score is a gradient vector, the MLE solves $S(\hat\theta)=0$, and the observed information is the matrix of minus second derivatives at $\hat\theta$; the quadratic approximation becomes a quadratic form. Examples: normal $(\mu,\sigma^2)$, with $\hat\sigma^2$ dividing by $n$ and a diagonal information matrix; the gamma model, whose shape equation (digamma function) needs a numerical solution; and a multinomial model for grouped speed-of-light data.

**§3.4 Profile likelihood.** To focus on a parameter of interest, replace each nuisance parameter by its MLE *at that fixed value of the interest parameter* (Definition 3.3). The profile is then treated as an ordinary likelihood. Pawitan calls this pragmatic (its weaknesses come in Ch. 10) and notes that integrating parameters out, as Bayesians do, is not meaningful for a likelihood. Example 3.10 (normal data, $\mu$ of interest): the profile of $\mu$ is proportional to $\{\hat\sigma^2(\mu)\}^{-n/2}$ with $\hat\sigma^2(\mu)=n^{-1}\sum_i(y_i-\mu)^2$. It differs from the *estimated likelihood*, a slice at $\sigma^2=\hat\sigma^2$. Fixing $\sigma^2$ at a wrong value (e.g. 1) gives badly wrong inference. **Curvature of the profile:** it is not the diagonal element $I_{11}$ but $1/I^{11}$, where $I^{11}$ is the corresponding element of $I(\hat\theta)^{-1}$. This is smaller, because it accounts for the unknown nuisance parameter. Hence $\mathrm{se}(\hat\theta_j)=\sqrt{I^{jj}}$: square roots of the diagonal of the *inverse*.

**§3.5 Calibration in the multiparameter case.** For $p$ parameters tested jointly, $2\log\{L(\hat\theta)/L(\theta_0)\}$ is (approximately) $\chi^2_p$. So a fixed cut-off such as 15% corresponds to larger and larger P-values as $p$ grows, and must be adjusted for dimension. The likelihood-based confidence region is $\{\theta:L(\theta)/L(\hat\theta)>\exp(-\tfrac12\chi^2_{p,1-\alpha})\}$; for $p=2$ the $100\alpha\%$ likelihood contour is an approximate $100(1-\alpha)\%$ region. The last part derives an **AIC**-type rule from pure likelihood reasoning (compare with $c^p$ instead of $c$): $\mathrm{AIC}=-2\log L(\hat\theta)+2p$, smaller is better. A table compares $2p$ with $\chi^2_{p,0.95}$. AIC is more lenient than a 5% likelihood ratio test for small $p$ and stricter for large $p$, with the crossover around $p\approx7$.

## Key results to know

1. Factorization: $T$ is sufficient iff $f(y;\theta)=g\{t(y),\theta\}\,h(y)$. The likelihood is minimal sufficient.
2. Score vector $S(\theta)=\partial\ell/\partial\theta$; observed information matrix $I(\hat\theta)=-\partial^2\ell/\partial\theta\,\partial\theta^\top$ at $\hat\theta$; $\ell(\theta)\approx\ell(\hat\theta)-\tfrac12(\theta-\hat\theta)^\top I(\hat\theta)(\theta-\hat\theta)$.
3. Normal: $\hat\mu=\bar y$, $\hat\sigma^2=n^{-1}\sum_i(y_i-\bar y)^2$, $I(\hat\mu,\hat\sigma^2)=\mathrm{diag}\{n/\hat\sigma^2,\ n/(2\hat\sigma^4)\}$.
4. Profile log-likelihood: $\ell_p(\psi)=\max_\lambda\ell(\psi,\lambda)=\ell\{\psi,\hat\lambda(\psi)\}$.
5. $\mathrm{se}(\hat\theta_j)=\sqrt{[I(\hat\theta)^{-1}]_{jj}}$; profile curvature $1/[I(\hat\theta)^{-1}]_{jj}\le I_{jj}$.
6. Joint LR: $2\{\ell(\hat\theta)-\ell(\theta_0)\}\approx\chi^2_p$; $\mathrm{AIC}=-2\ell(\hat\theta)+2p$.

Notation: Pawitan writes the parameter of interest as $\theta$ and the nuisance as $\eta$ (slides: $\psi$ and $\lambda$). He writes $I^{11}$ for the (1,1) element of $I^{-1}$, and $L(\theta)$ (or $L_p$) for a profile. His gamma model uses rate $\lambda$ and shape $\alpha$; the slides use rate $\beta$ and shape $\alpha$.

## Connect to class

- **Session 3 slides:** "Deriving MLEs: normal with two parameters" and "Two parameters: the information matrix" are Pawitan's normal example on the New Haven data, including the warning to take square roots of the diagonal **of the inverse**. "Several parameters: profile likelihood" uses the same profile $\ell_p(\mu)=-\tfrac n2\log\hat\sigma^2(\mu)$; "Profile likelihood: the ridge of the surface" is the contour plot of Figure 3.1 for `nhtemp`. "Example: gamma model for aircondit" profiles out the rate exactly as in Example 3.8.
- **Session 4:** Extension Task 2 in `04-lab-maximum-likelihood/04-exercises.md` (profile-likelihood interval for $\mu_1$ in the five-parameter normal mixture) applies §3.4.
- **Later:** AIC returns in Session 6 (model selection; Pawitan derives it properly in Ch. 13). Sufficiency reappears with the exponential family and GLMs (Session 9).
- **Reading list note:** the Session 3 reading list mentions "invariance, reparametrization" under Ch. 3. In the book these are §2.8–2.9 (Ch. 2).

## Read carefully / safe to skim

- **Read carefully:** §3.3 and §3.4, especially the curvature-of-the-profile result and why $I_{11}$ overstates the information.
- **Read once:** the first half of §3.5 (dimension-dependent calibration).
- **Skim / optional:** §3.1–3.2 (sufficiency theory, not examined beyond the idea), the monotone likelihood ratio, and the AIC calibration (Session 6 covers AIC).

## Check yourself

1. For iid Poisson data, use the factorization theorem to show that $\sum_i y_i$ is sufficient. Then check that the likelihood from $\sum_i y_i\sim\mathrm{Pois}(n\lambda)$ is proportional to the full-data likelihood.
2. Derive the profile log-likelihood of $\sigma^2$ in the normal model and compare it with the log-likelihood of $\sigma^2$ when $\mu$ is known. What does the comparison say about the "price" of not knowing $\mu$?
3. With $I(\hat\theta)=\begin{pmatrix}4 & 3\\ 3 & 5\end{pmatrix}$, compute $\mathrm{se}(\hat\theta_1)$ correctly, and also as $I_{11}^{-1/2}$. Explain in words why the second value is too small.
4. Explain the difference between a profile likelihood and an estimated (sliced) likelihood. When are they close?
5. Why is a likelihood ratio of 15% weak evidence against a hypothesis that fixes ten parameters, but moderate evidence against one that fixes a single parameter?
