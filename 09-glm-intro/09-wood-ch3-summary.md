# Wood (2017), Ch. 3 — Generalized linear models

**Session(s):** 9, 10 (also useful for 11 and 12)  ·  **Source:** Wood, *Generalized Additive Models: An Introduction with R*, Chapman & Hall/CRC. Summarised from the 1st edition (2006), Ch. 2, pp. 59–118; in the 2nd edition (2017) this is Ch. 3. The chapter's GLMM material is summarised separately for Session 17.
**Reading time:** ~2 h for the whole chapter (~60 min for the core parts)  ·  **Level:** core

## Why read it

How do we keep the machinery of linear models when the response is a count, a proportion or a positive skewed quantity? The chapter gives the theory of GLMs (exponential family, IRLS, deviance, residuals, quasi-likelihood) and then a set of worked R analyses. It is the main text for Block 3, and its IRLS algorithm is the one later extended to fit GAMs (Sessions 23–24).

## The big idea

A GLM links the mean to the linear predictor, $g(\mu_i)=X_i\beta$, and takes the response from an exponential-family distribution. The likelihood equations can be solved by repeatedly fitting a *weighted* linear model to a working response, which is IRLS. Inference uses large-sample likelihood theory, so it is approximate rather than exact as in linear models.

## Section by section

(Topics follow the book's section titles; section numbers differ between editions.)

**Introduction.** Two short motivating models: early epidemic growth (Poisson counts with a log link) and a predator's prey capture rate that levels off (Gamma response with a reciprocal link). In both, a non-linear mean becomes linear in the parameters on the link scale.

**The theory of GLMs.**

- *Exponential family:* the two score identities give the mean and variance in terms of $b(\theta)$. The dispersion is written $a(\phi)=\phi/\omega$ with known prior weights $\omega$.
- *Fitting:* the likelihood equations look like those of non-linear weighted least squares with fixed weights. A one-step-per-iteration version gives IRLS with pseudodata $z$ and weights $W$. A common starting value is $\mu=y$ (adjusted where $g(y)$ is infinite).
- *IRLS objective:* at convergence, the working weighted sum of squares is a quadratic approximation to the log-likelihood, because the derivatives and the expected Hessian match.
- *AIC:* a bias argument leads to AIC $=2[-\ell+p]$, with $p+1$ if $\phi$ is estimated.
- *Comparing models:* large-sample normality of $\hat\beta$; likelihood-ratio tests through deviance differences. Treating the residual deviance itself as $\chi^2_{n-p}$ is questioned in general and breaks down for binary data. When $\phi$ is unknown, an $F$ ratio of deviances is used.
- *Scale estimation:* by deviance or Pearson statistic.
- *Canonical links:* they make $X^\top y=X^\top\hat\mu$, so totals are preserved and, with an intercept, residuals sum to zero.
- *Residuals:* Pearson and deviance residuals.
- *Quasi-likelihood:* only the mean–variance relation is specified, and the estimating equations are the same as before. Its main uses are overdispersed counts and variance functions with no matching distribution.

**Geometry of GLMs.** The flat model space of linear models becomes a curved "model manifold", and the data points that give the same fit lie on lines that are not orthogonal to it. One IRLS step recentres and rescales the problem so that it is locally a linear least-squares projection. A small example shows that IRLS can converge to different estimates from different starting values when the model fits very badly.

**GLMs with R.**

- *Binomial:* heart-attack proportions against creatine kinase, using `cbind(successes, failures)`. The residual deviance and residual plots reject a straight line on the logit scale, a cubic fits, and `anova(..., test = "Chisq")` confirms it.
- *Poisson:* yearly AIDS cases. A quadratic in time is needed; a Wald interval is computed for the growth rate; predictions are made on the link scale and back-transformed.
- *Log-linear model:* a 2×2 table (gender by belief) shows how a Poisson GLM tests independence and why fitted margins match the observed ones.
- *Sole eggs:* a demographic model with an offset, a quasi-likelihood family with variance proportional to the mean, and backward elimination with $F$ tests. The polynomial surface becomes unwieldy, which motivates GAMs.

**Likelihood.** General theory used above: invariance, the expected log-likelihood results, consistency, the large-sample distribution of the MLE, the generalised likelihood ratio test and its $\chi^2$ derivation (with a remark on why it is preferred to Wald), a Kullback–Leibler derivation of AIC, and the same results for quasi-likelihood. In the 2nd edition this material may sit elsewhere; check the table of contents.

## Key results to know

1. $f(y;\theta,\phi)=\exp\{[y\theta-b(\theta)]/a(\phi)+c(y,\phi)\}$, $\mu=b'(\theta)$, $\mathrm{Var}(Y)=b''(\theta)a(\phi)=V(\mu)\phi$. With $\omega=1$, Wood's $V(\mu)=b''(\theta)/\omega$ is the course's $V(\mu)=b''(\theta)$.
2. Likelihood equations: $\sum_i \dfrac{y_i-\mu_i}{V(\mu_i)}\dfrac{\partial\mu_i}{\partial\beta_j}=0$ for all $j$.
3. IRLS: $z_i=g'(\mu_i)(y_i-\mu_i)+\eta_i$, $W_{ii}=1/\{V(\mu_i)g'(\mu_i)^2\}$, $\beta^{\text{new}}=(X^\top WX)^{-1}X^\top Wz$.
4. $\hat\beta\,\dot\sim\,N\big(\beta,(X^\top WX)^{-1}\phi\big)$. Wood writes $I$ for the information $X^\top WX/\phi$; this is the course's *expected* information $\mathcal I$, and in the course $I$ means the observed information.
5. Deviance $D=2\phi[\ell(\hat\beta_{\max})-\ell(\hat\beta)]$, scaled deviance $D^*=D/\phi$. For nested models, $D_0^*-D_1^*\,\dot\sim\,\chi^2_{p_1-p_0}$. With $\phi$ unknown, $F=\dfrac{(D_0-D_1)/(p_1-p_0)}{D_1/(n-p_1)}\,\dot\sim\,F_{p_1-p_0,\,n-p_1}$.
6. $\hat\phi=X^2/(n-p)$ with $X^2=\sum_i(y_i-\hat\mu_i)^2/V(\hat\mu_i)$; also $X^2=\lVert\sqrt W(z-X\hat\beta)\rVert^2$.
7. Canonical link: $\theta_i=X_i\beta$, hence $X^\top y=X^\top\hat\mu$.
8. Quasi-likelihood: $q_i(\mu_i)=\int_{y_i}^{\mu_i}\dfrac{y_i-t}{\phi V(t)}\,dt$.

## Connect to class

- **Session 9** builds the exponential family and links as Wood does, but on `birthwt` (odds ratios) and `ships` (rate ratios with an offset). Thresholds, ROC curves and test-set evaluation are not in the book.
- **Session 10** (IRLS by hand, deviance tests, Pearson $\hat\phi$, quasi-Poisson) follows this chapter closely. The slides add three things the 1st-edition chapter does not have: that IRLS equals Newton–Raphson only for canonical links, randomized quantile residuals, and negative binomial and zero-inflated models. For binary residuals, Wood instead suggests simulation envelopes in an exercise.
- **Session 11 (Lab 03):** compare the `glm()` output you read there with the heart-attack and AIDS analyses here.
- **Session 12:** the chapter exercises on exponential-family form, IRLS and quasi-likelihood match the midterm style.

## Read carefully / safe to skim

**Read carefully:** the exponential family, fitting GLMs (the IRLS derivation), the large-sample distribution of $\hat\beta$, model comparison and deviance, $\hat\phi$ and Pearson, canonical links, residuals, quasi-likelihood, and the binomial and Poisson R examples.
**Safe to skim:** geometry of GLMs, the sole-egg example (read its conclusion), and the likelihood section, which repeats Pawitan (Sessions 3–4) in different notation.

## Check yourself

1. Write the Poisson pmf in exponential-family form and give $\theta$, $b(\theta)$, $V(\mu)$ and the canonical link.
2. Derive the IRLS weight and working response for a binomial proportion with a logit link.
3. Why is the residual deviance not a goodness-of-fit test for binary data, while a deviance *difference* between nested models is still usable?
4. Explain in words what quasi-likelihood changes and what it leaves unchanged, compared with a Poisson GLM.
5. Show that, with the canonical link and an intercept, the response-scale residuals of a Poisson GLM sum to zero.
