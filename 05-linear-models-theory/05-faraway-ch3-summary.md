# Faraway (2014), Ch. 3 — Inference

**Session(s):** 5 (also useful for 6 and 8)  ·  **Source:** Faraway, *Linear Models with R*, 2nd ed., Chapman & Hall/CRC, Ch. 3, pp. 33–50  
**Reading time:** ~55 min  ·  **Level:** core

## Why read it

Once $\hat\beta$ is computed, we want to know which predictors matter and how precisely their effects are estimated. This chapter gives the one test that does almost everything in linear models, the $F$ test for nested models, and shows that $t$ tests, overall significance, tests of linear restrictions and confidence intervals are all special cases. It also offers two ways out when normality is doubtful: permutation tests and the bootstrap.

## The big idea

Compare a smaller model $\omega$ (the null) with a larger model $\Omega$ (the alternative) that contains it. If the extra parameters of $\Omega$ reduce the RSS by little, keep the simpler model. Scaled properly, the drop in RSS has an $F$ distribution under normal errors, and the same statistic comes out of the likelihood-ratio test. Every hypothesis must be stated **together with the other predictors in the model**: a test of $\beta_j=0$ means something different in different models.

## Section by section

**Opening (p. 33).** Estimation needs no distributional assumption, but exact tests and intervals do. Assuming $\varepsilon\sim N(0,\sigma^2I)$ gives $\hat\beta\sim N(\beta,\sigma^2(X^\top X)^{-1})$.

**3.1 Hypothesis Tests to Compare Models (p. 33).** Geometric motivation by Pythagoras (Figure 3.1): the squared distance between the two fitted vectors equals $\mathrm{RSS}_\omega-\mathrm{RSS}_\Omega$. An outline of the likelihood-ratio derivation leads to the same ratio. With $p$ and $q$ parameters in $\Omega$ and $\omega$, the statistic is referred to $F_{p-q,\,n-p}$. The test also applies when $\omega$ is a linear **subspace** of $\Omega$, not only a subset of columns.

**3.2 Testing Examples (p. 35).** All on the Galápagos data (`gala`):

- *All predictors:* null model $y=\mu+\varepsilon$; the classical ANOVA table is just bookkeeping for this test. Failing to reject is not proof of no relationship; rejecting does not mean the full model is the right one.
- *One predictor:* the $F$ test for dropping `Area` equals the square of its $t$ statistic. The same hypothesis $\beta_{\text{Area}}=0$ gives a very different $p$-value when `Area` is the only predictor: the null must name the other terms.
- *A pair of predictors:* use one joint $F$ test, never two separate $t$ tests.
- *A subspace:* replacing `Area` and `Adjacent` by their sum (via `I()`), or fixing a coefficient at a value with `offset()`; a point hypothesis $\beta_j=c$ is more easily tested with $t=(\hat\beta_j-c)/\mathrm{se}(\hat\beta_j)$.
- *Tests we cannot do:* nonlinear hypotheses, non-nested models (see Ch. 10), and models fitted to different cases because of missing values (Ch. 13).

**3.3 Permutation Tests (p. 40).** If the response were unrelated to the predictors, any permutation of $y$ would be equally likely. Compare the observed $F$ with the $F$ values from many random permutations of the response (or, for one predictor, permute that predictor and compare $t$ values). On `gala` with `Nearest` and `Scruz`, the permutation and normal-theory $p$-values nearly agree. Permutation logic is directly justified when treatments were randomly assigned.

**3.4 Sampling (p. 42).** What the inference refers to: a data-generating process (experiments), a finite population sampled at random (surveys), or nothing beyond the sample (convenience samples, or when the "sample" is the whole population, as for the Galápagos islands). In the last case permutation tests still give the $p$-value a meaning for the data at hand.

**3.5 Confidence Intervals for β (p. 43).** Individual $t$ intervals; duality with two-sided tests; `confint()`. Intervals are more informative than $p$-values because they show the size of the effect. For several parameters, a joint **ellipsoidal** confidence region; Figure 3.2 (`ellipse` package) compares it with the rectangle formed by two univariate intervals and shows how joint and separate conclusions can disagree.

**3.6 Bootstrap Confidence Intervals (p. 46).** First the idea of simulation from a known model, then the bootstrap, which replaces the unknown error distribution by resampling the **residuals** with replacement, rebuilding $y^*=X\hat\beta+e^*$ and refitting (with `update()`). Percentile intervals from 4000 resamples agree qualitatively with the normal-theory intervals. Resampling $(x,y)$ pairs is an alternative.

## Key results to know

1. Nested $F$ test:
   $$F=\frac{(\mathrm{RSS}_\omega-\mathrm{RSS}_\Omega)/(p-q)}{\mathrm{RSS}_\Omega/(n-p)}\sim F_{p-q,\,n-p}\quad\text{under }H_0 .$$
   Equivalently with residual degrees of freedom: $[(\mathrm{RSS}_\omega-\mathrm{RSS}_\Omega)/(\mathrm{df}_\omega-\mathrm{df}_\Omega)]/(\mathrm{RSS}_\Omega/\mathrm{df}_\Omega)$.
2. Overall test: $F=\dfrac{(\mathrm{TSS}-\mathrm{RSS})/(p-1)}{\mathrm{RSS}/(n-p)}$ on $(p-1,\,n-p)$ df.
3. Single coefficient: $t_j=(\hat\beta_j-c)/\mathrm{se}(\hat\beta_j)\sim t_{n-p}$; for $c=0$, $t_j^2$ equals the $F$ for dropping $x_j$.
4. CI: $\hat\beta_j\pm t_{n-p,\,1-\alpha/2}\,\mathrm{se}(\hat\beta_j)$, with $\mathrm{se}(\hat\beta_j)=\hat\sigma\sqrt{[(X^\top X)^{-1}]_{jj}}$. Faraway writes the quantile as $t^{(\alpha/2)}_{n-p}$.
5. Joint region: $(\hat\beta-\beta)^\top X^\top X(\hat\beta-\beta)\le p\,\hat\sigma^2F_{p,\,n-p,\,1-\alpha}$ (an ellipsoid).
6. Residual bootstrap: resample $e$, form $y^*=X\hat\beta+e^*$, refit, take percentiles of $\hat\beta^*$.

## Connect to class

- **Session 5 deck**, section *Inference*: same $t$ and $F$ results, on `savings` (the deck's test of `pop75` and `dpi` together is the "pair of predictors" case). The deck derives the distributions from projection algebra and A4; Faraway gives the geometric and likelihood-ratio intuition.
- The deck's section *Least squares and likelihood* complements Faraway's outline of the likelihood-ratio derivation and links to Sessions 3–4.
- `05-inference.Rmd` computes $t$, $F$ and intervals by hand, as Faraway does with `deviance()` and `df.residual()`.
- **Session 8**, Problem 2, is exactly this chapter without software: rebuild $t$ values, CIs and a nested $F$ from printed output.
- Permutation tests and the bootstrap are not on the Session 5 slides; they reappear as resampling ideas in model assessment (cross-validation, Session 6) and are worth knowing.

## Read carefully / safe to skim

- **Read carefully:** 3.1, 3.2 (all five testing situations, especially "Testing one predictor" and "Testing a pair"), 3.5.
- **Read once:** 3.3 and 3.6, for the ideas; you will not be examined on the R loops.
- **Safe to skim:** 3.4, although its point about convenience samples is a good exam discussion item.

## Check yourself

1. Show that, for dropping one predictor, the $F$ statistic equals $t_j^2$ (hint: write both in terms of RSS differences or accept the identity and check it numerically on a `summary(lm)` table).
2. A (hypothetical) model has $n=30$, $p=6$, $\mathrm{RSS}_\Omega=900$; removing two predictors gives $\mathrm{RSS}_\omega=1500$. Compute $F$, its degrees of freedom, and decide at the 5% level ($F_{2,24,0.95}\approx3.40$).
3. Why can `Area` be "not significant" in one model and highly significant in another fitted to the same islands?
4. Explain in words why two univariate 95% intervals that both contain zero do not imply that the joint hypothesis $\beta_1=\beta_2=0$ is accepted.
5. In the residual bootstrap, which quantities are kept fixed and which are resampled? Why is that natural when $X$ is a designed set of inputs?
