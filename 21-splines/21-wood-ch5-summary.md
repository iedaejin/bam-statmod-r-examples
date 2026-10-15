# Wood (2017), Ch. 5 — Smoothers

**Session(s):** 21 (also useful for 24 and 25)  ·  **Source:** Wood, *Generalized Additive Models: An Introduction with R*, Chapman & Hall/CRC. Summarised from the 1st edition (2006), Sec. 4.1 ("Smoothing bases"), pp. 141–163; in the 2nd edition (2017) this is Ch. 5.
**Reading time:** ~60 min  ·  **Level:** core (the tensor-product part is core for Session 25)

## Why read it

Which basis and which penalty should represent a smooth term, and why splines? The chapter explains why splines are the natural choice, and then catalogues the smoothers used in `mgcv`: cubic regression splines, cyclic splines, P-splines, thin plate regression splines, shrinkage smoothers and tensor products. It also discusses the basis dimension $k$. It is the reference behind every `bs = ` option you will use in Sessions 23–27.

## The big idea

A good smoother pairs a basis with a quadratic wiggliness penalty $\beta^\top S\beta$. Splines arise as *exact* solutions of penalized problems. Low-rank versions (penalized regression splines) keep most of their good properties at a fraction of the cost. The basis dimension only caps flexibility; the penalty decides how much flexibility is actually used.

## Section by section

(Topics follow the book's section titles; section numbers differ between editions.)

**Why splines?** Among all interpolants with square-integrable second derivative, the natural cubic spline through the points has the smallest $\int f''^2$. The proof, via integration by parts, is the one on the Session 21 slides. It follows that the function minimising $\sum_i\{y_i-f(x_i)\}^2+\lambda\int f''^2$ is a natural cubic spline with knots at the data: the smoothing spline. It is ideal but has $n$ parameters. A *penalized regression spline* uses a much smaller basis placed so that it covers the data.

**Cubic regression splines.** The spline is parameterised by its values at $k$ knots, so the coefficients are interpretable. Continuity conditions express the second derivatives at the knots in terms of those values, and the penalty becomes $\beta^\top D^\top B^{-1}D\beta$. No rescaling of $x$ is needed, but knots must be chosen. **Cyclic version:** value and first two derivatives match at the ends, which suits time of year.

**P-splines.** The B-spline basis has local support and is defined by the Cox–de Boor recursion (a short R function is given). Following Eilers & Marx (1996), a difference penalty acts directly on the coefficients, and `diff(diag(k), differences = d)` builds $D_d$. Any basis order can be combined with any penalty order. Drawbacks: uneven knots spoil the simplicity, and the penalty is harder to interpret in terms of the shape of the curve.

**Thin plate regression splines (TPRS).** Thin plate splines solve the smoothing problem in $d$ dimensions with a derivative penalty of order $m$ (requiring $2m>d$). They need no knots and are isotropic, but they have one parameter per data point. TPRS keep the unpenalized (null-space) polynomials and truncate the wiggly part to its leading $k$ eigenvectors. This truncation is optimal in a worst-case sense, and Lanczos iteration makes it cheap. A knot-based approximation is mentioned as a simpler alternative. TPRS is `mgcv`'s default `s()`.

**Shrinkage smoothers.** Ordinary penalties never remove the null space (for example the straight line). Adding a small multiple of the identity to $S$ lets a large $\lambda$ shrink the whole term to zero, which is useful for term selection (`bs = "ts"`, `"cs"`).

**Choosing the basis dimension.** A theoretical rate ($n^{2/9}$, Kim & Gu) exists, but in practice $k$ is part of model specification. Fits are fairly insensitive to $k$ as long as it is not too small. A subtle point: a larger $k$ contains more functions with a given edf, so the edf can change when $k$ grows.

**Tensor product smooths.** Isotropy is a problem when covariates have different units. A tensor product starts from marginal smooths and lets the coefficients of one smooth vary smoothly with the other covariate. Each model-matrix row is a Kronecker product of the marginal rows. The penalty has one term and one $\lambda$ per margin, which makes the smooth invariant to rescaling each covariate. After reparameterising the margins in terms of function values at knots, the penalty terms are Kronecker products with identities. A single product penalty $S_1\otimes S_2$ is a poor choice: its rank is too low, which leads to undersmoothing.

## Key results to know

1. Smoothing spline: $\hat f=\arg\min_f\sum_{i=1}^n\{y_i-f(x_i)\}^2+\lambda\int f''(x)^2dx$ is a natural cubic spline with knots at the $x_i$.
2. Any basis with a derivative penalty: $\int f''(x)^2dx=\beta^\top S\beta$, with $S$ positive semi-definite. Its null space is never penalized.
3. P-spline penalty: $\lambda\lVert D_d\beta\rVert^2=\lambda\beta^\top D_d^\top D_d\beta$. Wood indexes B-splines by $m$ with order $m+1$ ($m=2$ is cubic); the course uses degree.
4. TPRS: penalty order $m$ with $2m>d$; the null space consists of polynomials of degree $<m$, of dimension $\binom{m+d-1}{d}$ (three functions, $1,x_1,x_2$, for $m=d=2$).
5. Tensor product of $x$ and $z$: $X_i=X_{x,i}\otimes X_{z,i}$, penalty $\lambda_x\beta^\top(\tilde S_x\otimes I_L)\beta+\lambda_z\beta^\top(I_K\otimes\tilde S_z)\beta$.
6. edf $\le k-1$ for a centred `s(x, k)`; increasing $k$ raises only the ceiling.

## Connect to class

- **Session 21** follows the same route: truncated power basis, B-splines, natural splines, the smoothing-spline theorem, P-splines and $\mathrm{edf}=\operatorname{tr}(S_\lambda)$. The slides add polynomial reproduction and conservation of moments (Eilers & Marx), which the book does not cover, and check a hand-coded P-spline against `mgcv`'s `bs = "ps"`.
- **Session 24** relies on two points here: the penalty is a quadratic form whose null space survives $\lambda\to\infty$, and the role of $k$. The k-index of `gam.check()` is not in the 1st edition; it comes from later versions of `mgcv`. Follow the slides.
- **Session 25:** this is the theory of `te()`. Two current `mgcv` tools are absent from the 1st edition: `ti()` (pure interaction terms for an ANOVA decomposition) and `select = TRUE`. The 1st edition's term-selection device is the shrinkage bases `"ts"`/`"cs"`, which the slides mention as an alternative. The slides' warning about `s(x, z)` with covariates in different units is the book's isotropy argument.
- According to the course reading list, the 2nd-edition chapter also covers smooths as random effects (see the [GAMM summary](../27-gamms/27-wood-gamm-summary.md)) and checking the basis dimension.

## Read carefully / safe to skim

**Read carefully:** why splines (both proofs), P-splines, the idea of TPRS (what is kept and what is truncated), choosing the basis dimension, and tensor-product bases and penalties.
**Safe to skim:** the cubic regression spline matrix definitions, the thin-plate kernel formula, the TPRS optimality argument and Lanczos remarks, and the knot-based approximation.

## Check yourself

1. Reproduce the integration-by-parts step that shows $\int g''h''=0$ when $g$ is the natural cubic interpolant and $h=f-g$ vanishes at the knots.
2. Write $D_2$ for $k=5$ coefficients and the penalty $\beta^\top D_2^\top D_2\beta$. Which coefficient sequences have zero penalty?
3. Why is an isotropic smooth of (temperature, wind speed) problematic, and how does a tensor product fix it?
4. A tensor product of two rank-5 margins has how many coefficients? Why would a single penalty $S_x\otimes S_z$ undersmooth?
5. Explain in words why raising $k$ can change the estimated edf even when the old edf was far below $k-1$.
