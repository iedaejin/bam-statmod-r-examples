# Faraway (2014), Ch. 7 — Problems with the Predictors

**Session(s):** 7 (also useful for 6 and 20)  ·  **Source:** Faraway, *Linear Models with R*, 2nd ed., Chapman & Hall/CRC, Ch. 7, pp. 99–111  
**Reading time:** ~40 min  ·  **Level:** core (7.3); optional (7.1–7.2)

## Why read it

Chapter 6 checked the errors; this chapter checks the columns of $X$. Three issues: predictors measured with error, predictors on awkward scales, and predictors that nearly duplicate one another (collinearity). The last one is what you diagnose with VIFs in Lab 02 and what motivates ridge regression in Session 6.

## The big idea

The linear model treats $X$ as fixed and exactly known. If a predictor is measured with error, its slope is biased towards zero. Rescaling a predictor changes nothing essential, only the units of its coefficient, but can make results easier to read and computations more stable. When some columns are close to linear combinations of others, $X^\top X$ is nearly singular: estimates stay unbiased but become very imprecise and unstable, while predictions inside the data cloud are much less affected.

## Section by section

**7.1 Errors in the Predictors (p. 99).** Not the same as random $X$: in observational studies $X$ is random but we condition on its observed values. Here the recorded value $x^O$ differs from the true $x^A$ that drives the response: $x_i^O=x_i^A+\delta_i$. For simple regression, with the measurement error unrelated to the true value, least squares underestimates the slope in absolute value (attenuation) whatever the sample size; the problem is negligible if the error variance is small relative to the spread of $x$. With several predictors the usual effect is also a shrinking towards zero. The **Berkson** case is different: when the experimenter *sets* the nominal value (a solution made up to a target concentration) and the true value varies around it, the slope estimate is unbiased; the same reasoning applies to prediction at fixed nominal values. Alternatives to least squares: the geometric-mean functional relationship ($\hat\beta_1=s_y/s_x$, symmetric in $x$ and $y$) and **SIMEX** (simulation–extrapolation). SIMEX on the 1920s `cars` data: add extra noise of increasing variance to `speed`, watch the slope shrink, fit a line to slope vs total error variance, and extrapolate back to zero error; the `simex` package automates this.

**7.2 Changes of Scale (p. 103).** Rescaling a predictor $x_j\to(x_j+a)/b$ leaves $t$ and $F$ tests, $\hat\sigma$ and $R^2$ unchanged and multiplies $\hat\beta_j$ by $b$; rescaling $y$ also rescales $\hat\sigma$ and all coefficients. `savings`: income `dpi` in thousands of dollars gives a readable coefficient. Standardising all variables (`scale()`) puts the intercept at zero and makes coefficients comparable (effect of one SD of $x_j$ in SDs of $y$), shown as a coefficient plot with intervals (Figure 7.4). With a binary predictor, Faraway follows Gelman's suggestion of scaling continuous predictors by **two** SDs, so that a coefficient compares "low" and "high" values much as a 0/1 dummy does.

**7.3 Collinearity (p. 106).** Exact collinearity is the identifiability problem of Section 2.10. Near collinearity gives imprecise estimates, implausible signs, inflated standard errors (so non-significant $t$ tests despite a good overall fit) and estimates that jump with small changes in $y$. Three diagnostics: (1) the correlation matrix of the predictors; (2) $R_j^2$ from regressing $x_j$ on the others; (3) eigenvalues of $X^\top X$ and condition numbers. The variance formula below shows the two ways to get a precise $\hat\beta_j$: spread $x_j$ widely and keep it uncorrelated with the others (orthogonal designs; in practice keep some middle points to check for curvature). Example: car-seat position data (`seatpos`, 38 drivers): a decent $R^2$ but no significant predictor, large pairwise correlations among the body-length measures, several large condition numbers and very large VIFs (the standard error for height with shoes is inflated about 17-fold). Adding small noise to the response changes the coefficients a lot. Remedy: keep one representative of the length variables (height) together with age and weight; the fit is almost as good with far fewer predictors. Dropped variables are not "unrelated" to the response. To keep all variables, use ridge regression (Section 11.3). Prediction suffers less, except that collinear data cover a thin region of predictor space, so many predictions are extrapolations.

## Key results to know

1. Attenuation (simple regression, $\delta$ independent of $x^A$): $\hat\beta_1$ converges to $\beta_1\,\sigma_x^2/(\sigma_x^2+\sigma_\delta^2)$, i.e. towards zero. Faraway's notation: $\sigma_x^2$ is the spread of the true $x$, $\sigma_\delta^2$ the measurement-error variance.
2. Rescaling $x_j$ by $1/b$: $\hat\beta_j\to b\hat\beta_j$; tests, $R^2$, $\hat\sigma$ unchanged.
3. Variance of a coefficient:
   $$\mathrm{Var}(\hat\beta_j)=\sigma^2\,\frac{1}{1-R_j^2}\,\frac{1}{\sum_i(x_{ij}-\bar x_j)^2},\qquad \mathrm{VIF}_j=\frac{1}{1-R_j^2}.$$
   $\sqrt{\mathrm{VIF}_j}$ is the factor by which the standard error is inflated relative to an orthogonal design.
4. Condition number $\kappa=\sqrt{\lambda_1/\lambda_p}$ from the eigenvalues of $X^\top X$; Faraway treats $\kappa\ge30$ as large. (Note: the Session 20 deck reports $\kappa(X)$, which is the same quantity computed from the singular values of $X$.)
5. Collinearity does not bias $\hat\beta$; it inflates its variance.

## Connect to class

- **Session 6 deck**, "Including too much: collinearity and VIF": the same variance formula and the VIFs of the `savings` predictors.
- **Lab 02, Part 1.5** (`07-lab-part1-savings.Rmd`): VIFs with `car::vif()`; Faraway uses `faraway::vif()` on the model matrix. Same numbers, different packages.
- Ridge regression in Session 6 and Faraway Section 11.3 is the estimation-side answer to 7.3.
- **Session 20**: the ill-conditioning of raw polynomial columns is collinearity in a different guise; `poly()` removes the numerical problem, as rescaling does here.
- The deck uses $\kappa$ for the ridge penalty in Session 6; do not confuse it with the condition number.
- Errors in variables (7.1) are not covered on the slides.

## Read carefully / safe to skim

- **Read carefully:** 7.3 (all of it) and the first paragraph of 7.2 on what rescaling changes.
- **Read once:** 7.1 up to the Berkson case; know the direction of the bias.
- **Safe to skim:** the SIMEX code and the 2-SD scaling details.

## Check yourself

1. From the $\mathrm{Var}(\hat\beta_j)$ formula, list every way in which a study design could make $\hat\beta_j$ more precise.
2. A predictor has $R_j^2=0.96$. Compute its VIF and the factor by which its standard error is inflated.
3. Explain why measuring income with random error biases its slope towards zero, but making up solutions to a nominal concentration does not bias the concentration slope.
4. In the `seatpos` example the full model has a reasonable $R^2$ but no significant coefficients. How can both be true?
5. You change `dpi` from dollars to thousands of dollars. Which numbers in `summary(lm)` change, and how?
