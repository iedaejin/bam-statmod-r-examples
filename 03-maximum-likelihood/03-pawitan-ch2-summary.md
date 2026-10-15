# Pawitan (2001), Ch. 2 — Elements of likelihood inference

**Session(s):** 3 (also 4)  ·  **Source:** Pawitan, *In All Likelihood*, OUP, Ch. 2, pp. 21–52  
**Reading time:** ~90 min  ·  **Level:** core

## Why read it

The chapter behind most of Session 3 and Lab 01. It defines the likelihood and builds three tools we use all term: the MLE, its standard error from the curvature, and likelihood-based intervals calibrated with $\chi^2_1$.

## The big idea

For fixed data, $L(\theta)$ ranks parameter values by how probable they make what we observed. The *whole function* carries the information; the MLE and the curvature at the MLE summarise it when the log-likelihood is close to a quadratic ("regular"). Intervals collect the $\theta$ whose likelihood is not too far below the maximum, with the cut-off calibrated by $\chi^2_1$. Likelihood ratios are invariant to reparametrization, so likelihood intervals are safer than Wald intervals.

## Section by section

**§2.1 Classical definition.** Probability reasons from a known $\theta$ to data; the likelihood reverses the direction. With 8 heads in 10 tosses, values of $\theta$ that make the observation very improbable are implausible. Definition 2.1: the likelihood is the probability of the observed data as a function of $\theta$. Continuous data are recorded with finite precision, so the density can stand in for the probability. For censored, grouped or interval data this shortcut fails and the probability of the observed range must be used.

**§2.2 Examples.** Likelihoods for unusual data: only an upper bound on a binomial count (seeds), capture–recapture for a population size $N$, a rare genotype under two stopping rules, and a normal mean known only from an interval or from the sample maximum. Example 2.5 resolves the two-envelope paradox of Ch. 1: the two amounts have equal likelihood, and likelihoods cannot be averaged like probabilities.

**§2.3 Combining likelihoods.** Independent data sets multiply their likelihoods, so log-likelihoods add; for iid data $\ell(\theta)=\sum_i\log f(y_i;\theta)$. Example 2.7 combines the maximum of one sample with the mean of another. The starred subsection notes that a Bayesian posterior is prior × likelihood; with a flat prior the two have the same shape.

**§2.4 Likelihood ratio.** A one-to-one transformation of the data multiplies the likelihood by a Jacobian free of $\theta$, so only *ratios* $L(\theta_1)/L(\theta_2)$ carry evidence. Constants can be dropped; scale the likelihood to a maximum of 1 (log-likelihood to 0), but do **not** rescale it to integrate to 1. A deck-of-cards analogy gives a feel for a ratio of about 200.

**§2.5 Maximum and curvature of likelihood.** The MLE summarises the function, but one number is rarely enough. Score $S(\theta)=\partial\ell/\partial\theta$, MLE from $S(\hat\theta)=0$, and curvature $I(\hat\theta)=-\ell''(\hat\theta)$, the *observed Fisher information* (a number, at the MLE). Normal mean, known $\sigma^2$: $I=n/\sigma^2$ and $\mathrm{var}(\hat\theta)=I^{-1}$ exactly. Binomial: $I(\hat\theta)=n/\{\hat\theta(1-\hat\theta)\}$. Without a closed form, both come from numerical optimisation. A Taylor expansion gives the quadratic approximation (Key result 4); check it by plotting. For the binomial it is poor at $n=10$ and good at $n=100$.

**§2.6 Likelihood-based intervals.** *Pure likelihood intervals* $\{\theta: L(\theta)/L(\hat\theta)>c\}$ need a cut-off (Fisher treated values below about 1/15 as suspect). To calibrate $c$: in the normal-mean model Wilks' statistic $W=2\log\{L(\hat\theta)/L(\theta)\}$ is exactly $\chi^2_1$, and approximately so in regular problems. Choosing $c=\exp\{-\tfrac12\chi^2_{1,1-\alpha}\}$ gives a $100(1-\alpha)\%$ confidence interval: about 15% for 95%, 4% for 99%. Other examples: uniform$(0,\theta)$, irregular yet with exact coverage $1-c$; and a binomial with MLE 0, where the standard error is undefined but the likelihood interval exists. The likelihood ratio test turns $L(\theta_0)/L(\hat\theta)$ into a P-value via $\chi^2_1$.

**§2.7 Standard error and Wald statistic.** Under the quadratic approximation the likelihood interval becomes $\hat\theta\pm\sqrt{-2\log c}\;I(\hat\theta)^{-1/2}$, which motivates $\mathrm{se}(\hat\theta)=I(\hat\theta)^{-1/2}$, the Wald statistic $z=(\hat\theta-\theta_0)/\mathrm{se}(\hat\theta)$ and the Wald interval $\hat\theta\pm1.96\,\mathrm{se}$. There are two layers of approximation (quadratic shape, then normal calibration). When the log-likelihood is skewed, the Wald interval includes values less likely than some it excludes; for 8/10 it goes above 1. Advice: plot the likelihood, and distrust standard errors near a boundary.

**§2.8 Invariance principle.** Relabelling a parameter (e.g. probability to log-odds) should not change relative evidence, so likelihood ratios transform *without* a Jacobian, unlike a Bayesian posterior. Pawitan presents invariance as a convenient axiom.

**§2.9 Practical implications of invariance.** The likelihood of $\psi=g(\theta)$ is obtained by relabelling the axis. Theorem 2.1: the MLE of $g(\theta)$ is $g(\hat\theta)$. A Wald interval improves on a scale where the likelihood is more regular, using the delta method and back-transforming (the log-odds example). The likelihood interval does this automatically: it is valid whenever *some* normalising transformation exists, even an unknown one — hence Pawitan's preference for it.

## Key results to know

1. $L(\theta)=f(y;\theta)$ as a function of $\theta$; for iid data $\ell(\theta)=\sum_{i=1}^n\log f(y_i;\theta)$. Independent sources: add log-likelihoods.
2. Only ratios matter: constants not involving $\theta$ can be dropped.
3. $S(\hat\theta)=0$; observed information $I(\hat\theta)=-\ell''(\hat\theta)$; $\mathrm{se}(\hat\theta)=I(\hat\theta)^{-1/2}$.
4. Quadratic approximation: $\ell(\theta)-\ell(\hat\theta)\approx-\tfrac12 I(\hat\theta)(\theta-\hat\theta)^2$.
5. Wilks: $2\{\ell(\hat\theta)-\ell(\theta)\}\approx\chi^2_1$, so the 95% likelihood interval is $\{\theta:\ell(\theta)\ge\ell(\hat\theta)-1.92\}$, i.e. relative likelihood $\ge e^{-1.92}=0.147$ (Pawitan rounds to 15%).
6. Wald: $z=(\hat\theta-\theta_0)/\mathrm{se}(\hat\theta)$; interval $\hat\theta\pm1.96\,\mathrm{se}(\hat\theta)$.
7. Invariance: $\widehat{g(\theta)}=g(\hat\theta)$; delta method $\mathrm{se}\{g(\hat\theta)\}=|g'(\hat\theta)|\,\mathrm{se}(\hat\theta)$.

Notation: Pawitan writes $\log L(\theta)$ for our $\ell(\theta)$ and $x$ for the data. He uses **$W$ for the likelihood ratio (Wilks) statistic**; the slides call it $\mathrm{LR}$ and use $W$ for the *Wald* statistic. In this chapter "Fisher information" always means the observed $I(\hat\theta)$; the expected information $\mathcal I(\theta)$ appears in Ch. 8.

## Connect to class

- **Session 3 slides:** "Definition", "The likelihood is not a density for $\theta$" and "Binomial: 8 successes in 10 trials" use Pawitan's own running example. "From tests to intervals" and "Computing a likelihood interval" give the 0.147 cut-off and compute intervals with `uniroot()`. "Parametrization matters for Wald, not for LR" makes the §2.9 point with the `aircondit` data instead of log-odds. "Practical problems" (0 successes out of 20) is the same lesson as Pawitan's seed example.
- **R:** `03-likelihood-basics.Rmd`, `03-wald-score-lr.Rmd`.
- **Lab 01 (Session 4):** Wald vs likelihood intervals for `discoveries`; the delta method after optimising on $\log\lambda$.
- **Different emphasis:** the slides obtain intervals by inverting tests calibrated by large-sample theory (Ch. 9). Pawitan starts from the likelihood function, adds the calibration afterwards, and accepts "pure likelihood" statements when no calibration exists.

## Read carefully / safe to skim

- **Read carefully:** §2.1, §2.3–2.7, §2.9. The quadratic approximation, the 1.92 / 15% cut-off, $\mathrm{se}=I(\hat\theta)^{-1/2}$ and Wald vs likelihood intervals are all examinable.
- **Skim:** the more exotic likelihoods in §2.2 (read one or two), the starred Bayesian subsection, and the philosophical part of §2.8.

## Check yourself

1. A rare genotype first appears in the $k$-th subject tested. Write $L(\theta)$, derive $\hat\theta$ and $I(\hat\theta)$, and give $\mathrm{se}(\hat\theta)$.
2. Use the data-transformation argument of §2.4 to explain why we may drop multiplicative constants from $L(\theta)$.
3. Explain in words why the set $\{\theta: L(\theta)/L(\hat\theta)\ge0.147\}$ is an approximate 95% confidence interval. When is the coverage exact?
4. For $y=8$, $n=10$, why does the Wald interval for $\theta$ exceed 1? Why does a Wald interval on the log-odds scale, transformed back, behave better?
5. When would you report a pure likelihood interval instead of a confidence interval? Give one situation from the chapter.
