# Wood (2017), Ch. 3, GLMM sections — Generalized linear mixed models

**Session(s):** 17 (also useful for 18)  ·  **Source:** Wood, *Generalized Additive Models: An Introduction with R*, Chapman & Hall/CRC. Summarised from the 1st edition (2006), Sec. 6.4–6.5, pp. 303–308; in the 2nd edition (2017) this is Ch. 3, GLMM sections.
**Reading time:** ~25 min  ·  **Level:** core

## Why read it

What happens when grouped data are counts or proportions? The GLMM puts random effects inside a GLM. Its likelihood is an integral with no closed form, so every fitting method is an approximation. This short section shows where one standard approximation, penalized quasi-likelihood (PQL), comes from, and how it is used in R. It connects Session 16 (LMMs) with Sessions 9–10 (IRLS).

## The big idea

The model is specified *conditionally* on the random effects: given $b$, the response follows a GLM. To get the likelihood you must integrate $b$ out. Wood replaces the integrand by a quadratic approximation (a Laplace-type step). He then approximates the GLM log-likelihood by the IRLS working model, which turns each step into a *weighted linear mixed model* for the working response. Iterating LMM fits to convergence is PQL.

## Section by section

(Topics follow the book's section titles; section numbers differ between editions.)

**Generalized linear mixed models.**

- *Model:* $g(\mu_i^b)=X_i\beta+Z_ib$, where $\mu^b=\mathrm{E}(y\mid b)$, $b\sim N(0,\psi_\theta)$, and the $y_i$ are independent given $b$.
- *Likelihood:* the joint density of $(y,b)$ is written down and $b$ is integrated out. Numerical integration becomes impractical as the dimension of $b$ grows.
- *Approximation:* expand the penalised log-likelihood $\ell(\beta,b)-\tfrac12 b^\top\psi^{-1}b$ quadratically about its maximiser. Because the integrand falls off quickly away from $\hat b$, the result is a reasonable approximation of Laplace type. Using the IRLS working model in place of $\ell(\beta,b)$, the approximate likelihood is exactly that of a linear mixed model for $z$ with residual covariance $W^{-1}\phi$.
- *Recipe:* start from a GLM fit with $b=0$; form $z$ and $W$; fit the working LMM to update $\beta$, $\theta$, $\phi$ and $b$; repeat until convergence.
- *Caveats:* the estimates are only approximately ML even in large samples. Their quality depends on the Laplace step and on $W$ changing slowly. Likelihood-based tests and AIC are not well founded for the approximate likelihood. Wood suggests the AIC of the working LMM only as a rough guide.

**GLMMs with R.** `MASS::glmmPQL()` is described: it has the syntax of `lme()` plus a `family`, accepts offsets, calls `lme()` repeatedly, and returns the working `lme` fit. The example revisits the sole-egg survey from the GLM chapter. The four egg stages at a sampling station come from the same net haul, so they are not independent. Fitting an `lme` with a station random effect to the GLM deviance residuals, and comparing it with an i.i.d. model, gives strong evidence of a station effect. The GLMM multiplies each station's mean by a log-normal factor $e^{b_k}$, i.e. it adds a station random intercept on the log scale. Terms are dropped one at a time with Wald-type tests, because a likelihood-ratio test is not available. Residual plots are compared with those of the GLM, and `intervals()` shows that the station SD is larger than the working residual SD. The predicted spawning maps are less peaked than under the GLM.

## Key results to know

1. GLMM: $g\{\mathrm{E}(y_i\mid b)\}=X_i\beta+Z_ib$, $b\sim N(0,G)$; $y_i\mid b$ independent from an exponential family. Wood writes $\psi$ for $G$ and $\mu^b$ for the conditional mean.
2. Likelihood: $L(\beta,\theta,\phi)\propto|G|^{-1/2}\int\exp\{\ell(\beta,b)-\tfrac12 b^\top G^{-1}b\}\,db$, where $\ell(\beta,b)$ is the log-likelihood of the GLM that treats $b$ as fixed.
3. Working quantities (as in IRLS, now with $b$): $z_i=g'(\mu_i^b)(y_i-\mu_i^b)+X_i\beta+Z_ib$, $W_{ii}=1/\{V(\mu_i^b)g'(\mu_i^b)^2\}$.
4. Each PQL step fits $z=X\beta+Zb+\varepsilon$, $b\sim N(0,G)$, $\varepsilon\sim N(0,W^{-1}\phi)$.
5. PQL estimates are approximate; there is no exact maximised likelihood to use in LR tests.

## Connect to class

- **Session 17** presents three ways to approximate the integral: Laplace (`glmer`, the default), adaptive Gauss–Hermite quadrature (`nAGQ`), and PQL. The 1st edition covers only PQL and uses the Laplace idea just to motivate it; `lme4::glmer()` does not appear. According to the course reading list, the 2nd edition also uses `glmer`. Read the slides "The Laplace approximation" and "Laplace vs quadrature vs PQL" alongside this section.
- **Not in the book:** conditional vs marginal effects and the attenuation factor, both central in Session 17. The sole-egg station effect is close in spirit to the slides' observation-level random effect: a log-normal multiplier that soaks up extra-Poisson variation.
- **Session 18 (Lab 04)** uses `glmer()` on `cbpp`. `exp(fixef())` is a *conditional* odds ratio, as the GLMM is specified given $b$.
- The working-LMM view explains why Session 27's `gamm()` uses PQL for non-Gaussian data while `gamm4()` uses Laplace through `lme4`.

## Read carefully / safe to skim

**Read carefully:** the model definition, the likelihood as an integral, and the derivation that turns the approximation into a weighted LMM; also the paragraph on what cannot be done with the approximate likelihood.
**Safe to skim:** the long `glmmPQL` call and coefficient table (the polynomial terms are only there to describe the spatial surface) and the plotting code.

## Check yourself

1. Write the likelihood of a Poisson GLMM with one random intercept per group as an integral. Why is there no closed form?
2. Starting from IRLS for a GLM, explain in your own words why each PQL step is a linear mixed model fit. What plays the role of the response, and what plays the role of the residual covariance?
3. Why does Wood use Wald tests rather than likelihood-ratio tests to simplify the sole-egg GLMM?
4. The station effect multiplies the expected count by $e^{b_k}$ with $b_k\sim N(0,\sigma_b^2)$. Show that this inflates the marginal variance of a count compared with a Poisson model.
5. In a logistic GLMM, is $e^{\beta_1}$ a population-averaged or a subject-specific odds ratio? Explain.
