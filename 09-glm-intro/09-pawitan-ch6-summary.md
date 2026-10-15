# Pawitan (2001), Ch. 6 — Modelling relationships: regression models

**Session(s):** 9 (also useful for 5, 10, 11 and 12)  ·  **Source:** Pawitan, *In All Likelihood: Statistical Modelling and Inference Using Likelihood*, OUP, Ch. 6, pp. 149–192 (text pp. 149–187, exercises pp. 187–192)
**Reading time:** ~100 min (~45 min for Sections 6.2, 6.3 and 6.5)  ·  **Level:** core for 6.2, 6.3 and 6.5 (Session 9) and 6.6–6.7 (Session 10); optional for 6.1 (Session 5) and 6.4, 6.8–6.9

## Why read it
Chapter 4 built one-sample models; here each of them becomes a regression model by letting the mean depend on covariates. This is the likelihood view of everything in Sessions 9–12: logistic and Poisson regression, the GLM as "exponential family plus link", deviance, and the IWLS algorithm. Section 6.1 is also a short likelihood treatment of the normal linear model of Session 5.

## The big idea
Drop the "identically distributed" part of iid: $y_i$ are independent with a mean that depends on $x_i$. Once you write down the distribution of $y_i$ and a model for its mean, the likelihood contains the whole inference problem; the rest is computation. For non-normal responses the mean is linked to $x_i^\top\beta$ through a link function, the variance follows from the family, and a dispersion parameter makes the mean–variance relationship flexible. Standard errors come from the observed information, and profile likelihoods (or profile deviances) show when the Wald quadratic approximation can be trusted.

## Section by section

**Introduction (p. 149).** Forbes' 19th-century experiment relating the boiling point of water to barometric pressure, and so to altitude: a rare example of a near-perfect physical law behind a regression line.

**6.1 Normal linear models (p. 150).** Likelihood for $y_i\sim N(x_i^\top\beta,\sigma^2)$, the MLEs, the observed information for $\beta$, and the profile likelihood of $\beta$ with $\sigma^2$ maximised out. Least squares gives the same numbers, but the likelihood approach starts from a distributional assumption, so inference comes for free. Example: cancer mortality vs exposure to radioactive waste in nine Oregon counties (Hanford), with a non-normal residual plot. Nonlinear regression is mentioned briefly.

**6.2 Logistic regression models (p. 154).** Why a linear model for a probability is unnatural; probit vs logit; the logit makes the effect of a covariate multiplicative on the odds. Surgical mortality vs age (40 patients): likelihood contours, profile likelihood of the age effect, a good quadratic approximation. Age is centred to reduce the correlation between the estimates. Grouped (binomial) data: a 2×2 factorial seed-germination experiment with a significant interaction.

**6.3 Poisson regression models (p. 157).** Insurance claims vs age with a log-linear mean. Accidents before and after traffic-control measures at eight sites, with different observation periods handled by an **offset** $\log(\text{years})$; the treatment coefficient reproduces the simple ratio of rates.

**6.4 Nonnormal continuous regression (p. 160).** Plant yield vs planting density. A normal model for 1/yield ignores the growing variance; an exponential model with inverse link fixes the mean–variance pattern but forces $\mathrm{Var}(y)=\mu^2$, which here is far too large, so the standard errors explode. A check of $\mathrm{Var}\{(y-\mu)/\mu\}$ exposes the problem.

**6.5 Exponential family regression models (p. 163).** The GLM: choose the family (the function $b(\theta)$, hence the variance function) and a link with $g(\mu_i)=x_i^\top\beta$. The canonical link makes $\theta_i=x_i^\top\beta$; it is convenient, but nothing forces it. The plant data refitted as a gamma GLM: same estimates as the exponential model, standard errors scaled by $\sqrt\phi$ and now sensible.

**6.6 Deviance in GLM (p. 166).** Deviance as twice the log-likelihood ratio of the saturated model to the fitted model; null and residual deviance; deviance residuals; normal, binomial and Poisson deviances. Differences of deviances compare nested models (analysis of deviance, χ² with $q$ df when $\phi=1$); with unknown $\phi$, use the scaled deviance (and an $F$ test in the normal case). The deviance measures lack of fit only when counts are large, never for binary data. $\phi$ is estimated by the mean deviance (with an $n-p$ divisor) or by Pearson's statistic. A **profile deviance** plot, built by refitting with the parameter of interest fixed as an offset, gives likelihood intervals from any GLM software. A survey example with a zero cell shows a huge standard error and a useless Wald test while the deviance test is clearly significant.

**6.7 Iterative weighted least squares (p. 174).** Newton–Raphson on the score equation, rewritten as repeated weighted least squares on a working response. With the canonical link the observed and expected information coincide; with other links IWLS is Fisher scoring, and the expected information is usually used for standard errors. The Poisson log-linear case is written out step by step.

**6.8 Box–Cox transformation family (p. 178).** Regression after a Box–Cox transform (sulphur dioxide vs number of factories in 41 US cities; the log transform is chosen). A short but important subsection contrasts a **parameter-transform** model (GLM: transform the mean) with an **observation-transform** model (transform $y$).

**6.9 Location-scale regression models (p. 181).** Stack-loss data: Cauchy errors give a more precise slope than normal errors when residuals are heavy-tailed; AIC chooses between them; a bimodal profile likelihood makes the reported standard error meaningless.

## Key results to know
1. Normal linear model: $\hat\beta=(X^\top X)^{-1}X^\top y$, $\hat\sigma^2_{\text{ML}}=\mathrm{RSS}/n$, observed information $I(\hat\beta)=X^\top X/\sigma^2$. The $n-p$ divisor is justified in Pawitan Example 10.11.
2. Logistic regression: $\ell(\beta)=\sum_i\{y_i\eta_i-\log(1+e^{\eta_i})\}$, $\eta_i=x_i^\top\beta$; $e^{\beta_j}$ is an odds ratio.
3. Poisson rate model: $\log\mu_i=\log t_i+x_i^\top\beta$; the offset has coefficient 1, $e^{\beta_j}$ is a rate ratio.
4. GLM: $g(\mu_i)=x_i^\top\beta$, $\mathrm{Var}(y_i)=a(\phi)V(\mu_i)$; canonical link when $\theta_i=x_i^\top\beta$. Pawitan writes the link as $h(\cdot)$ and $A(\theta)$ for $b(\theta)$.
5. Deviance: $D(y,\hat\mu)=2\{\ell(y;y)-\ell(\hat\mu;y)\}$. Poisson: $2\sum_i\{y_i\log(y_i/\hat\mu_i)-(y_i-\hat\mu_i)\}$; normal: RSS.
6. Nested models A ⊂ B: $\{D_A-D_B\}/\phi\ \dot\sim\ \chi^2_q$.
7. $\hat\phi=D/(n-p)$ or $\hat\phi=\frac1{n-p}\sum_i(y_i-\hat\mu_i)^2/V(\hat\mu_i)$.
8. IWLS: $z_i=\eta_i+(y_i-\mu_i)g'(\mu_i)$, $W=\mathrm{diag}\{1/[g'(\mu_i)^2V(\mu_i)]\}$, $\beta^{\text{new}}=(X^\top WX)^{-1}X^\top Wz$; $\phi$ cancels; $\widehat{\mathrm{Var}}(\hat\beta)=\phi(X^\top WX)^{-1}$. Pawitan calls $z$ the working vector $Y$ and works with its variance $\Sigma$ (so $W=\Sigma^{-1}$ up to $\phi$).

## Connect to class
- Deck 09: "Logistic regression and odds ratios" and "Poisson regression for rates: the offset"; `09-logistic-birthwt.Rmd` and `09-poisson-ships.Rmd` do in R what Pawitan does with likelihood plots. The deck's point that a GLM transforms the mean, not the response, is Pawitan's parameter-transform vs observation-transform distinction (end of 6.8).
- Session 10 (deviance, IWLS, residuals, overdispersion) is Sections 6.6–6.7; Lab 03 fits the same kinds of models with `glm()`.
- Session 5: 6.1 is the likelihood version of least squares (deck 05, "Least squares = maximum likelihood under normality").
- Not in Pawitan: classification thresholds and cost-optimal cut-offs (deck 09, last section).

## Read carefully / safe to skim
- **Read carefully:** 6.2, 6.3, 6.5 (Session 9); 6.6 including the zero-cell example, and 6.7 (Session 10).
- **Skim:** the data tables, 6.4 (but note the moral about rigid mean–variance relations), 6.8 except the "transform the mean or the observation?" subsection, 6.9.

## Check yourself
1. Derive the score equations of a Poisson log-linear model with an offset and show that, with an intercept, $\sum_i\hat\mu_i=\sum_i y_i$.
2. In the before/after accident example, why does the treatment coefficient reproduce the ratio of the two pooled rates exactly?
3. Why is the residual deviance of a logistic regression on 0/1 data useless as a goodness-of-fit statistic, while differences of deviances are fine?
4. Explain why a Wald test can fail when one category has no events, and how a profile deviance avoids the problem.
5. Starting from Newton–Raphson for a GLM with canonical link, show that one step is a weighted least squares fit of $z$ on $X$.
