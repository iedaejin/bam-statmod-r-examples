# Session 22 — Exercises

**Topic:** Smoothing and splines in practice (after Lab 05)
**Course:** Statistical Modelling (BAM), Spring 2027

These tasks extend the lab. Exercises 1–3 use R on `MASS::mcycle`; exercise 4 is a pencil-and-paper problem in exam style. They replace the separate "exercises on smoothing" session of the old plan (folder `extras/25-exercises-smoothing/`).

---

**Exercise 1 (weighted P-spline).** Using `22-heteroscedasticity.Rmd`:
(a) Fit the unweighted P-spline (20 segments, cubic, $d = 2$, $\lambda$ by GCV), estimate $\sigma(x)$ by $\sqrt{\pi/2}$ times a smoothing spline (`df = 6`) of the absolute residuals, and refit with weights $w_i = 1/\hat\sigma^2(x_i)$, choosing $\lambda$ by GCV for the weighted criterion $\sum_i w_i(y_i - f_i)^2 + \lambda\lVert D_2\theta\rVert^2$.
(b) Report the edf of both fits and the standard deviation of the standardized residuals $(y_i - \hat f_i)/\hat\sigma(x_i)$ for $t \le 15$, $15 < t \le 40$ and $t > 40$.
(c) Derive the weighted P-spline estimator $\hat\theta = (B^\top WB + \lambda D^\top D)^{-1}B^\top Wy$ and explain why the weighted fit uses more effective df.

**Exercise 2 (repeated cross-validation).** Repeat the shuffled 10-fold CV for the LOESS span (spans $0.15, 0.175, \dots, 0.60$) with seeds $1, \dots, 20$.
(a) Tabulate the chosen span across seeds.
(b) Which span minimizes the CV curve averaged over the 20 repetitions?
(c) Explain in two sentences why a single CV split is a noisy basis for choosing a tuning constant.

**Exercise 3 (ties and leave-one-out CV).** `mcycle` has 28 times that occur more than once.
(a) For the P-spline with $\lambda$ on the grid $\log_{10}\lambda = -2, -1.95, \dots, 2$, compute ordinary LOOCV with the shortcut $(y_i - \hat f_i)/(1 - S_{ii})$, and grouped CV that leaves out **all** observations sharing a time at once (refit for each of the 94 groups).
(b) Compare the selected edf and the minimum CV error. Which is larger, and why?

**Exercise 4 (exam style).** A LOESS fit with `span = 0.3`, `degree = 2` is used on $n = 133$ observations.
(a) How many observations are in each local window?
(b) Write the local weighted least squares problem solved at a target point $x_0$ and show that the fitted value is $e_1^\top(X_0^\top W_0X_0)^{-1}X_0^\top W_0y$.
(c) Explain why the LOOCV shortcut is not exact for LOESS, although it is exact for a P-spline.
(d) The fit has `trace.hat` $= 12.44$ and RSS $= 60\,673$. Compute GCV and compare it with a P-spline with edf 11.38 and RSS 62 608.
