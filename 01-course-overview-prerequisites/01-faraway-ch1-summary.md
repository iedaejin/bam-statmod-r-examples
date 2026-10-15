# Faraway (2014), Ch. 1 — Introduction

**Session(s):** 1 (also useful for 2 and 5)  ·  **Source:** Faraway, *Linear Models with R*, 2nd ed., Chapman & Hall/CRC, Ch. 1, pp. 1–12  
**Reading time:** ~35 min  ·  **Level:** core

## Why read it

Before any formula, Faraway asks what you should do with a dataset *before* you fit a model, and when a linear model is the right tool at all. This short chapter sets the habits we expect from Session 1 onwards (look at the data, know how it was collected, state the goal) and gives the historical origin of least squares and of the word "regression", which we formalise in Session 5.

## The big idea

Statistics starts with a question, not with a dataset. A good analysis begins by understanding the subject, the objective and the way the data were collected, then checks the data numerically and graphically for errors, missing-value codes and odd distributions. Only then does modelling start. A linear model relates one continuous response to one or more predictors; it serves two purposes, **prediction** and **explanation**, and it is a useful approximation, not the "true model".

## Section by section

**1.1 Before You Start (p. 1).** Two checklists. To formulate the problem: understand the background of the application, understand (and agree on) the objective, avoid "fishing" for patterns, and translate the question into statistical terms, which is where the hardest and least automatable mistakes happen. To understand the data: are they observational or experimental, a designed sample or a convenience sample? Is there nonresponse or missingness? How are categorical variables coded, what are the units, and could there be entry errors? Data-collection details limit what conclusions are possible.

**1.2 Initial Data Analysis (p. 2).** Always do numerical summaries (means, SDs, min/max, correlations) and plots (histograms, kernel density estimates, sorted-value index plots, scatterplots, side-by-side boxplots). The running example is the **Pima** diabetes study (768 women, `faraway::pima`). `summary()` reveals minimum values of zero for blood pressure, glucose, skin fold, insulin and BMI: physically impossible, almost certainly a missing-value code. Faraway recodes them as `NA` and turns the 0/1 test result into a labelled factor, warning against summaries such as an "average zip code". He compares histograms with density estimates (the latter avoid arbitrary bin choices) and shows that sorted values expose rounding in the measurements. A short tour of `ggplot2` (aesthetics, geometries, facets) closes the section. The message: good graphics prevent errors and suggest the model to come.

**1.3 When to Use Linear Modeling (p. 7).** Terminology: one response $Y$ and predictors $X_1,\dots,X_p$; Faraway prefers "response/predictor" to "dependent/independent". Simple vs multiple regression; the response must be continuous, while predictors may be continuous or categorical (categorical predictors come in Ch. 14; a categorical *response* needs logistic regression, i.e. GLMs, our Sessions 9–12). The two objectives: predict future or unseen responses, or assess the effect of predictors on the response, ideally causally. The model is a means to an end; outside some physical sciences we rarely believe any model is exactly true.

**1.4 History (p. 8).** Tobias Mayer's 18th-century lunar data (`manilius`): 27 observations, 3 unknowns, no exact solution. Mayer grouped the equations into three sums; Legendre's least squares (1805) and Gauss's justification (1809) replaced this with minimising $\sum\varepsilon_i^2$, and `lm()` gives a similar answer without arbitrary grouping. Galton's parent–child heights (`HistData::GaltonFamilies`) show **regression to the mean**: in standard units the fitted line has slope $r<1$, so children of tall parents are predicted to be tall, but less extreme. The same effect explains "second-season slumps" in sport.

## Key results to know

1. Initial data analysis (IDA) checklist: purpose, collection method, coding, units, missing values, range checks, plots. Do it before fitting.
2. Linear model language: response $y$, predictors, $n$ observations; the course writes $y=X\beta+\varepsilon$ with $X$ of size $n\times p$ including the intercept column (Faraway uses $p$ for the number of *predictors* in this chapter and switches to the number of *parameters* in Ch. 2; be careful).
3. Least squares: choose $\beta$ to minimise $\sum_i\varepsilon_i^2$ (formalised in Ch. 2 and Session 5).
4. Simple regression in standard units:
   $$\frac{\hat y-\bar y}{s_y}=r\,\frac{x-\bar x}{s_x},\qquad \hat\beta_1=r\,\frac{s_y}{s_x},\qquad \hat\beta_0=\bar y-\hat\beta_1\bar x .$$
   Since $|r|\le1$, predictions are pulled towards the mean: regression to the mean.
5. Two goals of regression: prediction vs explanation (revisited in Ch. 4–5 and Session 6).

## Connect to class

- **Session 1 deck**, Part B, uses the `mtcars` fuel example to derive the normal equations; Faraway's `manilius` example is the historical version of the same overdetermined system. The `discoveries` count data in the deck play the role of Faraway's Pima data: look before you model.
- **Session 2** (models as approximations, data quality, reproducible R) expands Sections 1.1–1.3; read it with Breiman (2001) in mind.
- **Lab 00** (`Lab_00_Reproducible_R`) is where you practise IDA in a Quarto document.
- The deck spends more time on prerequisites (distributions, $\mathrm{Var}(AY)=A\Sigma A^\top$, Taylor expansions); Faraway assumes these and focuses on data practice.

## Read carefully / safe to skim

- **Read carefully:** 1.1 and 1.2 (the IDA mindset and the Pima zero-coding trap), 1.3 (prediction vs explanation), and the Galton part of 1.4 (regression to the mean).
- **Safe to skim:** the `ggplot2` syntax details and the astronomy background of Mayer's data. Run the code rather than memorising it.

## Check yourself

1. In the Pima data, why is treating the zeros as real values worse than simply dropping the variable? What would happen to the mean diastolic pressure?
2. Derive $\hat\beta_1=r\,s_y/s_x$ from the least-squares normal equations for simple regression.
3. Explain in words why a child of very tall parents is predicted to be tall but shorter than the parents, and why this does not mean that the population's height variation shrinks over generations.
4. Give one research question about a dataset you know that is predictive and one that is explanatory. Which needs stronger assumptions?
5. Why does Faraway advise against the terms "dependent" and "independent" variable?
