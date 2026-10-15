# Session 28 — Readings

**Topic:** Censored and survival data
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Section and page numbers are from Pawitan (2001), *In All Likelihood*, Oxford University Press (checked against the 2001 printing). Check them against the library edition before publishing.

## Required

| Text | Sections | Pages | Focus |
|------|----------|-------|-------|
| Pawitan (2001) | 11.5 Censored/survival data | 309–314 | Likelihood $\prod p(y_i)^{\delta_i} P(T_i > y_i)^{1-\delta_i}$; the exponential model and the person-time estimate; Kaplan–Meier with a toy table |
| Pawitan (2001) | 11.6 Survival regression models | 314–316 | Exponential and Weibull regression; accelerated failure time interpretation |
| Pawitan (2001) | 11.7 Hazard regression and Cox partial likelihood | 316–320 | Hazard relations (11.1)–(11.4); the partial likelihood as a probability of the observed ordering; a toy two-group example |
| Pawitan (2001) | 10.1–10.3 Nuisance parameters; marginal and conditional likelihood | 273–281 | Why we want a likelihood for $\beta$ free of the baseline hazard $h_0$ |

Note on notation: Pawitan parametrises the exponential by its mean $\theta$; we use the rate $\lambda = 1/\theta$. His $\lambda(t)$ is our $h(t)$.

## Optional

| Text | Sections | Focus |
|------|----------|-------|
| Pawitan (2001) | 11.10 Discrete time model for Poisson processes (pp. 331–335) | The Cox partial likelihood derived from a Poisson model |
| Collett (2015), *Modelling Survival Data in Medical Research*, 3rd ed., CRC | Ch. 1–4 | A standard applied text: KM, log-rank, Cox model and model checking |
| Therneau & Grambsch (2000), *Modeling Survival Data: Extending the Cox Model*, Springer | Ch. 6 (testing proportional hazards) | Scaled Schoenfeld residuals and `cox.zph()` by the authors of the `survival` package |
| `survival` package vignette "Using Time Dependent Covariates" | `vignette("timedep", package = "survival")` | The `survSplit()` and `tt()` remedies, using the veteran data |

## What to focus on

1. The difference between $f(t)$, $S(t)$ and $h(t)$, and how each enters the likelihood.
2. Why "events / person-time" is the MLE of a constant hazard, and why its precision depends on the number of events.
3. The Kaplan–Meier estimator as a product of conditional survival probabilities.
4. How the baseline hazard disappears from the Cox partial likelihood.
5. What a hazard ratio does and does not mean, and how to check that it is constant over time.

## Reading questions

1. Pawitan's rat data (Example 11.5): why do "ignore censoring" and "drop censored cases" give biased means?
2. In the toy Kaplan–Meier table of Section 11.5, why is $n_3 = 3$ and not 4?
3. Show that a censored subject appears only in denominators of the Cox partial likelihood.
4. Pawitan reports $\hat\beta_1 = -0.569$ for the rat data under PH and a hazard ratio $0.84$ under the exponential model. Why can these differ so much?

## Next

**Session 29 — Group-project workshop.** Bring your draft report (see `group-work/`).
