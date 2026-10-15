# Wood (2017), Ch. 4 — Introducing GAMs

**Session(s):** 23 (also useful for 21)  ·  **Source:** Wood, *Generalized Additive Models: An Introduction with R*, Chapman & Hall/CRC. Summarised from the 1st edition (2006), Ch. 3, pp. 119–140; in the 2nd edition (2017) this is Ch. 4.
**Reading time:** ~60 min (longer if you run the code, which is recommended)  ·  **Level:** core

## Why read it

How do we replace $\beta_jx_j$ in a linear predictor by an unknown smooth function and still fit the model with tools we already have? The chapter answers by having you build a GAM yourself in a few lines of R: a basis, a penalty, cross-validation for the smoothing parameter, then additive models and a Gamma GAM. It shows the whole framework with almost no theory. The theory is in the next chapter (see the [GAM theory summary](../24-gams-theory/24-wood-ch6-summary.md)).

## The big idea

Once you choose a basis, a smooth term is just some extra columns of a model matrix. Fitting the model with a quadratic "wiggliness" penalty, weighted by a smoothing parameter $\lambda$, controls how flexible the curve is. Choosing $\lambda$ by (generalized) cross-validation makes the amount of smoothing data-driven. A GAM is then a penalized GLM, fitted by penalized IRLS.

## Section by section

(Topics follow the book's section titles; section numbers differ between editions.)

**Introduction.** The model is $g(\mu_i)=X_i^*\theta+f_1(x_{1i})+f_2(x_{2i})+f_3(x_{3i},x_{4i})+\dots$ with an exponential-family response. Two new problems arise: how to *represent* the $f_j$, and how smooth to make them.

**Univariate smooth functions.**

- *Regression splines:* choosing a basis turns $y_i=f(x_i)+\varepsilon_i$ into a linear model. A polynomial basis is shown first; its weaknesses over a whole interval are left to an exercise. Then comes a cubic spline basis on $[0,1]$, written with an explicit kernel function $R(x,z)$ (following Gu, 2002). It is fitted by `lm()` to engine wear against engine size for 19 Volvo engines, using arbitrary knots.
- *Penalized regression splines:* choosing the number of knots by testing is awkward because the models are not nested. Instead, keep a generous basis and add $\lambda\int f''(x)^2dx=\lambda\beta^\top S\beta$ to the least-squares objective. The penalized fit can be computed with `lm()` on data augmented by $\sqrt\lambda$ times a square root of $S$ (with zeros added to $y$). Three values of $\lambda$ show oversmoothing and undersmoothing.
- *Choosing $\lambda$ by cross-validation:* aim for a fit close to the true $f$. Leave-one-out cross-validation estimates the prediction error, does not need $n$ refits, and has the generalised version GCV. A grid search over $\lambda$ picks the GCV-optimal engine-wear fit.

**Additive models.** For $y_i=f_1(x_i)+f_2(z_i)+\varepsilon_i$, each $f_j$ is identified only up to an additive constant, so a constraint is needed. Here it is imposed by dropping the second smooth's constant column. Each smooth has its own penalty matrix and smoothing parameter, and the fit is again augmented least squares. With the `trees` data (Volume on Girth and Height), a 2-D GCV grid search gives a curved Girth effect and a Height effect with a very large $\lambda$, which is essentially a straight line.

**Generalized additive models.** Penalized likelihood cannot be turned into an equivalent unpenalized GLM, so the fit uses penalized IRLS (P-IRLS): IRLS with a penalty in each weighted least-squares step. For a log-link Gamma model of tree volume the weights are all 1 and the working response is simple. The GCV score of the final working model is used to choose $\lambda$, and the same grid search is reused.

**Summary.** Everything later in the book (other bases, smooths of several variables, more smoothing parameters, other families) is a refinement of this framework, not a new idea.

## Key results to know

1. Basis expansion: $f(x)=\sum_{j=1}^{q}b_j(x)\beta_j$, so $f=X\beta$ and the model is linear in $\beta$.
2. Penalty: $\int f''(x)^2dx=\beta^\top S\beta$. Wood's $S$ is the *penalty* matrix. For P-splines (Session 21), $S=D_d^\top D_d$.
3. $\hat\beta=(X^\top X+\lambda S)^{-1}X^\top y$, influence matrix $A=X(X^\top X+\lambda S)^{-1}X^\top$, $\mathrm{edf}=\operatorname{tr}(A)$. $A$ is the smoother matrix that Sessions 20–22 call $S_\lambda$.
4. Augmented least squares, with $B^\top B=S$:

   $$\left\lVert \begin{pmatrix}y\\ 0\end{pmatrix}-\begin{pmatrix}X\\ \sqrt\lambda\, B\end{pmatrix}\beta\right\rVert^2=\lVert y-X\beta\rVert^2+\lambda\beta^\top S\beta .$$

5. OCV: $\mathcal V_o=\frac1n\sum_i (y_i-\hat f_i)^2/(1-A_{ii})^2$. GCV: $\mathcal V_g=n\sum_i(y_i-\hat f_i)^2/\{n-\operatorname{tr}(A)\}^2$.
6. Additive model: minimise $\lVert y-X\beta\rVert^2+\lambda_1\beta^\top S_1\beta+\lambda_2\beta^\top S_2\beta$, with one $\lambda_j$ per smooth, written once.
7. P-IRLS step: minimise $\lVert\sqrt W(z-X\beta)\rVert^2+\sum_j\lambda_j\beta^\top S_j\beta$.

## Connect to class

- **Session 21** derives penalized splines with B-splines and difference penalties (Eilers & Marx). Wood uses a different cubic spline basis and the integrated second-derivative penalty, but the estimator, the augmented-data trick, edf and GCV are the same ideas. One chapter exercise smooths the `mcycle` data used in Lab 05.
- **Session 23** uses `airquality` and goes further than this chapter in three ways:
  - *Centring.* The slides centre every smooth so that $\hat\beta_0=\bar y$. The book's drop-a-column constraint is a cruder version of the same idea; centring as `mgcv` does it is in the GAM-theory chapter.
  - *Backfitting.* The slides derive backfitting. In the 1st edition backfitting is not here but in the GAM-theory chapter, under other approaches to GAMs.
  - *`mgcv`.* The slides fit with `mgcv::gam()`. The 1st-edition chapter builds everything by hand; `mgcv` comes later ([mgcv summary](../26-lab-gams/26-wood-ch7-summary.md)). According to the course reading list, the 2nd edition ends this chapter with a first look at `mgcv`.
- **Smoothness selection:** the book uses GCV only. The course fits with `method = "REML"`. The `mgcv` default is still `"GCV.Cp"`, which can undersmooth (Session 24).
- The Gamma log-link GAM for `trees` mirrors the Session 23 slide "Gamma GAM with a log link" on ozone.

## Read carefully / safe to skim

**Read carefully:** penalized regression splines (including the augmented-data trick), the cross-validation argument, the identifiability problem in additive models, and the P-IRLS scheme.
**Safe to skim:** the explicit form of $R(x,z)$ (you will not need to memorise it), the plotting code, and the polynomial-basis illustration.

## Check yourself

1. Show that minimising $\lVert y-X\beta\rVert^2+\lambda\beta^\top S\beta$ gives $\hat\beta=(X^\top X+\lambda S)^{-1}X^\top y$.
2. Why does choosing $\lambda$ to minimise the residual sum of squares always fail? What does cross-validation do differently?
3. In $y=f_1(x)+f_2(z)+\varepsilon$, explain the identifiability problem and two ways to remove it.
4. What happens to the fitted curve and to $\operatorname{tr}(A)$ as $\lambda\to\infty$ with a second-derivative penalty? And as $\lambda\to0$?
5. Write the P-IRLS working response and weights for a Gamma GAM with log link, and explain why the weights are constant.
