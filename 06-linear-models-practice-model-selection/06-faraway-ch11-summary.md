# Faraway (2014), Ch. 11 — Shrinkage Methods

**Session(s):** 6 (also useful for 7)  ·  **Source:** Faraway, *Linear Models with R*, 2nd ed., Chapman & Hall/CRC, Ch. 11, pp. 161–181  
**Reading time:** ~60 min (~25 min for 11.3–11.4 only)  ·  **Level:** core (11.3–11.4); optional (11.1–11.2)

## Why read it

When there are many correlated predictors, least squares estimates become unstable and predictions on new data deteriorate. This chapter presents four ways of "shrinking" the information in many predictors into a more useful form: principal components regression, partial least squares, ridge regression and the lasso. Session 6 covers ridge and lasso briefly, and Lab 02 fits the lasso; this chapter gives the background and the geometry.

## The big idea

Least squares is unbiased, but with collinear or numerous predictors its variance can be huge. Accepting some bias in exchange for a large reduction in variance can lower the mean squared error of estimates and predictions. Ridge and lasso do this by penalising the size of the coefficients (squares vs absolute values); PCR and PLS do it by regressing on a few linear combinations of the predictors. Predictive performance must be judged on data not used to fit, using a test set or cross-validation.

## Section by section

**11.1 Principal Components (p. 161).** PCA finds orthogonal directions of maximal variance in the centred predictors: $Z=XU$, with $U$ the rotation matrix. Body circumferences of 252 men (`fat`): the first PC explains most of the variance; after scaling the variables it looks like overall size, the second like a contrast between trunk and extremities. PCA is sensitive to outliers; robust Mahalanobis distances with a $\chi^2$ Q–Q plot help find them. **Principal components regression** (PCR) regresses $y$ on the first few PCs: on the fat data, two orthogonal and interpretable components replace ten collinear circumferences with a modest loss of fit; picking one representative variable per component (abdomen, and an ankle–abdomen contrast) gives a simple model. For prediction, the meat spectroscopy data (`meatspec`: fat content and 100 near-infrared absorbances, first 172 samples for training, last 43 for testing) show that the full least-squares fit is far worse on the test set than in-sample (RMSE about five times larger), that `step()` helps a little, and that PCR coefficients are much smaller and smoother across frequencies, hence "shrinkage". The number of components chosen from a scree plot is too small; 10-fold **cross-validation** with `pls::pcr()` picks a number close to the test-set optimum.

**11.2 Partial Least Squares (p. 172).** Like PCR, but the linear combinations are chosen to predict $y$, not to explain the variance of $X$. There are several algorithms and no single well-defined optimisation problem. On the meat data, PLS needs fewer components than PCR and predicts slightly better. PCR and PLS work when $p>n$ but use every predictor, so they do not save measurement costs.

**11.3 Ridge Regression (p. 174).** With centred and scaled predictors and centred response, minimise the RSS plus a penalty on $\sum_j\beta_j^2$, or equivalently minimise the RSS subject to $\sum_j\beta_j^2\le t^2$. The solution adds a constant to the diagonal of $X^\top X$ (the "ridge"). Geometry (Figure 11.9): growing RSS contours around $\hat\beta_{\text{LS}}$ until they touch a circle. A Bayesian reading: a prior favouring small coefficients. Choose the penalty by looking at the ridge trace or by generalised cross-validation (`MASS::lm.ridge`). On the meat data the ridge test error is poor because of a single badly predicted sample; without it, ridge does well. The section ends with the bias–variance decomposition that justifies shrinkage, and a comparison study in which ridge did best (with the caveat that no method always wins).

**11.4 Lasso (p. 177).** Same idea with $\sum_j|\beta_j|\le t$. The constraint region has corners on the axes, so the solution often sets some coefficients exactly to zero: the lasso also **selects variables**. As $t$ grows, variables enter one by one until the least-squares fit is reached. Computed with `lars` (least angle regression). On the state data, 10-fold CV picks a four-predictor model with the same variables as Ch. 10 but smaller coefficients. On the meat data the lasso gives the best test RMSE of all methods while using only about 20 of the 100 frequencies. Most useful when effects are believed to be sparse (e.g. gene expression), less compelling when many small effects are expected.

## Key results to know

1. Mean squared error: $\mathrm E(\tilde\beta-\beta)^2=\{\mathrm E\tilde\beta-\beta\}^2+\mathrm{Var}(\tilde\beta)$: bias$^2$ + variance.
2. Ridge (centred, scaled $X$; centred $y$): $\hat\beta_{\text{ridge}}=(X^\top X+\lambda I)^{-1}X^\top y$, invertible for any $\lambda>0$ even if $X^\top X$ is singular. The Session 6 deck writes the ridge constant as $\kappa$, because $\lambda$ is glmnet's penalty.
3. Lasso, constrained form: minimise $(y-X\beta)^\top(y-X\beta)$ subject to $\sum_j|\beta_j|\le t$. The course states the penalised **glmnet** form
   $$\frac1{2n}\sum_i(y_i-\beta_0-x_i^\top\beta)^2+\lambda\Big[\tfrac{1-\alpha}{2}\lVert\beta\rVert_2^2+\alpha\lVert\beta\rVert_1\Big],$$
   which for $\alpha=1$ is the Lagrangian of Faraway's constraint ($t$ large $\leftrightarrow$ $\lambda$ small).
4. Predictors must be standardised before penalising: the penalty is not scale invariant.
5. PCR uses the first $k$ columns of $Z=XU$; PLS chooses components using $y$. Both: tune $k$ by cross-validation.
6. Training error is optimistic; judge methods by test-set or cross-validated RMSE.

## Connect to class

- **Session 6 deck**, *Ridge, lasso, elastic net*: bias–variance motivation, ridge closed form, lasso soft-thresholding in the orthonormal case, the exact glmnet objective, standardisation and `cv.glmnet` with fixed folds (`06-regularization.Rmd`).
- **Lab 02, Parts 2.2–2.3** (`07-lab-part2-prostate.Rmd`): lasso on `prostate` with `glmnet` and an honest train/test comparison.
- **Differences:** Faraway uses `lm.ridge` and `lars`, not `glmnet`, and does not cover the **elastic net**; the deck does. Faraway's lasso examples are the state and meat data, not prostate.
- PCR and PLS are not on the slides (optional reading).
- Shrinkage returns in Sessions 21–24: a penalised spline is ridge regression with a roughness penalty $\lambda\lVert D_d\beta\rVert^2$ instead of $\lambda\lVert\beta\rVert^2$.

## Read carefully / safe to skim

- **Read carefully:** 11.3 and 11.4, especially Figure 11.9's geometry and the bias–variance argument; the train/test logic in 11.1.
- **Read once:** the PCR idea in 11.1 and the PCR vs PLS contrast in 11.2.
- **Safe to skim:** Mahalanobis outlier checks, `pls` and `lars` syntax, the detailed RMSE values.

## Check yourself

1. Derive the ridge estimator by differentiating $\lVert y-X\beta\rVert^2+\lambda\lVert\beta\rVert^2$. Why is $X^\top X+\lambda I$ invertible for every $\lambda>0$?
2. Using the circle and square of Figure 11.9, explain why the lasso can give exact zeros and ridge cannot.
3. What happens to the ridge and lasso estimates as the penalty goes to zero and to infinity?
4. Why must the test samples play no role in choosing the number of components or the penalty?
5. When would you expect ridge to beat the lasso in prediction, and the reverse?
