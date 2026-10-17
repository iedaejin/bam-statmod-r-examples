# Session 21 — Exercises

**Topic:** Splines, smoothing splines and P-splines
**Course:** Statistical Modelling (BAM), Spring 2027

Notation: knots $\kappa_k$ (B-spline knot sequence $t_j$), spline degree $q$, B-spline basis $B$ with $c$ columns, difference matrix $D_d$, smoothing parameter $\lambda$, $S_\lambda = B(B^\top B + \lambda D_d^\top D_d)^{-1}B^\top$, $\mathrm{edf} = \mathrm{tr}(S_\lambda)$.

---

**Exercise 1 (truncated powers).**
(a) Show that $g(x) = (x - \kappa)_+^3$ has continuous first and second derivatives at $x = \kappa$ and that its third derivative jumps by $6$ there.
(b) A cubic spline with $K$ knots is a cubic polynomial on each of the $K + 1$ intervals, with $f, f', f''$ continuous at each knot. Count parameters minus constraints to show that the space has dimension $K + 4$, and check that the truncated power basis has exactly that many functions.
(c) Why does a regression spline with the truncated power basis give the same fitted values as `lm(y ~ bs(x, knots = ...))`, but a very different condition number?

**Exercise 2 (Cox–de Boor by hand).** Integer knots $t_j = j$.
(a) Use the recursion to compute all non-zero B-splines of degree 1 and degree 2 at $x = 2.25$.
(b) Check that the values sum to one at each degree.
(c) Prove, by induction on $q$ and using the recursion, that $\sum_j B_{j,q}(x) = 1$ for $x$ in the interior of the knot range.

**Exercise 3 (natural splines and the smoothing-spline theorem).**
(a) Show that a natural cubic spline with $K$ knots has $K$ free parameters.
(b) In the proof that the smoothing spline is a natural cubic spline, where exactly is the "natural" boundary condition $s''(x_1) = s''(x_m) = 0$ used? What would go wrong with an ordinary cubic interpolating spline?
(c) Explain why the smoothing-spline fit with $\lambda \to \infty$ is the least squares straight line.

**Exercise 4 (a P-spline you can invert by hand).** Take the identity basis $B = I_3$ (one coefficient per observation, the "Whittaker smoother"), data $y = (1, 4, 1)$ and $\lambda = 1$.
(a) For $d = 1$, write $D_1$ and $D_1^\top D_1$, compute $\hat\beta = (I + \lambda D_1^\top D_1)^{-1}y$ and $\mathrm{edf}$.
(b) Repeat for $d = 2$.
(c) In both cases check which "moments" $\sum_j j^k\hat\beta_j = \sum_j j^k y_j$ are conserved, and explain why with the moment property.
(d) What are the limits of the edf as $\lambda \to 0$ and $\lambda \to \infty$ for $d = 1$ and $d = 2$?

**Exercise 5 (edf is between $d$ and $c$ and decreases with $\lambda$).** Assume $B$ has full column rank $c$ and write $B^\top B = R^\top R$ (Cholesky).
(a) Show that $\mathrm{edf}(\lambda) = \mathrm{tr}\{(I_c + \lambda M)^{-1}\}$ with $M = R^{-\top}D_d^\top D_dR^{-1}$.
(b) Using the eigenvalues $s_1, \dots, s_c \ge 0$ of $M$, show that $\mathrm{edf}(\lambda) = \sum_k 1/(1 + \lambda s_k)$.
(c) Deduce that edf is decreasing in $\lambda$, tends to $c$ as $\lambda \to 0$ and to $d$ as $\lambda \to \infty$. (Hint: how many $s_k$ are zero?)
(d) Is $S_\lambda$ a projection matrix? Prove or disprove using (b).

**Exercise 6 (GCV and AIC by hand).** A P-spline (20 segments, cubic, $d = 2$) is fitted to `mcycle` ($n = 133$) for three values of $\lambda$:

| $\lambda$ | edf | RSS |
|---:|---:|---:|
| 0.01 | 19.656 | 59 960.2 |
| 0.64 | 11.383 | 62 608.1 |
| 100 | 4.428 | 159 757.4 |

(a) Compute $\mathrm{GCV}(\lambda) = n\,\mathrm{RSS}/(n - \mathrm{edf})^2$ and $\mathrm{AIC}(\lambda) = n\log(\mathrm{RSS}/n) + 2\,\mathrm{edf}$ for each row.
(b) Which $\lambda$ do both criteria prefer? Why does the smallest RSS not win?
(c) Estimate $\sigma$ at the chosen $\lambda$.

**Exercise 7 (when polynomial reproduction fails).**
(a) Linear B-splines ($q = 1$) on the knots $-1, 0, 1, 3, 4, 5$ have their peaks at $0, 1, 3, 4$. Show that the coefficients that represent $f(x) = x$ on $[0, 4]$ are $\beta = (0, 1, 3, 4)$.
(b) Compute $D_2\beta$. Does a P-spline with $d = 2$ on these knots reproduce a straight line for every $\lambda$? Which condition of the property is violated?
(c) With equally spaced knots, cubic B-splines and $d = 3$, which polynomials are reproduced? Which are not if you use linear B-splines and $d = 3$, and why?

**Exercise 8 (R: is the number of segments important?).** Use `bbase()` and `psfit()` from `21-bsplines-psplines.Rmd` on `mcycle`.
(a) For `nseg` $= 10, 20, 40$ choose $\lambda$ by GCV (use `optimize()` over $\log_{10}\lambda \in [-4, 6]$). Report $\log_{10}\hat\lambda$, edf and GCV.
(b) With `nseg = 20`, compare $d = 1, 2, 3$ in the same way.
(c) Comment: what controls the smoothness of a P-spline once the basis is rich enough? Does the penalty order matter much here?
(d) Check one of your fits against `mgcv::gam(accel ~ s(times, bs = "ps", k = ncol(B)), knots = list(times = <your knots>), method = "GCV.Cp")`.
