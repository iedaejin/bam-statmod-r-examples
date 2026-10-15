# Wood (2017), Ch. 6–7, GAMM sections — Generalized additive mixed models

**Session(s):** 27  ·  **Source:** Wood, *Generalized Additive Models: An Introduction with R*, Chapman & Hall/CRC. Summarised from the 1st edition (2006), Sec. 6.6–6.7, pp. 309–317, read together with two earlier 1st-edition sections: the structure of the Bayesian prior (Sec. 4.8.2) and the link between mixed models and penalized regression (Sec. 6.2.6). In the 2nd edition (2017) this is Ch. 6–7, GAMM sections.
**Reading time:** ~40 min  ·  **Level:** core

## Why read it

How can a smooth curve and grouped random effects sit in the same model, and why does REML for a mixed model choose a smoothing parameter? This short part of the book shows that every quadratically penalized smooth *is* a mixed-model component. A GAMM can therefore be fitted with standard LMM/GLMM software, and `mgcv::gamm()` does exactly that. It ties Sessions 15–17 (mixed models) to Sessions 21–25 (smoothing).

## The big idea

The penalty $\lambda\beta^\top S\beta$ acts like a Gaussian prior on the wiggly part of $\beta$, with variance proportional to $1/\lambda$. The part with zero penalty, which a second-order penalty leaves as a straight line, behaves like fixed effects. After reparameterising, the smooth is $X_F\beta_F+Zb$ with independent random effects $b$, and its smoothing parameter becomes a variance ratio estimated by (RE)ML or PQL.

## Section by section

(Topics follow the book's section titles; section numbers differ between editions.)

**Background from earlier sections.**

- *Prior structure (GAM theory chapter):* the improper prior implied by the penalty is a multivariate normal on the penalized directions times a flat prior on the null space.
- *Link with penalized regression (LMM chapter):* given the variance parameters, $\hat\beta$ and the predicted $b$ minimise a penalized least-squares criterion (see the [LMM summary](../15-linear-mixed-models/15-wood-ch2-summary.md)).

**Generalized additive mixed models.** An additive mixed model has the form $y_i=X_i\beta+f_1(x_{1i})+f_2(x_{2i},x_{3i})+\dots+Z_ib+\varepsilon_i$, possibly with correlated errors. Unlike the step from GLMs to GAMs, no new estimation theory is needed: smooths become variance components.

**Smooths as mixed-model components.**

- *Single penalty:* eigen-decompose $S=UDU^\top$. The columns with zero eigenvalue give the unpenalized fixed part $X_F=XU_F$. The rest give the random part, rescaled so that the random effects are independent with a common variance proportional to $1/\lambda$.
- *Several smooths:* their blocks are stacked. Centring constraints are absorbed into each basis first.
- *Tensor products:* with several penalties, a common variance is no longer possible. The random effects have precision $\sum_i\lambda_i\tilde S_i$, and `mgcv` provides a special `nlme` covariance class (`pdTens`) for it.

**Inference with GAMMs.** Put the fixed effects and the smooths' random coefficients into one $\beta$, and treat the remaining random effects and the error covariance as $V$. The Bayesian argument of the GAM-theory chapter then gives a posterior covariance and edf for each coefficient. For additive mixed models (Gaussian), standard LMM inference applies, so AIC and likelihood-ratio comparisons are routine. For non-Gaussian GAMMs, model comparison is still an open problem.

**GAMMs with R.**

- *What `gamm()` does:* it reparameterises the smooths, calls `lme()` (Gaussian) or `glmmPQL()` (other families), and returns two objects: `$lme`, the fitted mixed model, and `$gam`, used for plots, prediction and summaries. `random` must be given as a list. Wood warns that `gamm` can strain `lme` numerically, especially when a correlation structure competes with a complex trend.
- *Sole eggs:* the sole-egg GLMM is redone with a space–time tensor product, a smooth mortality term (via `by`) and a station random intercept, giving more realistic spawning maps.
- *Cairo temperatures:* daily temperatures are modelled with a cyclic seasonal smooth (`bs = "cc"`), a smooth long-term trend and AR(1) errors within year (`corAR1`). `intervals(fit$lme)` gives intervals for the AR parameter and for the smooths' "random-effect SDs", which equal $\sigma/\sqrt{\lambda_j}$. A likelihood-ratio test between the `$lme` fits with and without the trend supports a warming trend.

## Key results to know

1. Mixed form of a smooth: $S=UDU^\top$, $U=[U_R\,|\,U_F]$; $X\beta=X_F\beta_F+Zb$, with $X_F=XU_F$ and $Z=XU_RD_+^{-1/2}$.
2. In course notation: $b\sim N(0,\sigma_b^2I)$ with $\lambda=\sigma^2/\sigma_b^2$, since $\lVert y-X_F\beta_F-Zb\rVert^2+\lambda b^\top b$ is the mixed-model criterion with $G=\sigma_b^2I$. Wood writes $b\sim N(0,I/\lambda)$ in a parameterisation where $\sigma^2$ is absorbed.
3. The zero-penalty part (e.g. $[\mathbf 1,x]$ for a second-order penalty) is fixed; the wiggly part is random. As $\sigma_b^2\to0$ the smooth reduces to its null space (a straight line).
4. GAMM posterior: $\beta\mid y\,\dot\sim\,N\big(\hat\beta,(\bar X^\top V^{-1}\bar X+S_\lambda)^{-1}\big)$, with $V=\bar Z\psi\bar Z^\top+\Lambda\sigma^2$ and $S_\lambda=\sum_j(\lambda_j/\sigma^2)S_j$. $\bar X$ holds the fixed and smooth columns, $\bar Z$ the other random effects.
5. Reported SD of a smooth's random effects in `$lme` is $\sigma/\sqrt{\lambda_j}$.

## Connect to class

- **Session 27** derives result 1 for a P-spline: $X=[\mathbf 1,x]$, $Z=BU_+\Sigma_+^{-1/2}$. It then checks numerically that $\hat\sigma^2/\hat\sigma_b^2$ from `lme` equals `gam()`'s REML $\hat\lambda$, which is the book's argument made concrete. The remark that $\lambda$ depends on how $S$ is scaled (compare edf, not `sp`) matches the book.
- **Random effects as smooths:** the slides also go the other way, with `s(Subject, bs = "re")`, `bs = "fs"` and `gam.vcomp()`. None of these is in the 1st edition; follow the slides and `?smooth.construct.re.smooth.spec`.
- **`gamm4`** (`lme4` back end, Laplace for non-Gaussian data) is not in the 1st edition. The book's `gamm()` uses PQL for non-Gaussian data, as the slide "Remarks" says.
- **Using the two components:** the slides' rules ("use `$gam` for smooths and plots, `$lme` for variance components, log-likelihood and LR tests; never `AIC(fit$gam)`") are the book's Cairo workflow. The slides' warning that random intercepts and AR(1) errors can compete is a concrete case of Wood's numerical caution.
- **REML and smoothness:** since smoothness selection by REML is variance-component estimation, Session 24's ML-vs-REML comparison carries over.

## Read carefully / safe to skim

**Read carefully:** smooths as mixed-model components (single-penalty case), the paragraph on what `gamm()` returns, and the Cairo example, especially reading `$gam` vs `$lme` and the $\sigma/\sqrt\lambda$ identity.
**Safe to skim:** the tensor-product (`pdTens`) construction, the posterior formula's details, and the sole-egg model formula.

## Check yourself

1. Starting from the joint density of $(y,b)$ with $b\sim N(0,\sigma_b^2I)$, show in two lines that the penalized least-squares weight is $\lambda=\sigma^2/\sigma_b^2$.
2. For a P-spline with $K=20$ B-splines and a second-order penalty, how many fixed and how many random coefficients does the mixed form have? Why?
3. `intervals(fit$lme)` reports an SD of 0.05 for a smooth's random effects and $\hat\sigma=2.0$. What is $\hat\lambda$?
4. Explain in words why a likelihood-ratio test between two `gamm()` fits is reasonable for Gaussian data but questionable for a Poisson GAMM.
5. Why can the AR(1) parameter and a smooth trend be hard to separate in a time series, and what does this imply for interpreting `gamm()` output?
