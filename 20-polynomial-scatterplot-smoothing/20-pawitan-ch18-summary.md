# Pawitan (2001), Ch. 18 — Nonparametric smoothing

**Session(s):** 20 (Section 18.1) and 21 (Sections 18.2–18.7, 18.9); also useful for 22–27  ·  **Source:** Pawitan, *In All Likelihood: Statistical Modelling and Inference Using Likelihood*, OUP, Ch. 18, pp. 473–502 (text pp. 473–501, exercises pp. 501–502)
**Reading time:** ~80 min (~20 min for the introduction and 18.1)  ·  **Level:** core for the introduction and 18.1 (Session 20); optional for 18.2–18.7 and 18.9 (Session 21); optional for the rest

## Why read it
Session 20 introduces smoothing as local averaging and asks how much to smooth. Pawitan's opening section does exactly that with bins, nearest neighbours and kernels. The rest of the chapter takes a route that the course follows later: a smooth function is a vector of random effects whose differences are small, so smoothing is a linear mixed model and choosing the amount of smoothing is estimating a variance ratio. This is the P-spline of Session 21 with the simplest possible basis, and the idea behind REML smoothing in Sessions 24 and 27.

## The big idea
"Nonparametric" means that $\mathrm E(y)=f(x)$ for an unrestricted function $f$, not a rank method. All smoothers average the responses near $x$; the smoothing parameter trades local bias against variance. Pawitan works on a regular grid of $x$ values (pre-binning the data if needed), so $f$ is just a vector $(f_1,\dots,f_n)$. Smoothness is imposed by assuming that the first or second differences of $f$ are i.i.d. $N(0,\sigma_b^2)$. Combined with $N(0,\sigma^2)$ errors, the joint log-likelihood is a **penalized** sum of squares with smoothing parameter $\lambda=\sigma^2/\sigma_b^2$, and $\lambda$ can be estimated like any variance component, by likelihood or by GCV.

## Section by section

**Introduction (p. 473).** What "nonparametric" means; the chapter uses vectors and matrices, not function spaces, and fits smoothing into likelihood-based mixed models.

**18.1 Motivation (p. 473).** Sulphur dioxide vs number of factories in 41 US cities (log scales, from Section 6.8): a straight line misses a curve that a smoother reveals. Three ad hoc local-averaging methods: **partitioning** into bins (too wide: bias; too narrow: noise), **nearest neighbours** (average of the $k$ closest points, biased at the boundaries), and the **kernel** method (a weighted average with weights from a symmetric density; Gaussian smoothing with its standard deviation as bandwidth). For each, the choice of the smoothing parameter is the key issue, and the next section turns it into a variance-component problem.

**18.2 Linear mixed models approach (p. 477).** A likelihood framework extends to non-Gaussian data, jumps, higher dimensions and boundaries. Pre-bin the data on a fine, equally spaced grid and write $y_{ij}=\beta+b_i+e_{ij}$ with $f_i=\beta+b_i$. Treating $b$ as fixed gives the raw bin means, which are noisy.

**18.3 Imposing smoothness using random effects model (p. 479).** Assume first differences $b_j-b_{j-1}$, or second differences $b_j-2b_{j-1}+b_{j-2}$, are i.i.d. $N(0,\sigma_b^2)$: random walks of order 1 or 2 (order 2 paths already look like smooth curves). This gives $b$ a singular normal "prior" with inverse covariance proportional to $\Delta^\top\Delta$, written out for both orders; the matrix for order 2 is the $D_2^\top D_2$ of deck 21.

**18.4 Penalized likelihood approach (p. 481).** Dropping constants, the joint log-likelihood is minus a penalized sum of squares: residual sum of squares plus $\lambda\,b^\top\Delta^\top\Delta b$, a **roughness penalty**. Pawitan stresses a difference in philosophy: a penalty is usually chosen for convenience, whereas a random-effects model is an assumption that can be checked. The order of differencing (using the wrong order makes the differences autocorrelated) and normality (a quadratic penalty cannot follow jumps) are both modelling choices.

**18.5 Estimate of f given σ² and σ_b² (p. 482).** The mixed-model equations give $\hat f=S_\lambda\bar y$ with $S_\lambda=(W+\lambda\Delta^\top\Delta)^{-1}W$, $W$ the diagonal matrix of bin counts. Rows of $S_\lambda$ sum to one; $\lambda=0$ returns the raw means; the degrees of freedom $\mathrm{tr}(S_\lambda)$ measure complexity and allow like-with-like comparisons of smoothers. The system is banded, so it is fast to solve.

**18.6 Estimating the smoothing parameter (p. 485).** Estimate $\sigma^2$ and $\sigma_b^2$ with the iterative variance-component algorithm of Section 17.5. On the SO₂ data, first differences give about 5.4 degrees of freedom and some spurious wiggles; second differences give about 3.6, close to a quadratic fit, and a lower AIC. **Generalized cross-validation** chooses a similar amount of smoothing.

**18.7 Prediction intervals (p. 489).** Pointwise intervals $\hat f_i\pm1.96\,\mathrm{se}$ from the information matrix of $b$.

**18.8 Partial linear models (p. 489).** $\mathrm E(y)=x^\top\beta+f(u)$ is again a mixed model: one smooth term plus parametric effects, the simplest GAM.

**18.9 Smoothing nonequispaced data\* (p. 490).** Without binning, write $f(x)=\sum_j b_jK_j(x)$ with basis functions: powers (numerically poor at high degree), Lagrange polynomials (Chebyshev points) or **B-splines** (local support). A derivative penalty $\lambda\int\{f^{(d)}(x)\}^2dx$ becomes a quadratic form $\lambda\,b^\top Pb$, and $\hat b=(Z^\top Z+\lambda P)^{-1}Z^\top y$.

**18.10 Non-Gaussian smoothing (p. 492).** The GLMM machinery of 17.10 (IWLS plus the same penalty): surgical mortality vs age (Section 6.2 data), with bands built on the logit scale.

**18.11 Nonparametric density estimation (p. 497).** Smoothing a fine histogram is Poisson smoothing of the counts, free of the kernel's boundary bias.

**18.12 Nonnormal smoothness condition\* (p. 500).** Heavy-tailed differences allow jumps in $f$.

## Key results to know
1. Linear smoother: $\hat f=Sy$, rows of $S$ sum to 1, $\mathrm{edf}=\mathrm{tr}(S)$. Kernel (Nadaraya–Watson): $\hat f(x)=\sum_iK_h(x_i-x)y_i/\sum_iK_h(x_i-x)$.
2. Smoothness prior: $D_db\sim N(0,\sigma_b^2I)$, where $D_d$ is the difference matrix of order $d$ (Pawitan's $\Delta$, with $R^{-1}=\Delta^\top\Delta$).
3. Penalized least squares with one observation per grid point: minimise $\lVert y-f\rVert^2+\lambda\lVert D_df\rVert^2$, so $\hat f=(I+\lambda D_d^\top D_d)^{-1}y$, with $\lambda=\sigma^2/\sigma_b^2$. This is a P-spline with $B=I$ (Whittaker's smoother).
4. Binned data: $\hat f=(W+\lambda D_d^\top D_d)^{-1}W\bar y$.
5. Choosing $\lambda$: variance-component estimation (ML/REML), or $\mathrm{GCV}(\lambda)=\mathrm{RSS}/(N-\mathrm{edf})^2$ (the deck multiplies by $n$; same minimiser); $\hat\sigma^2=\mathrm{RSS}/(N-\mathrm{edf})$; $\mathrm{AIC}=N\log\hat\sigma^2+2\,\mathrm{edf}$.
6. Pointwise standard errors: $\mathrm{Var}(\hat f\mid\text{variances})\approx\sigma^2(W+\lambda D_d^\top D_d)^{-1}$.

## Connect to class
- **Session 20:** deck frames "Think locally" (bins, kNN, kernels), "The Nadaraya–Watson kernel smoother", "Every smoother today is linear", "Effective degrees of freedom" and the GCV frames; `20-local-smoothers.Rmd` and `20-smoother-matrix-cv.Rmd`. Pawitan does not cover local linear regression or LOESS (see Faraway Ch. 9 and Cleveland, 1979), nor the bias–variance formulas of the deck.
- **Session 21:** the difference matrices, $D_2^\top D_2$, the P-spline estimator and the frame "Preview: penalized splines are mixed models"; Section 18.9 is the B-spline version. Compare with the Eilers & Marx (1996) summary.
- **Sessions 22–27:** GCV and AIC for $\lambda$ (Lab 05), partial linear models and GAMs (Sessions 23–26), smoothing parameters as variance components (REML, `gamm()`, Session 27).

## Read carefully / safe to skim
- **Read carefully:** introduction and 18.1 (Session 20); 18.3–18.6 (Session 21, to see why $\lambda=\sigma^2/\sigma_b^2$).
- **Skim:** the advantages list in 18.2, the numerical algorithms in 18.5, 18.7–18.8, 18.10–18.12; 18.9 is short and worth a look before Session 21.

## Check yourself
1. Why is the partition (bin) estimator biased when bins are wide and noisy when they are narrow? Which quantity plays the same role for kNN and for kernels?
2. Show that the rows of $S_\lambda=(W+\lambda D_d^\top D_d)^{-1}W$ sum to one. (Hint: $D_d\mathbf 1=0$.)
3. Explain in words why $\lambda=\sigma^2/\sigma_b^2$: what happens to the fit when the random-walk variance $\sigma_b^2$ is small compared with the noise?
4. Pawitan says over- or under-differencing is a model misspecification. What happens to the second differences if the true $b$ is a first-order random walk?
5. On the SO₂ data, the second-difference smoother has about 3.6 degrees of freedom. What parametric model is it close to, and why is that reassuring?
