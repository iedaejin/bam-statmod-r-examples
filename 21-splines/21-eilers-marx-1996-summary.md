# Eilers & Marx (1996) — Flexible smoothing with B-splines and penalties

**Session(s):** 21 and 22 (also useful for 20 and 23–27)  ·  **Source:** Eilers, P. H. C. and Marx, B. D. (1996), "Flexible smoothing with B-splines and penalties", *Statistical Science* 11(2), pp. 89–121 (paper pp. 89–102; eight invited comments and the rejoinder, pp. 102–121). Used as the reading on P-splines because Eilers & Marx (2021), *Practical Smoothing: The Joys of P-splines*, cited in the syllabus, is not available to us.
**Reading time:** ~60 min for the paper, ~45 min for the discussion  ·  **Level:** core (Sections 2–6 and the Appendix); optional (Sections 7–9 and the discussion)

## Why read it
The paper that introduced P-splines, the smoother we build by hand in Session 21 and Lab 05. In fourteen pages: the B-spline basis, the difference penalty, the penalized normal equations and their GLM version, the properties proved in class, criteria for $\lambda$, and code. The 2021 book expands the same material.

## The big idea
Choosing the number and position of knots for a regression spline is hard. Instead, use a **generous** number of equally spaced B-splines, enough to overfit, and control smoothness with a penalty on **differences of adjacent coefficients**. One continuous parameter $\lambda$ replaces the discrete knot choice. A penalty on coefficients, not on derivatives, is trivial to build for any order and changes the (generalized) linear regression equations by one term.

## Section by section

**1. Introduction (p. 89).** Kernels, LOWESS and splines; splines are better called "overparametric" than nonparametric. Knot selection is a hard numerical problem. O'Sullivan used many knots and a penalty on the integrated squared second derivative; the authors replace it by a difference penalty and list its advantages: no boundary effects, conservation of moments, polynomial limits, cheap cross-validation.

**2. B-splines in a nutshell (p. 90).** A B-spline of degree $q$ has $q+1$ polynomial pieces joined at $q$ inner knots, continuous derivatives up to order $q-1$, and support on $q+2$ knots; at any $x$, $q+1$ B-splines are non-zero; $n'$ equal intervals give $n'+q$ B-splines. Key formula: the derivative of a B-spline curve is a B-spline curve of one degree lower whose coefficients are the **differences** of the original ones (over the knot spacing), so second derivatives correspond to second differences.

**3. Penalties (p. 91).** Least squares on many B-splines overfits. O'Sullivan's penalty $\lambda\int\{\sum_j\theta_jB_j''(x)\}^2dx$ is replaced by $\lambda\sum_j(\Delta^d\theta_j)^2$. For second order, the derivative penalty equals the difference penalty plus a term in products of neighbouring second differences, so the two are close; the difference version is far easier for higher orders. Difference penalties go back to Whittaker (1923).

**4. Penalized likelihood (p. 92).** The penalized normal equations $(B^\top B+\lambda D_d^\top D_d)\hat\theta=B^\top y$; $d=0$ gives ridge regression; the system is banded and small (one equation per B-spline). For a GLM, subtract $\tfrac\lambda2\lVert D_d\theta\rVert^2$ from the log-likelihood and solve by iteratively reweighted least squares with $B^\top WB+\lambda D_d^\top D_d$.

**5. Properties of P-splines (p. 93).** No boundary effects (unlike kernels, the fit does not bend towards zero at the edges). Data lying on a polynomial of degree $d-1$ are fitted exactly for every $\lambda$. Moments are conserved: $\sum_ix_i^ky_i=\sum_ix_i^k\hat y_i$ for $k<d$, also for GLMs with canonical link. As $\lambda\to\infty$ the fit tends to a polynomial of degree $d-1$. The trace of the hat matrix tends to $d$, proved through the eigenvalues of the penalty matrix (which has $d$ zero eigenvalues). The paper states the conditions informally; deck 21 gives them precisely (equally spaced knots, degree $q\ge d-1$).

**6. Optimal smoothing, AIC and cross-validation (p. 94).** The effective dimension is the trace of the hat matrix (following Hastie and Tibshirani), cheap to compute from $c\times c$ matrices. Criteria: AIC (deviance plus twice the effective dimension, with an estimated error variance for normal data), leave-one-out CV with the leverage shortcut, and GCV. Plotting AIC against the effective dimension is a useful diagnostic; for normal data only $B^\top B$ and $B^\top y$ are needed to scan many values of $\lambda$.

**7. Applications to generalized linear modelling (p. 95).** Motorcycle helmet data (cubic B-splines, 20 intervals, $d=2$, $\lambda$ by GCV); a logistic dose–response curve where a fourth-order penalty with large $\lambda$ effectively selects a cubic logistic model; coal-mining disasters as Poisson counts.

**8. Density smoothing (p. 96).** A histogram is smoothed as Poisson counts with log link; the result is a proper density, and a third-order penalty keeps the data's mean and variance for any $\lambda$. Examples: Old Faithful, and suicide-study data where the choice of domain near the boundary at zero matters.

**9. Discussion (p. 98).** Extensions: additive models without backfitting, tensor products in two dimensions, robust and adaptive versions; AIC may undersmooth overdispersed data.

**Appendix (p. 100).** S-PLUS and MATLAB code: the B-spline basis on equally spaced knots (extended $q$ intervals beyond the domain), $D_d$ by repeated differencing of an identity matrix, the solve, and GCV. Fitting by **data augmentation**: regress $(y,0)$ on $(B,\sqrt\lambda D_d)$ stacked.

**Discussion and rejoinder (pp. 102–121).** Points raised: weaknesses of classical criteria for $\lambda$ (Chiu); the smoother as a filter in a Demmler–Reinsch basis (Nychka and Cummins); a quadratic penalty is a Gaussian prior, part fixed and part random effect (Gu); adaptive smoothing (Kooperberg; Sain and Scott). The rejoinder gives defaults (cubic B-splines, third-order penalty, plenty of B-splines), standard errors, Whittaker's three-line smoother, and a "consumer test" of smoothers.

## Key results to know
Course notation: $n$ observations, $c$ B-splines, coefficients $\theta$, penalty order $d$, B-spline degree $q$. The paper uses $m$ observations, $n$ B-splines, coefficients $a$, penalty order $k$; its hat matrix $H$ is our $S_\lambda$.
1. $\hat\theta=(B^\top B+\lambda D_d^\top D_d)^{-1}B^\top y$, $\ S_\lambda=B(B^\top B+\lambda D_d^\top D_d)^{-1}B^\top$.
2. $\mathrm{edf}(\lambda)=\mathrm{tr}\{(B^\top B+\lambda D_d^\top D_d)^{-1}B^\top B\}$, from $c$ ($\lambda\to0$) down to $d$ ($\lambda\to\infty$).
3. Polynomial reproduction of degree $<d$ and conservation of the moments $k=0,\dots,d-1$; the $\lambda\to\infty$ limit is a polynomial of degree $d-1$.
4. GLM version: $(B^\top WB+\lambda D_d^\top D_d)\theta^{\text{new}}=B^\top Wz$ (IWLS).
5. $\mathrm{CV}(\lambda)=\sum_i\{(y_i-\hat y_i)/(1-S_{ii})\}^2$; the paper's GCV is $\mathrm{RSS}/(n-\mathrm{edf})^2$ (deck 21 multiplies by $n$; same minimiser); AIC = deviance $+\,2\,\mathrm{edf}$.
6. Rejoinder: $\widehat{\mathrm{Var}}(\hat\theta)=\sigma^2(B^\top B+\lambda D_d^\top D_d)^{-1}B^\top B(B^\top B+\lambda D_d^\top D_d)^{-1}$ for normal data.

## Connect to class
- Deck 21, section "P-splines" (difference matrix, estimator, limits of edf, polynomial reproduction, moments, choosing $\lambda$, "A P-spline in a few lines"). `21-bsplines-psplines.Rmd` (`psfit()`) is a modern version of the Appendix code, checked against `mgcv` (`bs = "ps"`).
- Lab 05 / Session 22, Part 5: your own P-spline on `mcycle`, the paper's motorcycle data. The deck's $\mathrm{AIC}=n\log(\mathrm{RSS}/n)+2\,\mathrm{edf}$ handles $\sigma^2$ differently from the paper's normal AIC.
- Session 20: Pawitan Ch. 18 is the special case $B=I$ (Whittaker), shown in the rejoinder too.
- Sessions 24 and 27: Gu's "the penalty is a prior" is the mixed-model view (deck 21, "Preview: penalized splines are mixed models"), where $\lambda$ is estimated by REML.

## Read carefully / safe to skim
- **Read carefully:** Sections 2–6, the motorcycle example in Section 7, and the Appendix.
- **Skim:** the other examples in Sections 7–8, Section 9, and the discussion; in the rejoinder read "Default parameter values" and "Derivative or differences?".

## Check yourself
1. Derive the penalized normal equations from $\lVert y-B\theta\rVert^2+\lambda\lVert D_d\theta\rVert^2$.
2. Why does the effective dimension tend to $d$ as $\lambda\to\infty$? Describe the coefficient vectors with $D_d\theta=0$.
3. Explain why the number of knots matters little in a P-spline once it is large enough. What controls smoothness instead?
4. With $d=2$, which moments of the data does the fit keep for every $\lambda$? Why might this matter in density estimation?
5. Write the augmented regression that reproduces the P-spline fit with an ordinary least squares routine.
