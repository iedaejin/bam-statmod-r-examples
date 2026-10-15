# Faraway (2014), Ch. 9 — Transformation

**Session(s):** 20 (also useful for 6–8 and 21)  ·  **Source:** Faraway, *Linear Models with R*, 2nd ed., Chapman & Hall/CRC, Ch. 9, pp. 133–147  
**Reading time:** ~45 min (~25 min for 9.3–9.6 only)  ·  **Level:** core (9.3–9.5); optional (9.1–9.2, 9.6–9.7)

## Why read it

Session 20 opens the smoothing block with a simple observation: a polynomial in $x$ is still a linear model. This chapter is where Faraway makes that step, moving from transforming the response, to replacing a predictor by several functions of it (broken sticks, polynomials, splines), to additive models. It is the bridge from the linear-model block to Sessions 20–23.

## The big idea

"Linear" refers to the parameters. Replacing $x$ by a set of **basis functions** $b_1(x),\dots,b_K(x)$ and fitting $y=\sum_k\beta_kb_k(x)+\varepsilon$ by least squares gives flexible curves with all the machinery of Sessions 5–8. The choice of basis matters: polynomials are smooth but **global** (every point affects the whole curve), piecewise-linear "hockey sticks" are **local** but kinked, and B-splines combine smoothness with local influence. Smoothing splines replace the choice of knots by a roughness penalty with a tuning parameter $\lambda$, and additive models do this for several predictors at once.

## Section by section

**9.1 Transforming the Response (p. 133).** A model for $\log y$ means multiplicative errors on the original scale; additive errors on the original scale with an exponential mean would need nonlinear (or weighted) regression. Back-transform predictions and interval endpoints (asymmetric intervals, no negative predictions). With a log response, $e^{\beta_j}$ is a multiplicative effect, and a small $\beta_j$ is roughly a $100\beta_j\%$ change. **Box–Cox** chooses a power $\lambda$ by maximising a profile log-likelihood; the likelihood-ratio interval for $\lambda$ tells you whether a transformation is needed (`savings`: no) and how far you may round it for interpretability (`gala`: cube or square root). Caveats: sensitive to outliers, needs $y>0$, little effect when $\max y/\min y$ is small. The shifted log family $\log(y+\alpha)$ (`logtrans`, `leafburn` data), the logit for proportions and Fisher's $z$ for correlations are mentioned. (Do not confuse this $\lambda$ with the smoothing parameter below.)

**9.2 Transforming the Predictors (p. 137).** Box–Cox-style searches or partial residual plots replace $x$ by one $f(x)$; the following sections instead replace $x$ by **several** terms, each with its own coefficient.

**9.3 Broken Stick Regression (p. 137).** `savings` again: countries with `pop15` above and below 35% look different. Separate fits do not meet at 35. Two "hockey-stick" basis functions, $B_l(x)=(c-x)_+$ and $B_r(x)=(x-c)_+$, with knot $c=35$, force continuity with three parameters instead of four; the intercept is the fitted value at the knot. This is a linear spline. More knots means more basis functions; estimating the knot location makes the model nonlinear (`segmented` package).

**9.4 Polynomials (p. 139).** $y=\beta_0+\beta_1x+\dots+\beta_dx^d+\varepsilon$. Choose $d$ by adding terms until the new one is not significant, or by removing from a large $d$ (on `ddpi`: quadratic). Keep lower-order terms when a higher-order term is in the model: shifting $x$ (e.g. `ddpi - 10`) changes the significance of the linear term but not of the quadratic one, so dropping the linear term would depend on an arbitrary origin. **Orthogonal polynomials** (`poly()`) give columns with $z_i^\top z_j=0$, which avoids refitting and numerical instability; one fit with `poly(ddpi, 4)` gives the same conclusion. Multivariate polynomials (`polym`) give response-surface models, shown as a perspective plot.

**9.5 Splines (p. 141).** Simulated data from a curve with flat and wiggly parts: an orthogonal polynomial of degree 4 underfits, degree 12 is too wiggly in one region and misses an inflection. Cubic **B-splines** (`splines::splineDesign`, with repeated boundary knots and more knots where the curve bends) fit closely with the same 12 parameters, because each basis function is a piecewise cubic, nonzero over only a few knot intervals, and smooth at the knots. Then **smoothing splines**: minimise a penalised criterion whose second term measures roughness; $\lambda$ trades fit against smoothness, chosen by cross-validation in `smooth.spline()`. The default fit catches the inflection but is too rough in the flat part.

**9.6 Additive Models (p. 144).** $y=\alpha+f_1(X_1)+\dots+f_p(X_p)+\varepsilon$ chooses all transformations at once. `mgcv::gam` on `savings`: `dpi` and `ddpi` come out linear, `pop75` nearly so, `pop15` suggests a minimum near 38% but the bands are wide.

**9.7 More Complex Models (p. 145).** For explanation or small samples, interpretable linear models compete well; for large-sample prediction, machine-learning methods may do better.

## Key results to know

1. Box–Cox: $g_\lambda(y)=(y^\lambda-1)/\lambda$ for $\lambda\ne0$, $\log y$ for $\lambda=0$; profile log-likelihood $L(\lambda)=-\tfrac n2\log(\mathrm{RSS}_\lambda/n)+(\lambda-1)\sum_i\log y_i$; CI: $\{\lambda:L(\lambda)>L(\hat\lambda)-\tfrac12\chi^2_{1,1-\alpha}\}$.
2. Hockey-stick (linear spline) basis with knot $c$: $(c-x)_+$, $(x-c)_+$.
3. Polynomial regression is $y=X\beta+\varepsilon$ with $X=[1,x,\dots,x^d]$; `poly(x, d)` spans the same column space, so fitted values are identical.
4. Hierarchy: do not drop $x$ while keeping $x^2$ (the model would not be invariant to $x\to x+a$).
5. Smoothing spline (course notation): minimise $\frac1n\sum_i\{y_i-f(x_i)\}^2+\lambda\int f''(x)^2\,dx$.
6. Additive model: $y=\alpha+\sum_jf_j(x_j)+\varepsilon$ (the starting point of Sessions 23–26).

## Connect to class

- **Session 20 deck**, *Polynomial regression*: polynomials as linear models, wild behaviour at the boundaries explained by leverage, and the distinction between numerical ill-conditioning (fixed by `poly()`) and statistical instability (not fixed). Faraway covers the first and the hierarchy point; the deck adds the leverage argument and the exact conversion from orthogonal to raw coefficients (`20-polynomial-regression.Rmd`). The deck's `poly()` columns are orthonormal; Faraway only says orthogonal.
- The deck's local smoothers (kernels, LOESS) are **not** in Faraway; read Pawitan Ch. 18 for those.
- **Session 21** takes up 9.5: B-splines, knots and penalties (P-splines, Eilers & Marx). Faraway lists "integrates to one over its support" among the defining properties; the B-splines that `splineDesign()` and `bs()` return are instead scaled so that at every $x$ they sum to one, the convention used in Session 21.
- 9.6 previews GAMs. Faraway's `gam()` call uses mgcv's default smoothing-parameter selection (GCV); in Sessions 23–26 we follow current mgcv advice and use `method = "REML"`.
- 9.1 (Box–Cox, log responses) is useful in Lab 02 and Session 8 when residual plots show a funnel.

## Read carefully / safe to skim

- **Read carefully:** 9.3, 9.4, 9.5.
- **Read once:** 9.1 (log interpretation and the Box–Cox idea), 9.6.
- **Safe to skim:** `logtrans`, the logit/Fisher-$z$ remarks, the perspective-plot code, 9.7.

## Check yourself

1. Write the design matrix for a broken-stick model with knot $c=35$ and three observations at $x=20,35,45$. Why does it have three columns, not four?
2. Show that if $y=\beta_0+\beta_2x^2$ and you shift $x\to x+a$, a linear term reappears. What does dropping the linear term assume?
3. Why do raw-power and orthogonal-polynomial fits of the same degree give identical fitted values but different coefficients?
4. Explain in words why a single unusual point near $x=0$ can change a degree-12 polynomial fit near $x=1$, but changes a cubic B-spline fit only nearby.
5. In the smoothing-spline criterion, what fit do you get as $\lambda\to0$ and as $\lambda\to\infty$?
