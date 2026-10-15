# Wood (2017), Ch. 7 — GAMs in practice: mgcv

**Session(s):** 26 (also useful for 25)  ·  **Source:** Wood, *Generalized Additive Models: An Introduction with R*, Chapman & Hall/CRC. Summarised from the 1st edition (2006), Ch. 5, pp. 217–272; in the 2nd edition (2017) this is Ch. 7. The 2nd edition's worked examples may differ from those summarised here.
**Reading time:** ~40 min per worked example; ~2 h for the whole chapter  ·  **Level:** core (one worked example of your choice) / optional (the rest)

**Edition warning: `mgcv` has changed since 2006.** Follow the course decks (Sessions 23–27) and current help pages where they differ from the book:

- The book selects $\lambda$ by GCV/UBRE. `gam()` still defaults to `method = "GCV.Cp"`, but the course always uses `method = "REML"` (and `"ML"` only to compare models whose parametric parts differ).
- The book's `method = gam.method(...)` interface and "performance iteration" are no longer how current `mgcv` is controlled; use `method` (and `optimizer`).
- `summary()` now reports `Ref.df` where the book prints `Est.rank`.
- `gam.check()` now also prints the k-index table for the basis dimension; in the book it reports only convergence information and plots.
- The following are not in the 1st edition: `ti()` interaction terms, `concurvity()`, `select = TRUE`, `bs = "re"` with `gam.vcomp()`, AIC with smoothing-parameter-corrected df, and `vcov(fit, unconditional = TRUE)`. Current `mgcv` also provides `nb()`, a negative binomial family that estimates its parameter.

## Why read it

How does a full GAM analysis look in practice: choosing family, basis and $k$, checking residuals, comparing structures, and turning a fitted model into predictions with honest uncertainty? The chapter works through four real analyses with `mgcv::gam()`. Together they show the habits Lab 06 asks for.

## The big idea

`gam()` is used like `glm()`, plus smooth terms. Most of the modelling skill is outside the function call: choosing the family from the mean–variance pattern, deciding isotropic vs tensor smooths, checking the model, and computing any quantity of interest (and its uncertainty) from the linear-predictor matrix and posterior simulation.

## Section by section

(Topics follow the book's section titles; section numbers differ between editions.)

**Cherry trees again.**

- *First fit:* the hand-built Gamma GAM of Chapter 4 is refitted in one line. `print()` shows the edf, and `plot(..., residuals = TRUE)` shows partial residuals, credible bands and rug plots. The band has zero width where a straight-line term crosses zero, because of the centring constraint.
- *Finer control:* change the basis (`bs = "cr"`), raise `k` (edf $\le k-1$), or use `gamma = 1.4` to oppose GCV overfitting. A table compares the built-in bases (`tp`, `ts`, `cr`, `cs`, `cc`, `ps`).
- *Smooths of several variables:* isotropic `s(Height, Girth)` vs tensor `te(Height, Girth)`; the second collapses to a bilinear surface.
- *Parametric terms:* a factor plus a smooth, read with `anova()`, `AIC()` and `summary()`.

**Brain imaging.**

- *Family:* after removing two gross outliers, a Gaussian fit shows the variance growing with the mean. Regressing log squared residuals on log fitted values gives roughly variance $\propto\mu^2$, which suggests a Gamma log-link model rather than a fourth-root transform. The two models are biased on different scales.
- *Structure:* an isotropic surface beats an additive one by GCV, by an approximate $F$ test and visually (the additive fit produces stripes). The approximations in that test are spelled out. Tensor and isotropic surfaces are compared with properly nested bases.
- *Symmetry and comparing surfaces:* `by` variables test symmetry and compare two surfaces as "common surface + difference". Unpenalized terms (`fx = TRUE`) give p-values with the correct null distribution at a cost in power.
- *Prediction:* `predict.gam()` with link/response scales, `type = "terms"` and `type = "lpmatrix"`. Variances of linear combinations come from $X_pV_\beta X_p^\top$, and non-linear summaries from posterior draws of $\beta$.

**Air pollution in Chicago.** A Poisson model for daily deaths, with a smooth of time and linear pollutant terms, fails on a few days of extreme mortality. Smooth pollutant effects do not fix it. Sums of temperature and pollution over the current and three previous days, combined in a tensor product smooth with ozone, do. Simplification is by UBRE (equivalent to AIC here); the data-driven construction warrants caution.

**Mackerel egg survey.** Egg counts with a log net-area offset are modelled with shrinkage smoothers (`bs = "ts"`), unknown scale (`scale = -1`, overdispersed Poisson) and `gamma = 1.4`. Two terms shrink to zero edf and are dropped. A negative binomial alternative gives residual variance decreasing with the mean, so it is rejected. Total egg abundance is obtained by posterior simulation, both conditional on $\hat\lambda$ and with a bootstrap allowance for $\lambda$ uncertainty.

**Portuguese larks.** A spatial TPRS for binary presence data, aggregated to binomial counts so that residuals are readable, with a residual variogram to check spatial autocorrelation.

**Other packages.** Brief tours of `gam` (backfitting) and `gss` (smoothing-spline ANOVA).

## Key results to know

1. `gam(y ~ s(x1) + s(x2, x3) + te(x4, x5) + f, family = ..., data = ..., method = "REML")`. Defaults: `s()` is TPRS with `k = 10`; `te()` has marginal `k = 5`.
2. Each centred `s(x, k)` has edf $\le k-1$; `k` sets a ceiling, not the fit.
3. Isotropic `s(x, z)` suits covariates on the same scale; `te(x, z)` is invariant to rescaling each covariate.
4. `by = z` gives $f(x)\,z$; with a 0/1 indicator it adds a "difference" smooth.
5. $\hat\eta_p=X_p\hat\beta$ and $\mathrm{Var}(d^\top\hat\eta_p)=d^\top X_pV_\beta X_p^\top d$; for non-linear quantities, simulate $\beta^*\sim N(\hat\beta,V_\beta)$.
6. Approximate model comparison: `anova(m0, m1, test = "F")`, conditional on $\hat\lambda$ and using edf.

## Connect to class

- **Session 26 (Lab 06)** follows the same habits on `airquality`: choose the scale or family (with the Jacobian for AIC), fit with REML, check `k` and concurvity, compare additive with `te()`/`ti()`, compare by `AIC()` and `anova(..., test = "F")` on ML fits, and predict with link-scale intervals and `lpmatrix` contrasts.
- **Session 25** adds `ti()`, `concurvity()` and `select = TRUE`, none of which is in the 1st edition. Where the book uses `ts` shrinkage bases and `gamma = 1.4`, the course uses REML and, if needed, `select = TRUE`.
- **Response-scale intervals:** the book notes that response-scale standard errors from `predict()` are delta-method approximations. The course rule is to build intervals on the link scale and then transform them.
- **Visualisation:** the book's `vis.gam(..., too.far = ...)` is still used on the Session 25 slides.

## Read carefully / safe to skim

**Read carefully:** the cherry-tree section (all of it), and from the brain-imaging example the choice of family, the additive-vs-surface comparison and prediction with `lpmatrix`.
**Safe to skim:** symmetry testing and surface comparison, the Chicago lag construction, the larks example, and other packages. Choose one of the Chicago, mackerel or larks examples to read in full, as the reading list asks.

## Check yourself

1. Why can the edf of `s(x, k = 10)` never exceed 9, and what would you check if it came out as 8.9?
2. Describe how the brain-imaging analysis chose between a transformed Gaussian model and a Gamma log-link model. On which scale is each approximately unbiased?
3. When would you use `s(lon, lat)` and when `te(temp, wind)`? Explain in one sentence each.
4. Using `type = "lpmatrix"`, write the steps to obtain a 95% interval for the ratio of expected responses at two covariate values under a log link.
5. Why do p-values from unpenalized (`fx = TRUE`) terms behave better under the null, and what is the price?
