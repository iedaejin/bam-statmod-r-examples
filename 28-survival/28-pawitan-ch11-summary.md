# Pawitan (2001), Ch. 11 — Complex data structure

**Session(s):** 28  ·  **Source:** Pawitan, *In All Likelihood: Statistical Modelling and Inference Using Likelihood*, OUP, Ch. 11, pp. 297–340 (survival sections 11.5–11.7 on pp. 309–320; 11.10 on pp. 331–335)
**Reading time:** ~40 min for 11.5–11.7, ~100 min for the whole chapter  ·  **Level:** core for 11.5–11.7; optional for 11.10; skim the rest

## Why read it
Session 28 is the only survival session of the course, and its likelihood theory is in Sections 11.5–11.7: how censored observations enter the likelihood, the exponential and Weibull models, the Kaplan–Meier estimator, and the Cox partial likelihood. The other sections (time series, Markov chains, spatial data, point processes) apply the same idea: for dependent or incomplete data, build the likelihood from the right conditional pieces.

## The big idea
A censored time $y_i$ with $\delta_i=0$ is not missing data: it tells us that the event happens after $y_i$. So an event contributes its density and a censored subject its survival probability; in hazard form, every subject contributes minus its cumulative hazard and each event adds a log-hazard. Under proportional hazards, the probability of the observed **ordering** of event times does not depend on the baseline hazard, and that ordering probability is Cox's partial likelihood for $\beta$.

## Section by section

**Introduction (p. 297).** Dependence and censoring call for the compromises of Ch. 10; compare any complex model with the simplest analysis as a safety check.

**11.1–11.4 (pp. 297–308), briefly.** Time series as products of conditional densities (AR(1): conditional likelihood = least squares); two-state Markov chains via transition counts (asthma attacks, regressed on pollution); replicated chains in an ulcer trial, where using all visits shows a benefit that a last-visit comparison misses; spatial Ising and Gaussian autoregressive models with pseudo-likelihood.

**11.5 Censored/survival data (p. 309).** Example: days to cancer death in two groups of rats, four censored. Ignoring the censoring or dropping censored cases can bias the comparison; modelling it is the right approach. The likelihood is a product of densities for events and survival probabilities for censored times. For the exponential model (Pawitan parametrises by the mean $\theta$), the MLE of the mean is total follow-up time divided by the number of events: the "person-years" method of epidemiology (the aspirin study reported heart attacks per 100,000 person-years). The standard error depends on the number of events. For the rats, the exponential comparison is far less significant than the naive ones, but the exponential model fits badly; a normal model with censoring (censored times contribute $1-\Phi$) is shown for comparison. Then the **Kaplan–Meier** estimator: without censoring it is one minus the empirical distribution function; written as a product of conditional survival proportions over failure times it extends to censored data, where censored subjects only reduce the risk set. A toy data set (3, 4, 6+, 8, 8, 10) is worked by hand; ties between a failure and a censoring are resolved by assuming the censoring comes after.

**11.6 Survival regression models (p. 314).** Exponential regression with a log link for the mean lifetime. To free the rigid mean–variance relation, write $\log T_i=\log\theta_i+\sigma W_i$ with $W_i$ standard extreme-value: the **Weibull** model, an **accelerated failure time** model in which $e^{\beta}$ multiplies the mean lifetime. For the rats, the scale estimate is far below 1, the likelihood ratio test rejects the exponential model, and the group effect becomes borderline significant.

**11.7 Hazard regression and Cox partial likelihood (p. 316).** Hazard $=$ density / survival, the relations (11.1)–(11.3), and the log-likelihood in hazard form (11.4). The proportional hazards model $\lambda_i(t)=\lambda_0(t)\exp(x_i^\top\beta)$: for two subjects, the probability that subject 1 fails first is $e^{x_1^\top\beta}/(e^{x_1^\top\beta}+e^{x_2^\top\beta})$ whatever the baseline. The probability of the whole observed ordering, a product over event times of the failing subject's share of its **risk set**, is the Cox partial likelihood; Pawitan describes it as a marginal likelihood based on ranks, which loses little information. Censored subjects enter only the risk sets of earlier events. A seven-subject toy example builds it term by term. For the rats, the hazard ratio (0.57) is much further from 1 than the exponential model's 0.84, because the hazard is no longer forced to be constant.

**11.8–11.9 Poisson point processes (pp. 320–331), briefly.** Likelihoods from an intensity function. An epilepsy trial with recurrent seizures is analysed by a conditional binomial comparison, by Poisson regression with offset $\log T_i$, and by a proportional-intensity model whose conditional likelihood is again Cox's; all give a rate ratio near 0.46.

**11.10 Discrete time model for Poisson processes (p. 331).** Cut time into small units: each subject becomes a 0/1 series, and the survival log-likelihood becomes a Poisson log-likelihood. Exponential, Weibull and Cox models are Poisson regressions with a constant, a $\log t$, or a free factor for time. Profiling out the free time factor gives exactly the Cox partial likelihood (no ties), plus an estimate of the baseline hazard at the event times. The epilepsy data refitted this way agree with the earlier methods.

## Key results to know
Course notation: hazard $h(t)$ (Pawitan $\lambda(t)$), event indicator $\delta_i$, $d=\sum_i\delta_i$, exponential **rate** $\lambda=1/\theta$.
1. Censored-data likelihood: $L=\prod_i f(y_i)^{\delta_i}S(y_i)^{1-\delta_i}$, so $\ell=\sum_i\{\delta_i\log h(y_i)-H(y_i)\}$.
2. $h(t)=f(t)/S(t)$, $\ H(t)=\int_0^t h(u)\,du$, $\ S(t)=e^{-H(t)}$, $\ f=hS$.
3. Exponential: $\hat\lambda=d/\sum_i y_i$, $\ \mathrm{se}(\hat\lambda)=\hat\lambda/\sqrt d$ (Pawitan: $\hat\theta=\sum_i y_i/d$, $\mathrm{se}(\hat\theta)=\hat\theta/\sqrt d$).
4. Kaplan–Meier: $\hat S(t)=\prod_{t_j\le t}(n_j-d_j)/n_j$, with $n_j$ at risk just before $t_j$ (those still under observation).
5. Weibull/AFT: $\log T_i=x_i^\top\beta+\sigma W_i$, $W_i$ standard extreme-value; $\sigma=1$ is the exponential.
6. Cox: $h(t\mid x)=h_0(t)e^{x^\top\beta}$ (no intercept), $L_p(\beta)=\prod_{i:\delta_i=1}\dfrac{e^{x_i^\top\beta}}{\sum_{k\in R(y_i)}e^{x_k^\top\beta}}$.
7. Poisson connection: a hazard model in discrete time is a Poisson GLM; Cox is the version with one parameter per event time.

## Connect to class
- Deck 28: "The censored-data likelihood", "Exponential model: MLE and standard error", "Kaplan–Meier by hand", "The Cox model", "Partial likelihood: derivation" and "Worked example: a toy partial likelihood". The deck derives each factor of the partial likelihood as the probability that the subject who fails at $y_i$ is subject $i$, given one failure in the risk set; Pawitan gets the same product as the probability of the observed ordering.
- R: `28-exponential-likelihood.Rmd`, `28-kaplan-meier.Rmd`, `28-cox-model.Rmd`; Lab 08 (`veteran` data).
- Not in Pawitan Ch. 11: Greenwood's variance, the log-rank test, the Breslow/Efron treatment of ties (Pawitan notes only that Cox's handling differs from the Poisson-profile result), and diagnostics for proportional hazards (`cox.zph()`, `28-ph-diagnostics.Rmd`), for which he only cites Grambsch and Therneau.
- The person-time rate is the offset idea of Session 9.

## Read carefully / safe to skim
- **Read carefully:** 11.5, 11.6 and 11.7. These match the Session 28 reading list and the reading questions in `28-readings.md` (the rat data, the toy Kaplan–Meier table, censored subjects in the partial likelihood, $\hat\beta_1=-0.569$ vs 0.84).
- **Optional:** 11.10, which links Cox regression, Poisson GLMs and the profile likelihood of Ch. 10.
- **Skim or skip:** 11.1–11.4 and 11.8–11.9.

## Check yourself
1. Derive $\hat\lambda=d/\sum_i y_i$ and $\mathrm{se}(\hat\lambda)=\hat\lambda/\sqrt d$ for exponential data with right censoring. Why does precision depend on $d$ and not on $n$?
2. Compute the Kaplan–Meier estimate for the times 3, 4, 6+, 8, 8, 10 and explain the size of each risk set.
3. Show that a censored subject appears only in denominators of the Cox partial likelihood.
4. Why do the exponential and Cox analyses of the rat data give such different hazard ratios (0.84 vs 0.57)? Which assumption differs?
5. Explain in words why the baseline hazard cancels in the probability that one subject fails before another under proportional hazards.
