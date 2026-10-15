# Session 12 — Exercises

**Topic:** Distribution and link choice, likelihoods, interpretation, deviance tests, diagnostics, an applied problem
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Problems 1–6 are to be solved by hand (as in the midterm). Problem 7 uses R.
Useful quantiles: $z_{0.975}=1.96$; $\chi^2_{1;0.95}=3.84$, $\chi^2_{2;0.95}=5.99$, $\chi^2_{3;0.95}=7.81$, $\chi^2_{9;0.95}=16.92$.

## Problem 1 — Distribution and link

For each response give the random component, the link, and any offset or weights, and justify your choice in one line.

(a) Number of claims per car policy in a year; policies were in force for different numbers of months.
(b) Number of seeds (out of 50 per tray) that germinate, as a function of soil temperature.
(c) Time to repair a machine (hours): positive, right-skewed, standard deviation roughly proportional to the mean.
(d) Whether a loan defaults within a year.
(e) Proportion of a field's area covered by weeds, measured from photographs.
(f) Number of goals a football team scores in a match.

## Problem 2 — Likelihood of grouped binary data

In the budworm experiment (Venables and Ripley, 2002), batches of $m_i=20$ moths of each sex were exposed to six doses of a pyrethroid. In cell $i$, $y_i$ moths die; $x_i=\log_2(\text{dose}_i)$ and $s_i=1$ for males. Model: $y_i\sim\mathrm{Bin}(m_i,\mu_i)$, $\mathrm{logit}\,\mu_i=\beta_0+\beta_1s_i+\beta_2x_i$.

(a) Write the log-likelihood $\ell(\beta)$ and put one binomial term in exponential-family form ($\theta$, $b(\theta)$, $a(\phi)$).
(b) Derive the score $S(\beta)=X^\top(y-m\circ\mu)$, where $\circ$ is the elementwise product.
(c) Derive the Fisher information and show that it equals the observed information.
(d) Give the IRLS weights and the working response for the counts $y_i$.

## Problem 3 — Interpreting a logistic fit

```
glm(cbind(dead, alive) ~ sex + ldose, family = binomial, data = bud)
            Estimate Std. Error z value Pr(>|z|)
(Intercept)  -3.4732     0.4685  -7.413 1.23e-13
sexM          1.1007     0.3558   3.093  0.00198
ldose         1.0642     0.1311   8.119 4.70e-16
Cov(Intercept, ldose) = -0.05251   Cov(sexM, ldose) = 0.01299   Cov(Intercept, sexM) = -0.09875
```

The dose in µg is $2^{\text{ldose}}$.

(a) Interpret $e^{1.0642}$ and $e^{1.1007}$ in words. What does one unit of `ldose` mean in µg?
(b) Compute the dose that kills half the females (LD50), in µg. Same for males.
(c) Use the delta method to find a standard error for the female LD50 on the $\log_2$ scale, and a 95% interval for the female LD50 in µg.

## Problem 4 — Deviance tests from output

| Model | Terms | Residual deviance | Residual df | AIC |
|---|---|---:|---:|---:|
| $M_0$ | `1` | 124.88 | 11 | 156.99 |
| $M_1$ | `ldose` | 16.98 | 10 | 51.09 |
| $M_2$ | `sex + ldose` | 6.76 | 9 | 42.87 |
| $M_3$ | `sex * ldose` | 4.99 | 8 | 43.10 |

(a) Carry out the LR tests $M_0$ vs $M_1$, $M_1$ vs $M_2$, $M_2$ vs $M_3$. Which model do you choose?
(b) Check that the AIC differences agree with the deviance differences. Why is AIC $\ne D+2p$ here?
(c) Is there evidence of lack of fit for $M_2$? Why may you use the deviance as a goodness-of-fit statistic here but not for the 0/1 `birthwt` data?
(d) What would "$M_3$ is needed" mean for the interpretation in Problem 3?

## Problem 5 — Rate ratios

`faraway::esdcomp`: complaints about 44 emergency-room doctors, with the number of patient visits as exposure.

```
glm(complaints ~ residency + gender + revenue + hours + offset(log(visits)),
    family = poisson, data = esdcomp)
              Estimate Std. Error z value Pr(>|z|)
(Intercept) -8.1202460  0.8502806  -9.550   <2e-16
residencyY  -0.2090058  0.2011520  -1.039   0.2988
genderM      0.1954338  0.2181525   0.896   0.3703
revenue      0.0015761  0.0028294   0.557   0.5775
hours        0.0007019  0.0003505   2.002   0.0452
    Null deviance: 63.435  on 43  degrees of freedom
Residual deviance: 54.518  on 39  degrees of freedom
```

(a) Interpret the `hours` coefficient as a rate ratio for 100 extra hours, with a 95% Wald interval. Interpret `residencyY`.
(b) Compute the expected number of complaints for a male doctor in residency training, with hourly revenue 250, 1500 hours and 2500 visits.
(c) The model `complaints ~ hours + offset(log(visits))` has residual deviance 57.35 on 42 df. Test the other three terms jointly.

## Problem 6 — Residuals and dispersion

Same model. Pearson $X^2=53.42$. Doctor 1 had 2014 visits and $y_1=2$ complaints; $\hat\mu_1=1.816$.

(a) Estimate $\phi$. By what factor would quasi-Poisson standard errors change? Is `hours` still significant at 5%?
(b) Compute the Pearson and deviance residuals of doctor 1.
(c) Between which two values does doctor 1's randomized quantile residual lie? Under $\hat\mu_1$, $P(Y\le1)=0.458$ and $P(Y\le2)=0.726$.
(d) The Cameron–Trivedi regression of $\{(y_i-\hat\mu_i)^2-y_i\}/\hat\mu_i$ on $\hat\mu_i$ (no intercept) gives $\hat\alpha=0.081$, $t=1.96$ on 43 df (two-sided $p=0.056$). State the hypotheses and conclude. Would you use quasi-Poisson or a negative binomial?
(e) Why is a plot of Pearson residuals against $\hat\mu$ hard to read for these data?

## Problem 7 — Applied problem (R)

`faraway::gala`: number of plant `Species` on 30 Galápagos islands, with `Area` (km²), `Elevation` (m), distance to the `Nearest` island and to Santa Cruz (`Scruz`, km), and the area of the `Adjacent` island (km²).

(a) Fit a Poisson GLM of `Species` on the logs of the five covariates (use `log(Scruz + 0.1)`). Why logs?
(b) Check for overdispersion with $\hat\phi$ and both Cameron–Trivedi regressions (quadratic and linear).
(c) Fit quasi-Poisson and negative binomial models; compare standard errors and AIC.
(d) Simplify the NB model with an LR test. Interpret the effect of doubling the island area, with a 95% interval.
(e) Check the randomized quantile residuals of your final model and write a three-sentence conclusion.
