# Pawitan (2001), Ch. 9 — Large-sample results

**Session(s):** 3–4 (results reused in 10 and 15–16)  ·  **Source:** Pawitan, *In All Likelihood*, OUP, Ch. 9, pp. 231–271  
**Reading time:** ~90 min (core sections ~60 min)  ·  **Level:** core for §9.2, 9.4, 9.5, 9.9, 9.11; the starred §9.6–9.8 are optional

## Why read it

This chapter justifies the "approximately" in everything we do with likelihoods: why $\hat\theta$ is approximately normal, why $\mathrm{se}(\hat\theta)=I(\hat\theta)^{-1/2}$, and why the Wald, score and likelihood ratio statistics are approximately $\chi^2$. It also covers profile likelihood ratio tests and $\chi^2$ goodness-of-fit tests — the tools behind Lab 01 and GLM deviance tests.

## The big idea

For iid data the score is a sum of independent terms with mean 0 and variance $\mathcal I_1(\theta)$, so the central limit theorem makes it approximately normal. A first-order Taylor expansion of the score around the true value transfers this normality to $\hat\theta$. A second-order expansion of the log-likelihood shows that the likelihood ratio statistic is approximately the squared Wald statistic. All three tests agree in large samples. In smaller samples, Pawitan recommends the likelihood ratio and the *observed* information.

## Section by section

**§9.1 Background results.** Laws of large numbers, the CLT (including Liapounov's non-iid version), convergence in distribution, Slutsky's theorem and continuous mapping. Skewness and discreteness slow convergence to normality.

**§9.2 Distribution of the score statistic.** Individual scores are iid with mean 0 and variance $\mathcal I_1(\theta)$ (Ch. 8), so $S(\theta)\approx N\{0,\mathcal I(\theta)\}$, for scalar or vector $\theta$. This gives the **score (Rao) test** $z=S(\theta_0)/\mathcal I(\theta_0)^{1/2}$. For a normal mean it is the usual $z$-test; for a Poisson mean its square is the familiar $(O-E)^2/E$. Versions using $I(\theta_0)$ or $I(\hat\theta)$ are asymptotically equivalent.

**§9.3 Consistency of MLE for scalar $\theta$.** Jensen's inequality gives the *information inequality* (Kullback–Leibler): on average the true model has a higher log-likelihood than any wrong one. Assuming a support free of $\theta$ and identifiability, Theorem 9.6 shows that a consistent sequence of local maxima exists. It is only an existence result: with several maxima it does not say which one. A unique MLE (as in full exponential families) is consistent.

**§9.4 Distribution of MLE and the Wald statistic.** Theorem 9.7: $\sqrt n(\hat\theta-\theta)\to N\{0,\mathcal I_1(\theta)^{-1}\}$, so asymptotically the MLE attains the Cramér–Rao bound. Regularity conditions: $\theta$ not on the boundary; information positive and finite; derivatives (up to third order) can pass under the integral. Proof: linearise the score around the true $\theta$ and apply Slutsky. In practice $\hat\theta\approx N\{\theta,I(\hat\theta)^{-1}\}$ gives the Wald test and interval — the likelihood interval of the *quadratic approximation*. Example: the aspirin data of Ch. 1.

**§9.5 Distribution of likelihood ratio statistic.** Expanding $\ell$ around $\hat\theta$ gives $W=2\log\{L(\hat\theta)/L(\theta)\}\approx I(\hat\theta)(\hat\theta-\theta)^2\to\chi^2_1$. This is the general justification of the 15% (exactly 0.147) cut-off for 95% intervals used in Ch. 2. A likelihood interval at cut-off $a$ has approximate confidence $P(\chi^2_1\le-2\log a)$.

**§9.6 Observed versus expected information\*.** A Cauchy simulation (after Efron and Hinkley) shows that, conditionally on the observed information, the Wald statistic built with $\mathcal I(\hat\theta)$ has unstable error rates, while the one built with $I(\hat\theta)$ and the LR statistic are stable. Prefer $I(\hat\theta)$, and overall the LR statistic.

**§9.7–9.8\*.** The same comparison for the score test ($I(\hat\theta)$ is best); then higher-order theory ($p^*$ "magic formula", saddlepoint, Bartlett correction). Beyond this course.

**§9.9 Multiparameter case.** The same results for $\theta\in\mathbb R^p$: score, Wald and LR statistics are approximately $\chi^2_p$ for a joint test; $\hat\theta\approx N\{\theta,I(\hat\theta)^{-1}\}$; standard errors from the diagonal of $I(\hat\theta)^{-1}$.

**§9.10 Examples.** (i) Logistic regression of surgical mortality on age: score $\sum_i(y_i-p_i)x_i$, information $\sum_i p_i(1-p_i)x_ix_i^\top$. (ii) Poisson regression of insurance claims on age. (iii) One-way random effects (estrone measurements on five women): the $F$-test for between-person variation is overwhelming, yet the Wald test for $\sigma_a^2$ is not significant, because the profile likelihood of the variance component is far from quadratic. Previews of Sessions 9–10 and 15–16.

**§9.11 Nuisance parameters.** Wald inference depends on the parametrization; the profile likelihood ratio does not. Theorem 9.8: with $p$ free parameters in total and $r$ under $H_0$, $W=2\log\{\max L/\max_{H_0}L\}\to\chi^2_{p-r}$. The one-sample $t$-test is an exact LR test. The proof also justifies the Ch. 3 claim that a profile's curvature is $1/I^{11}$.

**§9.12 $\chi^2$ goodness-of-fit tests.** For multinomial counts, $W=2\sum O\log(O/E)$ is close to Pearson's $\sum(O-E)^2/E$ (example: birthdays by month). With $r$ parameters estimated *from the grouped counts*, the degrees of freedom are $K-1-r$; for independence in an $I\times J$ table they are $(I-1)(J-1)$.

## Key results to know

1. $S(\theta)\approx N\{0,\mathcal I(\theta)\}$; score test $z=S(\theta_0)/\mathcal I(\theta_0)^{1/2}$ (slides: $S_c=z^2\approx\chi^2_1$).
2. $\sqrt n(\hat\theta-\theta)\xrightarrow{d}N\{0,\mathcal I_1(\theta)^{-1}\}$; in practice $\hat\theta\approx N\{\theta,I(\hat\theta)^{-1}\}$, $\mathrm{se}(\hat\theta)=I(\hat\theta)^{-1/2}$.
3. Wald: $(\hat\theta-\theta_0)^2I(\hat\theta)\approx\chi^2_1$.
4. LR: $2\{\ell(\hat\theta)-\ell(\theta_0)\}\approx\chi^2_1$; 95% interval $\{\theta:\ell(\theta)\ge\ell(\hat\theta)-1.92\}$.
5. Multiparameter and nested models: $2\{\ell(\hat\theta)-\ell(\tilde\theta_0)\}\approx\chi^2_{p-r}$.
6. $2\sum O\log(O/E)\approx\sum(O-E)^2/E$, with $K-1-r$ df.

Notation: Pawitan's $W$ is the **likelihood ratio** statistic (our $\mathrm{LR}$); in §9.6 his $W_1,W_2$ are Wald statistics with expected and observed information. The slides use $W$ for Wald. His score test is a signed $z$, and the slides' $S_c$ is its square.

## Connect to class

- **Session 3 slides:** "Why $\hat\theta$ is approximately normal" is the proof of Theorem 9.7; "Properties of the MLE" lists the same regularity conditions; "Three tests of $H_0:\theta=\theta_0$" uses $\mathcal I(\theta_0)$ for the score test and $I(\hat\theta)$ for Wald, as in §9.2 and §9.4; "General LR test" is Theorem 9.8.
- **Lab 01 (Session 4):** the exponential vs gamma LR test for `geyser` ($\chi^2_1$, one restriction) and the Wald vs LR intervals for `discoveries`. R: `03-wald-score-lr.Rmd`, `04-mle-toolkit.Rmd`.
- **What the book does not cover:** Pawitan lists "not a boundary parameter" and identifiability as *assumptions*. He does not discuss what happens when they fail. The slides' boundary example ($y=0$), the non-identifiable ridge, and the Lab 01 warning that the LR test of one vs two mixture components is not $\chi^2$ come from class material, not from this chapter.
- **Later:** deviance and analysis-of-deviance tests (Session 10) are §9.11–9.12. The random-effects example foreshadows variance components at the boundary (Sessions 15–16).

## Read carefully / safe to skim

- **Read carefully:** §9.2, 9.4, 9.5 (statements and the Taylor-expansion arguments), §9.9, and the statement and degrees-of-freedom logic of §9.11.
- **Read for insight:** §9.10, especially the random-effects example.
- **Skim:** §9.1 if you know the LLN and CLT; the consistency proof in §9.3; §9.12 (optional). **Optional:** §9.6–9.8 (starred), though the conclusion of §9.6 is worth remembering.

## Check yourself

1. For iid exponential data with rate $\lambda$, derive the Wald, score and LR statistics for $H_0:\lambda=\lambda_0$ and show that each depends on the data only through $\bar y$.
2. Starting from $0=S(\hat\theta)\approx S(\theta)-I(\theta)(\hat\theta-\theta)$, explain each step that leads to $\sqrt n(\hat\theta-\theta)\to N\{0,\mathcal I_1(\theta)^{-1}\}$. Where are the CLT and the LLN used?
3. Theorem 9.6 is an existence result. What does that mean in practice when `optim()` returns different maxima from different starting values?
4. In the estrone example the $F$-test and the Wald test for $\sigma_a^2$ disagree sharply. Explain in words why, and which summary you would report.
5. A Poisson model with one estimated mean is checked against counts in $K=8$ classes. How many degrees of freedom does the goodness-of-fit test have, and why must the mean be estimated from the grouped counts?
