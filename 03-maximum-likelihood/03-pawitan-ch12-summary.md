# Pawitan (2001), Ch. 12 — EM Algorithm

**Session(s):** 3–4 (optional frames and Extension Task 3)  ·  **Source:** Pawitan, *In All Likelihood*, OUP, Ch. 12, pp. 341–364  
**Reading time:** ~50 min  ·  **Level:** **optional** — EM is not in the 2026-27 syllabus and is not examined

## Why read it

In Session 3 we maximise log-likelihoods with Newton–Raphson, Fisher scoring and `optim()`. The EM algorithm is the classical, statistically motivated alternative for problems where some data are "missing": genuinely missing values, unobserved group labels in a mixture, or random effects. Read it if you want to understand the optional EM frames of Session 3 or do Extension Task 3 of Lab 01.

## The big idea

If the likelihood of the observed data $y$ is awkward but the likelihood of some *complete* data $(y,z)$ would be easy, iterate two steps. **E-step:** replace the complete-data log-likelihood by its conditional expectation given $y$ and the current estimate. **M-step:** maximise that expectation. Each iteration never decreases the observed-data log-likelihood, so the algorithm climbs steadily. The price is slow convergence and no standard errors as a by-product.

## Section by section

**Introduction.** EM suits problems where the incomplete-data analysis is complicated but "filling in" the missing part makes the analysis simple. "Missing" can mean any incomplete information. The general framework is due to Dempster, Laird and Rubin (1977), who showed that many existing algorithms were special cases.

**§12.1 Motivation.** A two-way layout with one missing cell. Filling the cell with a guess, refitting the simple complete-data formulas, re-predicting the cell and repeating converges to the least-squares (normal ML) solution without inverting $X^\top X$.

**§12.2 General specification.** Observed data $y$ are a function of complete data $x$; information is lost going from $x$ to $y$. Define $Q(\theta\mid\theta^{0})=\mathbb E\{\log L(\theta;x)\mid y,\theta^{0}\}$ (E-step) and maximise it over $\theta$ (M-step). Example 12.2, a classic genetic multinomial: splitting one observed cell into two latent cells turns the likelihood into a binomial-type one with a closed-form maximiser. The E-step only needs the expected split. Newton–Raphson approximates the log-likelihood by a quadratic; EM approximates it by $Q$, and the better the approximation the faster the convergence.

**§12.3 Exponential family model.** If the complete data form a full exponential family with sufficient statistic $T$, the E-step just fills in $\mathbb E(T\mid y,\theta^{0})$, and at convergence $\mathbb E(T\mid\hat\theta)=\mathbb E(T\mid y,\hat\theta)$. This yields the **missing information principle**: observed information = complete-data information − missing information. The convergence rate is governed by the *fraction* of information that is missing.

**§12.4 General properties.** The key property: each EM step does not decrease $\ell(\theta;y)$. The proof uses the information inequality of Ch. 9. EM handles parameter constraints naturally, because each M-step is an MLE-type estimate (probabilities stay in $[0,1]$). Drawbacks: convergence can be very slow; there are no automatic standard errors; and the limit can be any stationary point — a local maximum or even a saddle point — so several starting values are advisable.

**§12.5 Mixture models.** For a $J$-component mixture, direct Newton–Raphson is fragile because of the constraints on the mixing probabilities. Treat the unknown component label of each observation as missing. E-step: for each observation, compute the conditional probability that it came from each component (a by-product that is itself useful for clustering). M-step: weighted MLEs for each component, with mixing proportions equal to the average of those probabilities. Pawitan's example is the **Old Faithful geyser waiting times (299 eruptions)** fitted with a two-component normal mixture. These are the same data as Part 3 of Lab 01, and EM converges to essentially the estimates `optim()` finds from start A in the lab.

**§12.6 Robust estimation.** Regression with $t$-distributed errors, written as normal errors with unobserved random weights. EM becomes iteratively reweighted least squares, and outlying observations get small weights. The degrees of freedom are handled by profiling.

**§12.7 Estimating infection pattern.** Exposure histories with only the final infection status observed. The unobserved infection indicators at each exposure make both the E- and M-steps closed-form.

**§12.8 Mixed model estimation\*.** For $y=X\beta+Zb+e$, take $(y,b)$ as the complete data. The E-step needs $\mathbb E(b\mid y)$ and $\mathrm{var}(b\mid y)$ (the BLUP formulas); the M-step is weighted least squares for $\beta$ plus closed-form updates for the variance components in simple structures.

**§12.9 Standard errors.** If the observed-data log-likelihood can be written down, compute $I(\hat\theta;y)$ directly (analytically or numerically). Otherwise the observed information can be expressed through derivatives of $Q$ (Oakes, 1999). This is not always simpler.

## Key results to know

1. E-step: $Q(\theta\mid\theta^{(t)})=\mathbb E\{\ell_c(\theta;y,z)\mid y,\theta^{(t)}\}$; M-step: $\theta^{(t+1)}=\arg\max_\theta Q(\theta\mid\theta^{(t)})$.
2. Ascent property: $\ell(\theta^{(t+1)})\ge\ell(\theta^{(t)})$ for the observed-data log-likelihood.
3. Missing information principle: $I(\theta;y)=I(\theta;x)-I(\theta;x\mid y)$. Slow convergence when much information is missing.
4. Two-component normal mixture: $r_i=\dfrac{p\,\phi(y_i;\mu_1,\sigma_1)}{p\,\phi(y_i;\mu_1,\sigma_1)+(1-p)\,\phi(y_i;\mu_2,\sigma_2)}$; then $p=\bar r$, $\mu_1=\sum_i r_iy_i/\sum_i r_i$, $\sigma_1^2=\sum_i r_i(y_i-\mu_1)^2/\sum_i r_i$ (and $1-r_i$ for component 2).
5. EM gives no standard errors by itself: compute $I(\hat\theta)$ from the observed-data log-likelihood.

Notation: Pawitan uses $y$ for the observed (incomplete) data and $x$ for the complete data; the slides use $y$ observed, $z$ missing and $\ell_c$ for the complete-data log-likelihood. He writes the mixing probabilities as $\pi_j$ (slides: $p$, $1-p$) and does not use the word "responsibilities".

## Connect to class

- **Session 3 slides:** "Further reading (optional): the EM algorithm" and "EM for a two-component normal mixture (optional)". Material in `03-maximum-likelihood/extras/04-em-algorithm/`.
- **Session 4:** Extension Task 3 in `04-lab-maximum-likelihood/04-exercises.md` asks you to implement EM for the geyser mixture and compare it with `optim()`. Pawitan's §12.5 is the reference.
- **What the slides add:** the stopping-rule warning (monitor the log-likelihood computed *before* normalising the responsibilities). The lab also covers label switching and the unbounded likelihood when one $\sigma_k\to0$ at a tied value. The chapter does not discuss these degeneracies.
- **Later:** §12.8 previews the BLUP formulas of Session 16.

## Read carefully / safe to skim

- **If you read it:** §12.2, §12.4 and §12.5 are the useful core for the mixture task.
- **Skim:** §12.3 (exponential-family view and missing information), §12.6–12.7 (applications), §12.8\* and §12.9.
- Nothing in this chapter is examined.

## Check yourself

1. Write the E-step and M-step for a two-component normal mixture with *known, equal* variances $\sigma^2=1$. Which formulas from Key result 4 survive?
2. Explain in words why an EM step can never decrease the observed-data log-likelihood, while a Newton–Raphson step can.
3. Why does EM converge slowly when the components of a mixture overlap heavily? Use the missing information principle.
4. EM stopped at a point where both components have the same mean and variance. What kind of stationary point is this likely to be, and how would you check?
5. After EM has converged, how would you get standard errors for $(p,\mu_1,\mu_2,\sigma_1,\sigma_2)$ in R?
