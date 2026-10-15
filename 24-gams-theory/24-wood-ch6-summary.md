# Wood (2017), Ch. 6 — GAM theory

**Session(s):** 24 (also useful for 25)  ·  **Source:** Wood, *Generalized Additive Models: An Introduction with R*, Chapman & Hall/CRC. Summarised from the 1st edition (2006), Sec. 4.2–4.11, pp. 163–213; in the 2nd edition (2017) this is Ch. 6.
**Reading time:** ~90 min (core parts ~50 min)  ·  **Level:** core

**Edition warning.** The 1st edition selects smoothing parameters only by GCV, UBRE/$C_p$ or AIC. REML and ML smoothness selection, which the course uses (`method = "REML"`), are not in this part of the 1st edition. They appear there only through the mixed-model route in the GAMM chapter. According to the course reading list, the 2nd edition covers them in this chapter. For REML/ML, follow the Session 24 slides.

## Why read it

How is a GAM actually estimated, how is $\lambda$ chosen, and how much can we trust the intervals and p-values? The chapter justifies the Chapter-4 recipe: it sets a GAM up as a penalized GLM, derives P-IRLS, defines effective degrees of freedom, derives the prediction-error criteria for $\lambda$, and builds the Bayesian covariance matrix behind every band in `plot.gam`.

## The big idea

Given $\lambda$, a GAM is a GLM with a quadratic penalty, fitted by penalized IRLS. Choosing $\lambda$ is a separate problem. Read as a prior, the penalty also gives the posterior $\beta\mid y\approx N(\hat\beta,V_\beta)$. That posterior provides credible intervals that behave well "across the function", and approximate tests for smooth terms.

## Section by section

(Topics follow the book's section titles; section numbers differ between editions.)

**Setting up GAMs as penalized GLMs.** Each smooth contributes model-matrix columns. A sum-to-zero (centring) constraint $\mathbf 1^\top X_j\beta_j=0$ is absorbed by reparameterising with an orthogonal $Z$ (in practice one Householder matrix), which removes one column. The penalties are padded to full size, and the result is the penalized log-likelihood. *Variable coefficient models* (`by` variables) multiply a smooth by a covariate or factor indicator.

**Justifying P-IRLS.** Setting the derivatives of the penalized likelihood to zero gives the same equations as a penalized weighted least-squares problem, so IRLS carries over with $S_\lambda$ added.

**Degrees of freedom and scale.** The total edf is $\operatorname{tr}(A)$. The per-coefficient edf are the diagonal of $F$, the matrix that maps unpenalized to penalized estimates; individual entries are not guaranteed to be positive. The residual variance is $\lVert y-Ay\rVert^2/\{n-\operatorname{tr}(A)\}$, slightly biased by the smoothing bias. A Pearson-type estimator is used for $\phi$.

**Smoothing-parameter criteria.**

- *UBRE / Mallows' $C_p$ (scale known):* an unbiased estimate of the mean squared error. A naive mean-squared-error rule fails when $\sigma^2$ is unknown.
- *Cross-validation (scale unknown):* leave-one-out CV needs only one fit, but it changes under orthogonal rotations of the problem. GCV is CV on the rotation that makes all $A_{ii}$ equal, constructed with Givens rotations.
- *GAM case:* replace the residual sum of squares by the deviance. Pearson-based versions oversmooth, badly so for binary data.

**Numerical optimisation.** *Performance iteration* chooses $\lambda$ inside each P-IRLS step. It is fast, but it can cycle, especially with concurvity, and it can diverge undetected. *Outer iteration* optimises the criterion of the fully converged fit, using Newton's method on $\log\lambda$, derivatives obtained alongside P-IRLS, and stable QR/SVD computations. A factor $\gamma\ge1$ can inflate the edf cost.

**Distributional results.** The frequentist covariance $V_e$ is contrasted with the Bayesian $V_\beta$. The prior is improper: flat on the penalty null space and Gaussian on the wiggly part. Large-sample normality of the posterior for non-Gaussian GAMs is argued through Lindeberg's conditions. Non-linear functionals are handled by simulating from the posterior. p-values come from a Wald statistic with a rank-$r$ pseudo-inverse and are too small because $\hat\lambda$ is treated as known.

**Interval performance.** In simulations, whole-model intervals had close to nominal coverage, while component-wise intervals were unreliable. Adding smoothing-parameter uncertainty, by a parametric bootstrap of $\hat\lambda$, improved them.

**Further theory.** Nested GAMs can be compared by an approximate likelihood-ratio test with edf differences, or exactly by unpenalized fits at some cost in power. ANOVA decompositions $f_1(x)+f_2(z)+f_3(x,z)$ need nested bases and identifiability constraints, which are found numerically by QR. The chapter also covers the geometry of penalized regression and the "natural" parameterisation, in which each coefficient is shrunk independently.

**Other approaches.** Backfitting (with an R implementation using `smooth.spline`) is flexible but makes $\lambda$ selection hard. Generalized smoothing splines (reproducing kernel Hilbert spaces) are sketched.

## Key results to know

1. $\ell_p(\beta)=\ell(\beta)-\tfrac12\sum_j\lambda_j\beta^\top S_j\beta$, with each $\lambda_j$ written once.
2. P-IRLS: $\beta^{\text{new}}=(X^\top WX+S_\lambda)^{-1}X^\top Wz$, where $S_\lambda=\sum_j\lambda_jS_j$.
3. $F=(X^\top WX+S_\lambda)^{-1}X^\top WX$, $\mathrm{edf}=\operatorname{tr}(F)=\operatorname{tr}(A)$; the edf of smooth $j$ is the sum of its $F_{kk}$.
4. UBRE: $\mathcal V_u=\lVert y-Ay\rVert^2/n-\sigma^2+2\sigma^2\operatorname{tr}(A)/n$. GCV for GAMs: $\mathcal V_g=nD(\hat\beta)/\{n-\operatorname{tr}(A)\}^2$.
5. Posterior: $\beta\mid y\,\dot\sim\,N(\hat\beta,V_\beta)$, $V_\beta=(X^\top WX+S_\lambda)^{-1}\phi$, with the penalty on `mgcv`'s deviance scale (written $\tilde S_\lambda$ on the slides). Frequentist: $V_e=(X^\top WX+S_\lambda)^{-1}X^\top WX(X^\top WX+S_\lambda)^{-1}\phi$.
6. Term test: $\hat\beta_j^\top V_{\beta_j}^{r-}\hat\beta_j\,\dot\sim\,\chi^2_r$ (or $F$ if $\phi$ is estimated); conditional on $\hat\lambda$.
7. Natural parameterisation: the edf of coefficient $i$ is $(1+\lambda D_{ii})^{-1}$.

## Connect to class

- **Session 24** derives P-IRLS, the QR centring constraint, edf $=\operatorname{tr}(F)$, GCV and UBRE exactly in this spirit. It adds REML/ML, the k-index of `gam.check()`, and `vcov(fit, unconditional = TRUE)`, which replaces the book's bootstrap of $\hat\lambda$.
- **p-values:** current `summary.gam` reports `Ref.df` and uses the later test of Wood (2013) cited on the slides, not the 1st edition's rank-$r$ Wald test. The warning that p-values are too small still applies.
- **Coverage:** the slides' statement that coverage holds on average across the function (Marra & Wood, 2012) is later work. The 1st-edition simulations found component-wise intervals poor without the λ-uncertainty correction. Follow the slides.
- **Defaults:** `mgcv` still defaults to `method = "GCV.Cp"` (GCV for unknown scale, UBRE/$C_p$ otherwise). The course always passes `method = "REML"`, because GCV can undersmooth, as in the slide "The same smooth, three criteria". The book's performance iteration and $\gamma=1.4$ device are not part of the course workflow.
- **Session 23's backfitting** is the algorithm in "Other approaches". **Session 25's ANOVA decompositions** (`ti()`) and approximate `anova.gam` tests rest on the further-theory material.

## Read carefully / safe to skim

**Read carefully:** setting up GAMs as penalized GLMs, P-IRLS, degrees of freedom, UBRE/CV/GCV (including why GCV is invariant), the Bayesian model and posterior, p-values and their caveat, interval performance (the conclusions), and comparing GAMs.
**Safe to skim:** the numerical sections (performance and outer iteration, derivative formulas), the Lindeberg conditions, the RKHS material, and the ANOVA-nesting algorithm.

## Check yourself

1. Derive the P-IRLS update from $\ell_p(\beta)$ by one Fisher-scoring step. Which matrix is inverted?
2. Show that $\operatorname{tr}(F)=\operatorname{tr}(A)$ for $A=X(X^\top WX+S_\lambda)^{-1}X^\top W$.
3. Why must a smooth be centred when the model has an intercept, and why does `s(x, k = 10)` then have at most 9 edf?
4. In words: why does UBRE need $\sigma^2$ but GCV does not? Which `mgcv` method uses which?
5. A smooth term has $p=0.03$ in `summary()`. Why should you not read this as exact, and in which direction is it likely to be wrong?
