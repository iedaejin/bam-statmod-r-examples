# Faraway (2014), Ch. 5 — Explanation

**Session(s):** 6 (also useful for 2 and 8)  ·  **Source:** Faraway, *Linear Models with R*, 2nd ed., Chapman & Hall/CRC, Ch. 5, pp. 59–71  
**Reading time:** ~40 min  ·  **Level:** core

## Why read it

"What does this coefficient mean?" is the most common question asked of a regression, and the one most often answered badly. This chapter shows why a coefficient's meaning depends on the other predictors, what extra conditions are needed before calling an effect *causal*, and how confounding, randomisation, matching and covariate adjustment fit together. It is the reading behind the first part of Session 6.

## The big idea

In observational data, $\beta_j$ describes how the *predicted* response differs between units that differ by one unit in $x_j$ **and agree on the other predictors in the model**. That is a comparison, not an intervention. A causal effect is defined by counterfactuals: the difference between a unit's outcome with and without the treatment, of which we only ever see one. Randomisation makes the groups comparable on average and validates permutation tests; without it, we can only adjust for the confounders we measured, by matching or by including them in the model.

## Section by section

**5.1 Simple Meaning (p. 59).** Back to the Galápagos model (`gala`). The `Elevation` coefficient means that, of two islands one metre apart in elevation, the higher is predicted to have about 0.32 more species. Fit `Elevation` alone and the slope is noticeably smaller: the coefficient changes because, in the one-predictor model, a change in elevation comes together with changes in the other variables. Faraway introduces the **effect plot** (vary one predictor, fix the others at typical values such as their means) to visualise a coefficient. He then lists the problems with "holding the others constant": islands' geography cannot be manipulated, unmeasured variables cannot be held constant, and nothing in the model implies causation.

**5.2 Causality (p. 61).** Counterfactual definition: with $T=0$ (control) and $T=1$ (treatment), the causal effect for unit $i$ is $\delta_i=y_i^{1}-y_i^{0}$. The outcome we do not observe is the **counterfactual**. Some "treatments" (sex, geography) are hard even to imagine changing. Designs such as treating one side of the face, or before/after measurements, approximate both outcomes but need assumptions about how local the effect is in time and space.

**5.3 Designed Experiments (p. 62).** We cannot estimate each $\delta_i$, but we can estimate their average by **random assignment**. Two arguments for randomisation: it balances unknown variables on average, and, more convincingly, it justifies the permutation test of Section 3.3, since the observed allocation is one of all equally likely allocations. Conclusions extend beyond the subjects only if they represent a wider population. Known differences between units (e.g. sex) are handled by **blocking** (randomise within blocks, Ch. 17), preferably with an orthogonal design (Section 2.11).

**5.4 Observational Data (p. 63).** The 2008 New Hampshire Democratic primary (`newhamp`): Obama did better in wards counted by hand than in wards counted by machine. A model of the ward's Obama vote share on a hand-count indicator gives a highly significant difference of about 4 percentage points. Adding the ward's 2004 vote share for Howard Dean makes the voting-system effect vanish, and Dean share is itself strongly related to the voting method: a **confounder**. Faraway's short algebra: if the truth is $y=\beta_0+\beta_1T+\beta_2Z+\varepsilon$ and $Z=\gamma_0+\gamma_1T+\delta$, a model without $Z$ estimates $\beta_1+\beta_2\gamma_1$ instead of $\beta_1$. The bias disappears only if $\beta_2=0$ or $\gamma_1=0$; randomisation guarantees $\gamma_1=0$. (He also notes that the response is a binomial proportion with unequal variances, a point for weighted least squares or GLMs, Sessions 9–12.)

**5.5 Matching (p. 65).** Imitate an experiment after the fact: pair each hand-count ward with a machine-count ward of almost the same Dean share (the `Matching` package, with a caliper), then test the mean of the within-pair differences with a one-sample $t$ test. The matched difference is not significant and does not depend on Dean share. Wards without a close partner are left out.

**5.6 Covariate Adjustment (p. 68).** Including Dean share in the regression gives two parallel lines; the vertical gap between them is the adjusted effect, and each matched pair is a local estimate of that same gap (Figure 5.3). Adjustment is easier and extends to many confounders but assumes the functional form of the covariate is right and may extrapolate where groups do not overlap; matching avoids the functional form but discards unmatched cases.

**5.7 Qualitative Support for Causation (p. 69).** Bradford Hill's considerations for observational evidence, each explained briefly: strength (a large effect, not a small $p$-value), consistency across studies, specificity, temporality, gradient (dose–response, with hormesis as an exception), plausibility, and experiment (natural or related experiments). None is necessary or sufficient; together they add weight.

## Key results to know

1. Interpretation template: "Comparing units that differ by one unit in $x_j$ and have the same values of the other predictors in the model, the predicted response differs by $\hat\beta_j$."
2. Counterfactual causal effect $\delta_i=y_i^{1}-y_i^{0}$; randomisation lets us estimate $\mathrm E[\delta_i]$.
3. Omitted confounder (scalar version): fitting $y$ on $T$ alone estimates $\beta_1+\beta_2\gamma_1$. The matrix form used in class is $\mathrm E[\tilde\beta_1]=\beta_1+(X_1^\top X_1)^{-1}X_1^\top X_2\,\beta_2$.
4. Bias is zero iff the omitted variable does not affect $y$ ($\beta_2=0$) or is unrelated to the included predictor ($\gamma_1=0$).
5. Matching and covariate adjustment estimate the same adjusted difference under different assumptions.

## Connect to class

- **Session 6 deck**, section *Interpreting multiple regression*: the same message on the `savings` data. The `pop75` sign reversal (positive alone, negative given `pop15`) and the exact in-sample omitted-variable identity are **the deck's example, not Faraway's**; Faraway uses `gala` and New Hampshire.
- The deck adds the Frisch–Waugh–Lovell view of $\hat\beta_j$ (regress residuals on residuals), which is also Faraway's added-variable plot in Section 6.3.
- `06-confounding.Rmd` reproduces the deck's omitted-variable identity.
- The deck's "Explanation vs prediction" table and Breiman (2001) (Session 2) frame this chapter; Ch. 4 is the prediction side.
- Matching and Hill's criteria are not on the slides: read them for understanding, not for exam formulas.

## Read carefully / safe to skim

- **Read carefully:** 5.1, 5.4 and 5.6 (interpretation, confounding algebra, adjustment as parallel lines).
- **Read once:** 5.2–5.3 (counterfactuals, why randomisation works) and 5.7.
- **Safe to skim:** the `Matching` package call and its tuning options in 5.5.

## Check yourself

1. Derive the coefficient of $T$ in a model that omits $Z$, using $Z=\gamma_0+\gamma_1T+\delta$. Under what two conditions is there no bias?
2. Why can the `Elevation` coefficient differ between the one-predictor and five-predictor Galápagos models, even though both are fitted by least squares to the same islands?
3. Explain in words why randomisation also justifies a permutation test.
4. Matching discarded some wards in the New Hampshire example. What does covariate adjustment do instead with those wards, and what risk does that carry?
5. Rewrite the sentence "raising income by £1 increases gambling by £5" so that it is correct for an observational regression.
