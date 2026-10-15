# Session 4 — Exercises

**Topic:** Lab 01, maximum likelihood in R
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

For pairs who finish the lab early, or as practice before Session 5. Use the lab data (`data/discoveries.csv`, `data/geyser.csv`).

---

## Task 1 — Is the overdispersion a time trend?

The discoveries counts are overdispersed relative to a constant-rate Poisson model. Perhaps the rate changes over time.

1. Let $x_i=(\text{year}_i-1910)/10$. Write the negative log-likelihood of the model $y_i\sim\mathrm{Pois}(\lambda_i)$, $\log\lambda_i=\beta_0+\beta_1x_i$, and maximise it with `optim()`.
2. Give $\hat\beta_1$, its standard error from the Hessian, and the LR test of $H_0:\beta_1=0$ against the constant-rate model.
3. Add a quadratic term $\beta_2x_i^2$. Test it with an LR test. Check your estimates with `glm(count ~ x + I(x^2), family = poisson)` (GLMs start in Session 9).
4. Recompute the dispersion statistic using the fitted $\hat\lambda_i$ of the quadratic model: $\sum_i(y_i-\hat\lambda_i)^2/\hat\lambda_i$ on $n-3$ df. Does the time trend explain the overdispersion?

---

## Task 2 — A profile-likelihood interval in a five-parameter model

For the two-component mixture fitted from start A in the lab:

1. Compute the Wald 95% interval for $\mu_1$ from the inverse Hessian.
2. Write the profile log-likelihood $\ell_p(\mu_1)=\max_{p,\mu_2,\sigma_1,\sigma_2}\ell$ (fix $\mu_1$ and call `optim()` over the other four parameters, starting from the full MLE), and find the 95% profile-likelihood interval $\{\mu_1:\ell_p(\mu_1)\ge\ell(\hat{\boldsymbol\theta})-1.92\}$ with `uniroot()`.
3. Compare the two intervals. Is the log-likelihood close to quadratic in $\mu_1$?

---

## Task 3 (optional) — The EM algorithm for the same mixture

This uses the optional EM frames of Session 3 and `03-maximum-likelihood/extras/04-em-algorithm/`. It is not examined.

1. Implement EM for the two-component normal mixture on the waiting times, starting from $p=0.5$, $\mu=(55,80)$, $\sigma=(5,5)$.
2. Monitor the observed-data log-likelihood $\sum_i\log\{p\phi(w_i;\mu_1,\sigma_1)+(1-p)\phi(w_i;\mu_2,\sigma_2)\}$. Compute it **before** you normalise the responsibilities. Stop when it increases by less than $10^{-8}$.
3. How many iterations does EM need? Do you reach the same estimates and log-likelihood as `optim()`? Does the log-likelihood ever decrease?
