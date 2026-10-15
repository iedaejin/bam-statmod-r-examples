# Session 1 — Exercises

**Topic:** Prerequisite review — distributions, random vectors, linear algebra, calculus
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Notation follows the course: $X$ is the $n \times p$ design matrix **including** the intercept column; $I(\theta) = -\partial^2 \ell / \partial\theta^2$ is the observed information; $\mathrm{se}(\hat\theta) = I(\hat\theta)^{-1/2}$.
Do the derivations by hand first, then check the numbers in R. The R examples are in `` (`01-distributions.Rmd`, `01-matrix-algebra.Rmd`, `01-calculus-optimization.Rmd`).

---

## Exercise 1 — The gamma distribution

$Y \sim \text{Gamma}(\alpha, \lambda)$ with density $f(y) = \dfrac{\lambda^\alpha}{\Gamma(\alpha)} y^{\alpha - 1} e^{-\lambda y}$, $y > 0$ (shape $\alpha > 0$, rate $\lambda > 0$).

1. Show that $\displaystyle\int_0^\infty y^{k-1} e^{-\lambda y}\,dy = \Gamma(k)/\lambda^k$ for $k > 0$.
2. Derive $\mathbb E[Y] = \alpha/\lambda$ and $\mathrm{Var}(Y) = \alpha/\lambda^2$.
3. Write the variance as a function of the mean $\mu$. Which other distribution in today's table has the variance as a function of the mean, and how do the two functions differ?
4. Show that the exponential distribution is a special case, and give its mean and variance.
5. In R, simulate $10^5$ draws with `rgamma(1e5, shape = 2, rate = 0.5)` and compare the sample mean and variance with your formulas.

## Exercise 2 — Linear transformations of a normal vector

$\boldsymbol Y \sim N_3(\mu, \Sigma)$ with
$$\mu = \begin{pmatrix} 1 \\ 0 \\ 2 \end{pmatrix}, \qquad \Sigma = \begin{pmatrix} 4 & 1 & 0 \\ 1 & 2 & -1 \\ 0 & -1 & 3 \end{pmatrix}.$$

1. Find the distribution of $\bar Y = (Y_1 + Y_2 + Y_3)/3$.
2. Find the joint distribution of $(Y_1 - Y_2,\ Y_2 - Y_3)^\top$ using $A\mu$ and $A\Sigma A^\top$.
3. Are $Y_1 - Y_2$ and $Y_2 - Y_3$ independent? Explain.
4. Prove $\mathrm{Var}(A\boldsymbol Y) = A\Sigma A^\top$ from the definition $\mathrm{Var}(\boldsymbol Y) = \mathbb E[(\boldsymbol Y - \mu)(\boldsymbol Y - \mu)^\top]$.
5. In R, check parts 1 and 2 by simulation with `MASS::mvrnorm()` (remember that the draws are rows, so use `Y %*% t(A)`).

## Exercise 3 — Rank and positive definiteness of $X^\top X$

1. Prove that $X^\top X$ is positive semi-definite for any $X$.
2. Prove that $X^\top X$ is positive definite if and only if $X$ has full column rank $p$.
3. In `mtcars`, build $X$ with the columns: intercept, `wt`, `hp`, `am` and `1 - am`. What are $p$ and the rank of $X$? Explain why, and say what `lm(mpg ~ wt + hp + am + I(1 - am), data = mtcars)` reports.
4. Give a second, realistic example of a design that is rank deficient.

## Exercise 4 — Simple linear regression from the normal equations

Take $X = [\mathbf 1, x]$, so $p = 2$.

1. Write $X^\top X$ and $X^\top y$ in terms of $n$, $\sum x_i$, $\sum x_i^2$, $\sum y_i$, $\sum x_i y_i$.
2. Solve the normal equations $X^\top X \beta = X^\top y$ and show that $\hat\beta_1 = S_{xy}/S_{xx}$ and $\hat\beta_0 = \bar y - \hat\beta_1 \bar x$, where $S_{xx} = \sum (x_i - \bar x)^2$ and $S_{xy} = \sum (x_i - \bar x)(y_i - \bar y)$.
3. By hand, for $x = (1, 2, 3, 4, 5)$ and $y = (2, 4, 5, 4, 5)$, compute $\hat\beta$, the residuals, $\mathrm{RSS}$ and $\hat\sigma^2 = \mathrm{RSS}/(n - p)$.
4. Check that the residuals sum to zero and are orthogonal to $x$. Which normal equation gives each fact?
5. Check your numbers with `lm()`.

## Exercise 5 — The variance of $\hat\beta$ and the hat matrix

Assume $y = X\beta + \varepsilon$, $\mathbb E[\varepsilon] = 0$, $\mathrm{Var}(\varepsilon) = \sigma^2 I_n$, and $X$ of full column rank.

1. Write $\hat\beta = Ay$ and identify $A$. Show that $\mathbb E[\hat\beta] = \beta$ and $\mathrm{Var}(\hat\beta) = \sigma^2 (X^\top X)^{-1}$.
2. Show that $H = X(X^\top X)^{-1}X^\top$ is symmetric and idempotent, and that $\mathrm{tr}(H) = p$.
3. Show that $I_n - H$ is also symmetric and idempotent and that the residual vector is $e = (I_n - H)\varepsilon$.
4. Using $\mathbb E[\varepsilon^\top M \varepsilon] = \sigma^2\,\mathrm{tr}(M)$ for a fixed matrix $M$, show that $\mathbb E[\mathrm{RSS}] = (n - p)\sigma^2$. What does this imply for $\hat\sigma^2 = \mathrm{RSS}/(n - p)$?
5. For the data of Exercise 4, compute the estimated standard error of $\hat\beta_1$.

## Exercise 6 — An exponential log-likelihood

$y_1, \dots, y_n \stackrel{\text{iid}}{\sim} \text{Exponential}(\lambda)$ (rate $\lambda$).

1. Write $L(\lambda)$ and $\ell(\lambda)$.
2. Find the score $S(\lambda)$ and solve $S(\lambda) = 0$.
3. Compute $\ell''(\lambda)$ and show that the stationary point is a maximum.
4. Give the observed information $I(\hat\lambda)$ and $\mathrm{se}(\hat\lambda)$.
5. For the waiting times (in hours) $y = (0.5, 1.2, 2.3, 0.8, 1.7, 3.5)$, compute $\hat\lambda$, $I(\hat\lambda)$ and $\mathrm{se}(\hat\lambda)$, and write the second-order Taylor approximation of $\ell(\lambda)$ around $\hat\lambda$.
6. Check $\hat\lambda$ with `optimize()` and $I(\hat\lambda)$ with `optimHess()` in R.

## Exercise 7 — Two variables and one Newton step

$f(x, y) = xy - x^2 - y^2 + 3x$.

1. Find the gradient and the stationary point.
2. Compute the Hessian, find its eigenvalues and classify the stationary point. Give the value of $f$ there.
3. Starting from $(x_0, y_0) = (0, 0)$, take one Newton step $\theta_1 = \theta_0 - [\nabla^2 f(\theta_0)]^{-1}\nabla f(\theta_0)$. Where do you land? Explain why, using the Taylor expansion.
4. Would one Newton step be enough for $f(x) = x^2 e^{-x}$? Explain.

## Exercise 8 — R: Poisson counts of discoveries

Use `y <- as.numeric(discoveries)` (great discoveries per year, 1860–1959).

1. Write the Poisson log-likelihood and maximize it numerically with `optimize()`. Compare with $\bar y$.
2. Compute $I(\hat\lambda)$ analytically and with `optimHess()`, and the standard error.
3. Compute the Wald interval $\hat\lambda \pm 1.96\,\mathrm{se}(\hat\lambda)$.
4. Compute the sample variance and the ratio variance/mean. What does the Poisson model assume about this ratio?
5. Tabulate the observed counts of years with $0, 1, \dots, 12$ discoveries against the counts expected under the Poisson fit (`100 * dpois(0:12, mean(y))`). Where does the model fit badly?
6. In one or two sentences: if the variance really is larger than the mean, is the standard error of part 2 too small or too large? (We return to this in session 10.)
