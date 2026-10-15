# Session 9 — Exercises

**Topic:** Exponential family, links, logistic and Poisson regression
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Notation: $f(y;\theta,\phi)=\exp\{[y\theta-b(\theta)]/a(\phi)+c(y,\phi)\}$, $\mu=b'(\theta)$, $V(\mu)=b''(\theta)$, $g(\mu)=\eta=X\beta$.

## Exercise 1 — Geometric distribution (derivation)

Let $P(Y=y)=p(1-p)^y$, $y=0,1,2,\dots$, $0<p<1$.

(a) Write it in exponential-family form. Identify $\theta$, $b(\theta)$, $a(\phi)$ and $c(y,\phi)$.
(b) Use $b$ to find $\mathrm{E}[Y]$ and $\mathrm{Var}(Y)$, and show that $V(\mu)=\mu(1+\mu)$.
(c) What is the canonical link? Is it a sensible link for a count model?

## Exercise 2 — Cumulants from $b(\theta)$ (short proof)

(a) Show that the moment generating function of an exponential-family variable is
$M_Y(t)=\exp\{[b(\theta+t\,a(\phi))-b(\theta)]/a(\phi)\}$.
(b) Deduce that the cumulant generating function is $K_Y(t)=[b(\theta+t\,a(\phi))-b(\theta)]/a(\phi)$, and that the $r$-th cumulant is $\kappa_r=b^{(r)}(\theta)\,a(\phi)^{r-1}$.
(c) Use (b) to find the skewness $\kappa_3/\kappa_2^{3/2}$ of the Poisson distribution with mean $\mu$.

## Exercise 3 — Canonical links and sufficiency

(a) Show that with the canonical link the log-likelihood of a GLM depends on the data only through $X^\top y$ (and $\phi$, $c(y,\phi)$).
(b) For a Poisson log-linear model with an intercept, prove that $\sum_i\hat\mu_i=\sum_i y_i$.
(c) For a logistic model with a binary covariate $x\in\{0,1\}$ and an intercept, show that the fitted probability in each group equals the observed proportion in that group.

## Exercise 4 — Reading logistic output by hand

Use the `birthwt` model of the slides (estimates below).

| term | estimate | std. error |
|---|---:|---:|
| (Intercept) | 0.63691 | 1.23028 |
| age | −0.03775 | 0.03781 |
| lwt | −0.01491 | 0.00704 |
| raceblack | 1.21274 | 0.53248 |
| raceother | 0.80412 | 0.44843 |
| smoke | 0.84640 | 0.40806 |
| ptd | 1.22175 | 0.46301 |
| ht | 1.83869 | 0.70324 |
| ui | 0.71113 | 0.46311 |

(a) Compute the odds ratio for hypertension and a 95% Wald interval for it. The profile-likelihood interval is (1.64, 27.26). Why do the two differ, and which do you prefer?
(b) Compute the estimated probability of low birth weight for a 30-year-old black mother weighing 140 lb who smokes and has hypertension, with no premature labour and no uterine irritability.
(c) Estimate the odds ratio comparing black mothers with mothers of "other" race. The estimated covariance of the two race coefficients is 0.0928; compute its standard error.

## Exercise 5 — The complementary log-log link (derivation)

Suppose a plot is infested ($Y=1$) when at least one insect lands on it, and the number of insects $N$ is Poisson with mean $\lambda=\exp(x^\top\beta)$.

(a) Show that $P(Y=1)=1-\exp\{-\exp(x^\top\beta)\}$, i.e. a binary GLM with the cloglog link.
(b) Interpret $e^{\beta_j}$ in this model.
(c) If the plots have different areas $A_i$ and $\lambda_i=A_i\exp(x_i^\top\beta)$, how does the area enter the model?

## Exercise 6 — Offsets in the ships data (R)

(a) Fit the ships model of the slides with `offset(log(service))`. Compute the rate ratio comparing ships built in 1970–74 with ships built in 1965–69.
(b) Refit with `log(service)` as a free covariate. Test $H_0$: coefficient $=1$ with a Wald test and with a likelihood-ratio test.
(c) Explain in two sentences what an offset assumes about exposure.

## Exercise 7 — Thresholds and costs

A hospital uses a calibrated logistic model to decide whether a patient receives an extra test. A missed case costs 9 times as much as an unnecessary test.

(a) Derive the threshold that minimizes expected cost, and compute it.
(b) The prevalence in the hospital is 5%. Does the threshold change? Explain.
(c) A data scientist trained the model on a resampled set with 50% cases (true prevalence 5%). For a patient the model returns 0.6. What is the calibrated probability? Hint: resampling cases multiplies all odds by the same factor.
(d) Explain why choosing the cut-off that maximizes sensitivity + specificity on the test set gives an optimistic estimate of performance.

## Exercise 8 — Links compared (R)

Refit the `birthwt` model with the probit and the cloglog links.

(a) Compare the AICs of the three fits.
(b) Compute the ratio of logit to probit coefficients. Explain why it is roughly constant and close to 1.6–1.8.
(c) What is the largest absolute difference between the fitted probabilities of the logit and probit fits? What does this tell you about the choice of link for these data?
