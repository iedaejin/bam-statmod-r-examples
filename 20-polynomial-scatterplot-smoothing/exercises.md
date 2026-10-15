# Session 20 — Exercises

**Topic:** Polynomial regression and scatterplot smoothing
**Course:** Statistical Modelling (BAM), Spring 2027

Notation: smoother $\hat{\boldsymbol f} = S y$, effective degrees of freedom $\mathrm{edf} = \mathrm{tr}(S)$, bandwidth $h$, $K_h(u) = K(u/h)/h$.

---

**Exercise 1 (orthogonal polynomials by hand).** Let $x = (-1, 0, 1)$ and $y = (1, 0, 3)$.

(a) Apply Gram–Schmidt to the columns $1, x, x^2$ (evaluated at the data) and show that the normalized columns orthogonal to $\mathbf 1$ are $Q_1 = x/\sqrt2$ and $Q_2 = (3x^2 - 2)/\sqrt6$.
(b) Fit $y = \gamma_0 + \gamma_1 Q_1 + \gamma_2 Q_2 + \varepsilon$ by least squares. Show that $\hat\gamma_0 = \bar y$ and $\hat\gamma_k = Q_k^\top y$.
(c) Convert $(\hat\gamma_0, \hat\gamma_1, \hat\gamma_2)$ exactly into the raw coefficients $(\hat\beta_0, \hat\beta_1, \hat\beta_2)$ of $1, x, x^2$, and check that the fitted quadratic interpolates the three points.
(d) Are $Q_1$ and $Q_2$ uncorrelated? Are they independent? Explain.

**Exercise 2 (leverage at the boundaries).** For the design $x = (1, 2, 3, 4, 5)$:

(a) For the straight-line fit, show that $h_{ii} = 1/n + (x_i - \bar x)^2/S_{xx}$ and compute all five leverages.
(b) For the quadratic fit the leverages are $(0.886, 0.371, 0.486, 0.371, 0.886)$. Check that they sum to the right number.
(c) Use (a) and (b) to explain, with $\mathrm{Var}(\hat y_i) = \sigma^2 h_{ii}$, why polynomial fits are least reliable at the ends of the data and get worse as the degree increases.

**Exercise 3 (a kernel smoother by hand).** Data: $x = (0, 1, 2, 4, 5)$, $y = (1, 3, 2, 6, 8)$. Use the uniform kernel: all points with $|x - x_j| \le h$ get equal weight, with $h = 1.5$.

(a) Write down the $5\times5$ smoother matrix $S$ and the fitted values.
(b) Compute $\mathrm{edf} = \mathrm{tr}(S)$.
(c) Compute the five leave-one-out residuals with the shortcut $(y_i - \hat f_i)/(1 - S_{ii})$ and check the first one by refitting without observation 1.
(d) Compute LOOCV and $\mathrm{GCV} = n\,\mathrm{RSS}/(n - \mathrm{edf})^2$.
(e) Evaluate $\hat f(3)$. What happens to $\hat f(3)$ if $h = 0.9$?

**Exercise 4 (boundary bias of Nadaraya–Watson).** Let $x_j = 0, 1, \dots, 10$ and suppose the data have no noise: $y_j = f(x_j) = x_j$.

(a) With the uniform kernel and $h = 3$, compute the Nadaraya–Watson estimate at $x = 0$ and at $x = 5$. What is the bias at each point?
(b) Show that the local linear estimator with the same kernel and $h$ has zero bias at both points. (Hint: local linear reproduces straight lines exactly; prove it.)
(c) How does the bias at $x = 0$ scale with $h$? Compare with the $O(h^2)$ interior bias.

**Exercise 5 (the leave-one-out shortcut).**

(a) Prove that for the Nadaraya–Watson smoother $y_i - \hat f^{(-i)}(x_i) = (y_i - \hat f_i)/(1 - S_{ii})$.
(b) Give a four-point example showing that the same identity fails for the kNN running mean with $k = 2$ (the point itself plus its nearest neighbour).
(c) Show that if all $S_{ii}$ are equal, LOOCV and GCV coincide.

**Exercise 6 (the bin smoother is a projection).** Partition the range of $x$ into bins and let $\hat f_i$ be the mean of the $y$'s in the bin of $x_i$.

(a) Show that $S = Z(Z^\top Z)^{-1}Z^\top$, where $Z$ is the $n \times B$ indicator matrix of the $B$ non-empty bins.
(b) Deduce that $S$ is symmetric and idempotent, and that $\mathrm{edf} = B$.
(c) For `mcycle` with 5 ms bins on $[0, 60]$, what is the edf? Verify in R.

**Exercise 7 (R: comparing smoothers on `mcycle`).** Use `MASS::mcycle`.

(a) Fit a local linear smoother with a Gaussian kernel (code from `20-smoother-matrix-cv.Rmd`) and choose $h$ on the grid $0.50, 0.51, \dots, 5.00$ by GCV. Report $h$, edf and GCV.
(b) Find the LOESS span (degree 2) whose `trace.hat` is as close as possible to the edf in (a). Report the span, its $\mathrm{tr}(S)$, RSS and GCV.
(c) Which smoother fits better at (almost) equal complexity? Why is the comparison in (b) only approximate?
(d) Fit LOESS with the same span but `degree = 1`. What happens to $\mathrm{tr}(S)$, and what does this tell you about comparing smoothers by their tuning constant?
