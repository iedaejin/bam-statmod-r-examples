# Session 24 — Exercises

**Course:** Statistical Modelling (BAM), Spring 2027 · Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Exercises 1–6 are by hand; 7–8 use R (`mgcv`).

### Exercise 1 (penalty matrix)
Let $f(x)=\beta_0+\beta_1x+\beta_2x^2+\beta_3x^3$ on $[0,1]$.
(a) Find the $4\times4$ matrix $S$ with $\int_0^1 f''(x)^2dx=\boldsymbol\beta^\top S\boldsymbol\beta$.
(b) Find the null space of $S$ and interpret it.
(c) What does the penalized fit converge to as $\lambda\to\infty$?

### Exercise 2 (PIRLS for a Poisson GAM)
For $y_i\sim\text{Poisson}(\mu_i)$, $\log\mu_i=\boldsymbol X_i\boldsymbol\beta$ and penalty $\tfrac12\boldsymbol\beta^\top S_\lambda\boldsymbol\beta$:
(a) Write the penalized log-likelihood, its gradient and its (expected) Hessian.
(b) Show that one Newton step is $\boldsymbol\beta^{\text{new}}=(X^\top WX+S_\lambda)^{-1}X^\top W\boldsymbol z$ and give $W$ and $\boldsymbol z$ explicitly.
(c) Why is Newton's method the same as Fisher scoring here?

### Exercise 3 (leave-one-out identity)
Let $\hat{\boldsymbol f}=A\boldsymbol y$ with $A=X(X^\top X+S_\lambda)^{-1}X^\top$, and let $\hat f^{[-i]}_i$ be the prediction at $x_i$ from the fit without observation $i$ (same $\lambda$).
(a) Show that $y_i-\hat f_i^{[-i]}=(y_i-\hat f_i)/(1-A_{ii})$. *Hint:* fit the model to $\boldsymbol y^*$ equal to $\boldsymbol y$ except $y^*_i=\hat f_i^{[-i]}$.
(b) Deduce the formula for $\mathcal V_o$ and explain how GCV is obtained from it.

### Exercise 4 (GCV and UBRE by hand)
A Gaussian GAM is fitted with two values of $\lambda$ to $n=111$ observations: (i) RSS $=36.0$, $\operatorname{tr}(A)=6.0$; (ii) RSS $=34.5$, $\operatorname{tr}(A)=8.0$.
(a) Compute the GCV score of each fit. Which $\lambda$ does GCV prefer?
(b) Suppose $\sigma^2=0.30$ is known. Compute UBRE for each fit. Which is preferred?
(c) Show that $E(\mathcal V_u)$ equals the risk $\frac1n E\lVert\boldsymbol\mu-A\boldsymbol y\rVert^2$.

### Exercise 5 (identifiability constraints)
B-spline bases satisfy $\sum_kB_k(x)=1$ for every $x$.
(a) Show that $[\mathbf 1,B]$ is rank deficient.
(b) With $C=\mathbf 1^\top B$, describe how to build $Z$ with $CZ=0$ from a QR decomposition of $C^\top$, and show that $\mathbf 1^\top BZ\boldsymbol\beta^*=0$ for every $\boldsymbol\beta^*$.
(c) In R, with `B <- splines::bs(aq$Temp, df = 5, intercept = TRUE)` on the 111 airquality cases, check the ranks of $[\mathbf 1,B]$ and $[\mathbf 1,BZ]$, and check that both models give the same fitted values for $\log(\text{Ozone})$. What is the intercept of the constrained fit?

### Exercise 6 (edf as a trace)
Suppose $X^\top X=I_K$ and $S$ is diagonal with entries $s_1,\dots,s_K\ge0$.
(a) Show that edf $=\operatorname{tr}(F)=\sum_k 1/(1+\lambda s_k)$.
(b) Compute it for $\lambda=2$ and $s=(0,0,1,4,9)$.
(c) What are the limits as $\lambda\to0$ and $\lambda\to\infty$? Relate the second limit to the null space of $S$.

### Exercise 7 (criteria in R)
For `log(Ozone) ~ s(Temp)` on the 111 complete airquality cases, fit `method = "GCV.Cp"`, `"REML"` and `"ML"`.
(a) Report $\hat\lambda$ and the edf of `s(Temp)` for each method.
(b) Which method gives the smoothest fit here? Discuss, using the analogy with variance components, whether you expect the ML--REML gap to be this large in general (for instance, simulate 100 data sets and compare the edf of the two fits).
(c) For the REML fit, compare `sqrt(diag(vcov(fit)))` with `sqrt(diag(vcov(fit, unconditional = TRUE)))`. What does the difference represent?

### Exercise 8 (basis dimension in R)
Simulate `set.seed(24); x <- runif(200); y <- 2 * sin(4 * pi * x) + rnorm(200, sd = 0.5)`.
(a) Fit `s(x, k = 5)` and `s(x, k = 20)` with REML and run `k.check()` (after `set.seed(1)`).
(b) Explain the k-index of each fit using its definition.
(c) Compare the estimated residual standard deviations with the true value 0.5.
