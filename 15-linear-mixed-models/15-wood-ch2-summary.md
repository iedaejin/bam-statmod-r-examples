# Wood (2017), Ch. 2 — Linear mixed models

**Session(s):** 15, 16 (also useful for 18 and 19)  ·  **Source:** Wood, *Generalized Additive Models: An Introduction with R*, Chapman & Hall/CRC. Summarised from the 1st edition (2006), Sec. 6.1–6.3, pp. 273–303; in the 2nd edition (2017) this is Ch. 2.
**Reading time:** ~75 min  ·  **Level:** core

## Why read it

How do we model data that come in groups (trees, rails, workers, subjects) when the particular groups are not what we care about? The chapter builds the linear mixed model (LMM) from small balanced experiments up to the general model and `nlme::lme()`. It gives the likelihood tools behind Sessions 15–16 (ML, REML, prediction of random effects) and ends with the link to penalised regression that we use again in Session 27.

## The big idea

A random effect describes how the data are correlated. Averaging over $b$ in $y=X\beta+Zb+\varepsilon$ gives a model with no random effects but with a non-diagonal covariance, $y\sim N(X\beta,V)$. So fitting an LMM means estimating a few variance parameters by (restricted) likelihood. The fixed effects then follow by generalised least squares, and the random effects are *predicted* by their conditional mean given the data.

## Section by section

(Topics follow the book's section titles; section numbers differ between editions.)

**Mixed models for balanced data.** The motivating example is a CO₂ experiment: six trees, three per treatment, four stomatal measurements per tree. If tree is a fixed factor, it is completely confounded with treatment, so the comparison says nothing about CO₂, and the model cannot say anything about trees outside the experiment. Making tree random solves both problems. Averaging the four measurements per tree gives an ordinary linear model for the tree means, with error variance $\sigma_b^2+\sigma^2/4$, and the CO₂ test uses an $F_{1,4}$ reference distribution. The general principles are:

- with balanced data, averaging over a random factor gives a simpler mixed model;
- the reference degrees of freedom are those of the averaged model;
- variance components come from differences of residual mean squares.

Two worked cases follow. In the `Rail` data (one random factor), the between-rail SD is much larger than the measurement SD. In the `Machines` data, machines are fixed and workers random. Because the machine-by-worker interaction is random, the main effects can still be tested when the interaction is present. A short discussion explains why least-squares theory works here (balance, orthogonality) and why software replaces it in practice.

**Linear mixed models in general.** The `Rail` model is written out with explicit $X$ and $Z$. Combining $Zb+\varepsilon$ into one error gives the marginal model, from which the likelihood follows. $\beta$ and $\sigma^2$ are profiled out, and Newton's method is used for the rest. A short R function maximises the likelihood with `optim`, using a Cholesky "whitening" step. Its ML variance components are smaller than the balanced-ANOVA ones, which shows that ML is biased downwards.

- *Inference:* for fixed effects, condition on the estimated variance parameters and use GLS theory. The $F$ denominator degrees of freedom are chosen to match the balanced case.
- *Variance parameters:* use large-sample normality on the log-SD scale. Likelihood-ratio tests of random-effect structures are only "very approximate" because the null puts a variance on the boundary. Clear-cut p-values are still informative, and intervals obtained by inverting the test are unaffected.
- *Predicting random effects:* the conditional mean comes from normal conditioning. Fitted values $X\hat\beta+Z\tilde b$ and the corresponding residuals are used for model checking.
- *REML:* REML integrates the likelihood over $\beta$. The integral is evaluated in closed form, and REML likelihood-ratio tests are valid only between models with identical fixed effects.
- *Penalised regression:* given the variance parameters, $\hat\beta$ and $\tilde b$ jointly minimise a penalised sum of squares. The book gives a short proof via the joint density of $(y,b)$.

**Linear mixed models in R.** This part covers `lme()`, the grouped (Laird–Ware) form, and the random-effects syntax `~ x | g` or `list(g = ~ x)` (the list form is needed later for `gamm`). Fitted with REML, `Rail` reproduces the balanced-ANOVA estimates; with `method = "ML"` it reproduces the `optim` ones. A longer example models Loblolly pine growth curves: a polynomial in age, tree-specific random polynomial coefficients and continuous-time AR(1) errors within tree (`corCAR1`). The structure is refined with residual plots, `anova()` (likelihood-ratio tests and AIC) and `pdDiag`. Nested random effects are specified as `list(Worker = ~1, Machine = ~1)`.

## Key results to know

1. $y=X\beta+Zb+\varepsilon$, $b\sim N(0,G)$, $\varepsilon\sim N(0,\sigma^2I)$ $\Rightarrow$ $y\sim N(X\beta,V)$, $V=ZGZ^\top+\sigma^2I$. Wood writes $\psi$ (or $\psi_\theta$) for $G$, allows $\varepsilon\sim N(0,\Lambda\sigma^2)$, and works with $\Sigma_\theta=V/\sigma^2$. His $\theta$ means the variance parameters.
2. Balanced one-way design ($I$ groups, $J$ per group): $\bar y_{i\cdot}=\alpha+e_i$ with $\mathrm{Var}(e_i)=\sigma_b^2+\sigma^2/J$, so $\hat\sigma_b^2=\mathrm{RSS}_2/(I-1)-\hat\sigma^2/J$ with $\hat\sigma^2=\mathrm{RSS}_1/(n-I)$.
3. GLS: $\hat\beta=(X^\top V^{-1}X)^{-1}X^\top V^{-1}y$ for given variance parameters, then the profile likelihood is maximised over those parameters.
4. ML bias in the linear model: $\mathrm{E}(\hat\sigma^2_{\mathrm{ML}})=\frac{n-p}{n}\sigma^2$.
5. REML: $L_R=\int L\,d\beta$, so that $\ell_R=-\tfrac12\log|V|-\tfrac12\log|X^\top V^{-1}X|-\tfrac12(y-X\hat\beta)^\top V^{-1}(y-X\hat\beta)+\text{const}$.
6. Prediction: $\tilde b=GZ^\top V^{-1}(y-X\hat\beta)$ and $\mathrm{Var}(b\mid y)=G-GZ^\top V^{-1}ZG$. Wood writes $\hat b$ for the prediction.
7. $(\hat\beta,\tilde b)$ minimise $\lVert y-X\beta-Zb\rVert^2+\sigma^2\,b^\top G^{-1}b$. With $G=\sigma_b^2I$ the penalty weight is $\sigma^2/\sigma_b^2$.

## Connect to class

- **Session 15** motivates random effects through pooling and correlated residuals on `sleepstudy`, and derives the ICC and compound symmetry. Wood argues from experimental design instead (confounding, generalising to new units). The ICC is not named in the book but is $\sigma_b^2/(\sigma_b^2+\sigma^2)$ in the one-way model.
- **Session 16** derives REML through error contrasts; Wood integrates over $\beta$, and both give the same criterion. The slides add the shrinkage factor $k_i$ and the 50:50 $\chi^2$ mixture for boundary tests, which go beyond the book's "very approximate" advice. Wood's remark that REML matches the classical estimators in balanced designs fits the slide "less biased, not unbiased".
- **Session 18 (Lab 04)** uses `lme4::lmer()` as well. The 1st edition only uses `nlme::lme()`, so read the `lme4` syntax `(x | g)` from the lab and Bates et al. (2015).
- **Session 19:** the book's exercises on aggregated models and on writing $X$, $Z$ and $G$ for small designs are good practice for computing $V$ by hand.
- **Session 27** reuses result 7: a smoothing penalty is a random-effect variance.

## Read carefully / safe to skim

**Read carefully:** the single-random-factor analysis, the general model and marginal likelihood, inference about random effects, prediction of random effects, REML (including its explicit form), the link with penalised regression, and `lme` syntax.
**Safe to skim:** the two-factor balanced algebra, the `optim` code, the denominator-df discussion, and the details of the Loblolly model sequence (read it for the workflow, not the numbers).

## Check yourself

1. In the balanced one-way model, derive $\mathrm{Var}(\bar y_{i\cdot})$ and use it to build an unbiased estimator of $\sigma_b^2$.
2. Explain in words why a fixed tree factor makes the CO₂ test impossible, while a random tree effect does not.
3. Show that $\mathrm{E}(\hat\sigma^2_{\mathrm{ML}})=(n-p)\sigma^2/n$ in a linear model. What does REML do about this, in one sentence?
4. From the joint density of $(y,b)$, show that $\hat\beta$ and $\tilde b$ minimise a penalised sum of squares. What is the penalty when $G=\sigma_b^2I$?
5. A likelihood-ratio test for a random-slope variance gives $p=0.7$ from $\chi^2_2$. Is the conclusion safe? Would $p=0.04$ be?
