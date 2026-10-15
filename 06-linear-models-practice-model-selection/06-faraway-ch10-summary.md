# Faraway (2014), Ch. 10 — Model Selection

**Session(s):** 6 (also useful for 7 and 8)  ·  **Source:** Faraway, *Linear Models with R*, 2nd ed., Chapman & Hall/CRC, Ch. 10, pp. 149–160  
**Reading time:** ~35 min  ·  **Level:** core

## Why read it

With a handful of candidate predictors, transformations and interactions, the number of possible models explodes. This chapter covers the classical tools for choosing among them: rules that respect model hierarchy, testing-based stepwise procedures (and why Faraway discourages them), and criteria such as AIC, BIC, adjusted $R^2$ and Mallows' $C_p$. It is the reading behind the *Model selection* part of Session 6 and Part 2 of Lab 02.

## The big idea

Smaller models are preferred when they fit about as well (Occam's razor): unnecessary predictors add noise to estimates and predictions, and measuring them may cost money. But selection must serve the purpose of the analysis. For **explanation**, the variables of interest and their confounders should be chosen by thinking, not by an automatic search. For **prediction**, criterion-based methods that balance fit against complexity are preferable to sequences of $p$-value tests, whose multiple testing makes the reported significance unreliable.

## Section by section

**Opening (p. 149).** Reasons for smaller models; selection interacts with outliers, influential points and transformations, so iterate. The search space can be too large to enumerate.

**10.1 Hierarchical Models (p. 150).** Do not remove a lower-order term while keeping a higher-order one in the same variable. In $y=\beta_0+\beta_1x+\beta_2x^2$, dropping $x$ is not invariant to a shift $x\to x+a$ (the linear term comes back) and amounts to claiming an optimum exactly at $x=0$. In a second-order response surface, drop the cross-product $x_1x_2$ only together with the squares, otherwise the model depends on how the axes are rotated.

**10.2 Testing-Based Procedures (p. 151).** Backward elimination (remove the least significant term above a threshold $\alpha_{\text{crit}}$, refit, repeat; 15–20% may suit prediction), forward selection, and stepwise combinations. Example: life expectancy in the 50 US states in the 1970s (`state.x77`): backward elimination removes Area, Illiteracy, Income and finally Population (a close call), leaving Murder, HS graduation and Frost with little loss of $R^2$. But a model with Illiteracy, Murder and Frost shows Illiteracy *is* associated with the response: dropping a variable only means it adds little given the others. Four drawbacks: one-at-a-time search can miss the best model; $p$-values after many tests are not trustworthy and overstate the importance of the survivors; the procedure is not tied to the goal; and it tends to choose models too small for prediction. Faraway's verdict: avoid, except for small or strongly hierarchical comparisons.

**10.3 Criterion-Based Procedures (p. 153).** Kullback–Leibler distance between the true density and a model; Akaike's result that its expectation can be estimated, up to a constant, by minus the maximised log-likelihood plus the number of parameters, giving **AIC**. For linear models only $n\log(\mathrm{RSS}/n)+2p$ matters when comparing models for the same data. **BIC** replaces $2p$ by $p\log n$, so it prefers smaller models; Faraway notes that AIC is generally preferred for prediction. `leaps::regsubsets()` finds the best model of each size; AIC picks Population, Murder, HS graduation and Frost. **Adjusted $R^2$**, unlike $R^2$, can fall when a useless predictor is added; maximising it is minimising $\hat\sigma^2$. **Mallows' $C_p$** estimates mean squared prediction error; plot $C_p$ against $p$ and look for small models near or below the line $C_p=p$; here a three- and a four-predictor model compete. `step()` searches sequentially by AIC (no tests) and reaches the same model. Sensitivity checks: Alaska has high leverage, and removing it brings Area into the best model; log-transforming the skewed Population and Area changes the "best" model again.

**10.4 Summary (p. 159).** Selection is a means to an end. Prefer criterion-based methods to testing-based ones. If several models fit about equally well, compare their qualitative conclusions, predictions, measurement costs and diagnostics; if they disagree substantively, the data cannot settle the question.

## Key results to know

1. Hierarchy principle: keep $x$ when $x^2$ is in; keep main effects when their interaction is in.
2. AIC $=-2\ell(\hat\theta)+2k$; BIC $=-2\ell(\hat\theta)+k\log n$, with $k$ estimated parameters. Smaller is better; only differences between models fitted to the same $y$ matter.
3. Gaussian linear model: $-2\ell(\hat\theta)=n\log(\mathrm{RSS}/n)+\text{const}$. Faraway's AIC is $n\log(\mathrm{RSS}/n)+2p$, which is R's `extractAIC()` (used by `step()`); R's `AIC()` counts $\sigma^2$ too ($k=p+1$) and adds the constant. Same rankings.
4. Adjusted $R^2$: $R_a^2=1-\dfrac{\mathrm{RSS}/(n-p)}{\mathrm{TSS}/(n-1)}=1-\dfrac{\hat\sigma^2_{\text{model}}}{\hat\sigma^2_{\text{null}}}$.
5. Mallows: $C_p=\mathrm{RSS}_p/\hat\sigma^2+2p-n$, with $\hat\sigma^2$ from the full model; $C_p=p$ for the full model and $\mathrm E[C_p]\approx p$ for an unbiased submodel.
6. $p$-values printed for a selected model ignore the selection and are too small.

## Connect to class

- **Session 6 deck**, *Model selection*: AIC and BIC with what each targets (AIC: expected KL divergence, efficient for prediction; BIC: consistent), `AIC()` vs `extractAIC()`, $C_p$, and a simulation showing invalid post-selection $p$-values. Faraway does not discuss BIC's consistency; the deck does.
- **Data:** the deck and Lab 02 use `faraway::prostate`; Faraway's text uses the US state data, and prostate appears only in his end-of-chapter exercises.
- `06-model-selection.Rmd` and **Lab 02, Part 2.1** (`07-lab-part2-prostate.Rmd`) run `step()` with `k = 2` and `k = log(n)` on a training split, then compare on test data, which goes beyond Faraway's in-sample criteria.
- The hierarchy principle is the deck's "Hierarchical principle" frame (Session 6) and reappears for polynomials in Faraway 9.4 and Session 20.
- **Session 8**, Problem 5, asks you to choose models for an explanatory and a predictive question from a table of $R_a^2$, AIC, BIC and LOOCV.

## Read carefully / safe to skim

- **Read carefully:** 10.1, the list of drawbacks in 10.2, 10.3 (definitions of AIC, BIC, $R_a^2$, $C_p$) and 10.4.
- **Safe to skim:** the step-by-step backward-elimination output and the `regsubsets` printing details.

## Check yourself

1. Show that, for two Gaussian linear models fitted to the same $y$, the difference in AIC depends only on their RSS and their numbers of parameters.
2. For which sample sizes does BIC penalise an extra parameter more than AIC?
3. Explain why a variable removed by backward elimination may still be strongly associated with the response.
4. Why can removing a single high-leverage state change which model is "best"? What should you report?
5. You are asked whether income affects life expectancy after accounting for education. Should you run `step()`? What would you do instead?
