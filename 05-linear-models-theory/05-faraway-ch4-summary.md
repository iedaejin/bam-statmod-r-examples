# Faraway (2014), Ch. 4 — Prediction

**Session(s):** 5 (also useful for 6 and 8)  ·  **Source:** Faraway, *Linear Models with R*, 2nd ed., Chapman & Hall/CRC, Ch. 4, pp. 51–58  
**Reading time:** ~25 min  ·  **Level:** core

## Why read it

A point prediction without an honest statement of its uncertainty is of little use to a decision maker. This short chapter separates the two intervals that students most often confuse, the interval for a **mean response** and the interval for a **new observation**, and lists what can make any prediction fail, however good the interval formula.

## The big idea

At a new predictor row $x_0$ the prediction is $\hat y_0=x_0^\top\hat\beta$ in both cases, but the uncertainty differs. For the average response of all units with characteristics $x_0$, only the estimation error in $\hat\beta$ counts. For one new unit, its own error $\varepsilon_0$ adds a term $\sigma^2$ that does not vanish however much data we have. And both intervals assume the model is right, which is the largest source of error in practice.

## Section by section

**Opening (p. 51).** Uncertainty matters for decisions: flood barriers must be built for water levels well above the predicted maximum, and financial plans need a realistic downside.

**4.1 Confidence Intervals for Predictions (p. 51).** Faraway's house-rental illustration: predicting the rent of a *specific* house on the market (include $\varepsilon_0$) versus the *average* rent of houses with those features (only $\hat\beta$ varies). He notes that the first case is the one usually needed. Because a future observation is random, the interval for it is better called a **prediction interval**; the probability statement applies to the future value, which it does not for a fixed parameter. Using the narrower mean-response interval for an individual prediction is a common mistake.

**4.2 Predicting Body Fat (p. 52).** The `fat` data: body fat of 252 men measured accurately by underwater weighing, with 13 easy measurements (age, weight, height, circumferences) as predictors. For a "typical" man (all predictors at their medians), `predict(..., interval = "prediction")` gives a wide interval and `interval = "confidence"` a much narrower one; the model's $R^2\approx0.75$ is not enough for precise individual predictions, though the mean-response interval could serve public-health purposes. At the 95th percentile of every predictor the confidence interval widens a lot but the prediction interval only a little, because the new-error term dominates. Faraway separates **quantitative extrapolation** (far from the observed $x$; in many dimensions most predictions are extrapolations) and stresses that **model uncertainty**, not captured by either interval, is the bigger issue. Technical tip: `predict()` needs a data frame with the same variable names as the fitting data.

**4.3 Autoregression (p. 54).** Monthly airline passengers, 1949–1961 (`airpass`), on the log scale. A linear trend in time misses the seasonality. A regression of $y_t$ on its lags $y_{t-1}$, $y_{t-12}$, $y_{t-13}$ (built with `embed()`) fits well. Predicting further ahead requires plugging in earlier predictions recursively. No statistical check can guarantee that the future follows the fitted model.

**4.4 What Can Go Wrong with Predictions? (p. 56).** Five failure modes: a poor model; quantitative extrapolation (e.g. low-dose risk from high-dose data); **qualitative extrapolation** to a different population (using the men's body-fat model for women); overconfidence from overfitting, which makes $\hat\sigma$ too small; and "black swans", rare large errors not seen in the data.

## Key results to know

1. Point prediction: $\hat y_0=x_0^\top\hat\beta$ ($x_0$ includes the leading 1).
2. Mean response: $\mathrm{Var}(x_0^\top\hat\beta)=\sigma^2x_0^\top(X^\top X)^{-1}x_0$, so
   $$\text{CI: }\ \hat y_0\pm t_{n-p,\,1-\alpha/2}\,\hat\sigma\sqrt{x_0^\top(X^\top X)^{-1}x_0}.$$
3. New observation: $\mathrm{Var}(y_0-\hat y_0)=\sigma^2\big(1+x_0^\top(X^\top X)^{-1}x_0\big)$ (using independence of $\varepsilon_0$ and $\hat\beta$), so
   $$\text{PI: }\ \hat y_0\pm t_{n-p,\,1-\alpha/2}\,\hat\sigma\sqrt{1+x_0^\top(X^\top X)^{-1}x_0}.$$
4. As $n\to\infty$, $x_0^\top(X^\top X)^{-1}x_0\to0$: the CI shrinks to a point, the PI does not.
5. $x_0^\top(X^\top X)^{-1}x_0$ grows with the distance of $x_0$ from the centre of the data (it is the leverage a new point at $x_0$ would have): both intervals widen under extrapolation, the CI proportionally more.
6. Faraway's notation is the same as ours, except that he writes the quantile as $t^{(\alpha/2)}_{n-p}$.

## Connect to class

- **Session 5 deck**, section *Prediction*: the same two variance formulas, a worked example on `savings` with the half-widths computed by hand, and the confidence vs prediction band figure.
- `05-diagnostics-prediction.Rmd` reproduces `predict(..., interval = ...)`.
- **Session 8**, Problems 6 and 8: choose the right interval for a question, and derive $\mathrm{Var}(y_0-\hat y_0)$.
- The autoregression section is a first look at dependence over time; in Session 7 and in Faraway Ch. 6 serial correlation is a diagnostic problem, and mixed models (Sessions 15–19) handle correlated data properly.
- Faraway's warning about overfitting and too-small $\hat\sigma$ anticipates Session 6 (model selection, out-of-sample error).

## Read carefully / safe to skim

- **Read carefully:** 4.1 and the interval comparison in 4.2; 4.4 is short and examinable as discussion.
- **Safe to skim:** the `embed()` mechanics in 4.3.

## Check yourself

1. Derive $\mathrm{Var}(y_0-x_0^\top\hat\beta)$, stating where you use independence.
2. A hospital wants the expected body fat of men with given measurements to plan a programme; a gym client wants to know *his* body fat. Which interval for each, and why?
3. Why does moving $x_0$ to the 95th percentile of every predictor widen the CI much more, in relative terms, than the PI?
4. Give an example of qualitative extrapolation in a dataset you know. Would a wider interval fix it?
5. In the airline model, why are two-step-ahead predictions less reliable than one-step-ahead predictions, beyond what the PI formula says?
