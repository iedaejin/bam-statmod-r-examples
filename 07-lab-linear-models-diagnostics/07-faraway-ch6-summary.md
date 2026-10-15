# Faraway (2014), Ch. 6 — Diagnostics

**Session(s):** 7 and 5 (also useful for 8)  ·  **Source:** Faraway, *Linear Models with R*, 2nd ed., Chapman & Hall/CRC, Ch. 6, pp. 73–98  
**Reading time:** ~75 min  ·  **Level:** core

## Why read it

Every result of Sessions 5–6 rests on assumptions. This chapter is the practical guide to checking them: which plot reveals which problem, how to tell leverage from outlyingness from influence, and what to do about each. It uses the `savings` data, the same running example as Session 5 and Lab 02, so you can read it side by side with the lab.

## The big idea

Problems fall into three groups: the **errors** (independence, constant variance, normality), the **model structure** ($\mathrm E\,y=X\beta$), and **unusual observations**. We cannot see the errors, only the residuals $e=(I-H)\varepsilon$, which are slightly correlated and have unequal variances $\sigma^2(1-h_{ii})$; usually close enough to the errors to use them. Plots are preferred over formal tests because they reveal problems you did not anticipate; tests help to settle what a plot suggests.

## Section by section

**6.1 Checking Error Assumptions (p. 73).**

- *6.1.1 Constant Variance (p. 73).* The key plot is residuals against fitted values (Figure 6.1 shows "no problem", heteroscedasticity and nonlinearity). Also plot residuals against each predictor, including predictors not in the model. Plotting $\sqrt{|e|}$ against $\hat y$ doubles the resolution for variance changes. `savings`: the residual vs `pop15` plot shows two groups, and an $F$ test of the two residual variances (`var.test`) finds a significant difference. Faraway recommends simulating plots from known models to calibrate your eye. Remedies: transformations (Ch. 9), weighted least squares (Ch. 8), or a variance-stabilising transform derived from a first-order Taylor expansion; e.g. a square root for Poisson-like counts, which fixes the `gala` residual plot.
- *6.1.2 Normality (p. 78).* Q–Q plots of residuals (with `qqline`), not histograms (bin choices make them inconclusive). Simulated Q–Q plots for skewed (lognormal), long-tailed (Cauchy) and short-tailed (uniform) data teach the typical shapes. Consequences: least squares remains BLUE, inference becomes approximate but improves with $n$ (CLT). Short tails can be ignored; skewness suggests a transformation; long tails call for robust methods or resampling. Fix nonlinearity and variance first. The Shapiro–Wilk test is reported but should only accompany a Q–Q plot: large $n$ detects irrelevant deviations, small $n$ lacks power.
- *6.1.3 Correlated Errors (p. 81).* Hard to check in general; look where structure suggests it (time, space, blocks). Example: northern-hemisphere temperature regressed on eight climate proxies (`globwarm`). Residuals against year show long runs; successive residuals $e_{i+1}$ vs $e_i$ are positively correlated; the Durbin–Watson test (`lmtest::dwtest`) confirms it. A missing term (e.g. an omitted quadratic) can mimic serial correlation; otherwise use generalised least squares (Ch. 8).

**6.2 Finding Unusual Observations (p. 83).**

- *6.2.1 Leverage (p. 83).* $h_{ii}$ depends only on $X$, behaves like a Mahalanobis distance from the centre of the predictors, sums to $p$, so its average is $p/n$; look at values above $2p/n$. Half-normal plots (`faraway::halfnorm`) spot large leverages: Libya and the United States in `savings`. Standardised residuals correct for unequal residual variance.
- *6.2.2 Outliers (p. 85).* Three simulated cases (Figure 6.9): an outlier with low leverage (little effect), a high-leverage point on the line (little effect), and a high-leverage outlier that drags the line and hides its own residual. Hence **studentised (jackknife) residuals**, based on the fit without case $i$, which follow $t_{n-p-1}$. Testing all $n$ cases needs a **Bonferroni** correction (level $\alpha/n$ per test), conservative for large $n$. `savings`: Zambia's 2.85 is below the critical 3.53, so no outlier. Advice: check for data errors, examine the context (outliers can be discoveries, as in fraud detection or the ozone-hole story), report any exclusion, prefer robust regression to routine deletion. The `star` data show four giant stars that mask one another: the outlier test finds nothing.
- *6.2.3 Influential Observations (p. 89).* Cook's distance combines residual size and leverage. `savings`: Libya has the largest $D_i$; dropping it changes the `ddpi` coefficient by about half. `dfbeta()` shows the change in each coefficient when each case is left out; Japan stands out for `pop15`. `plot(lm)` gives the four standard panels, including standardised residuals against leverage with Cook's-distance contours.

**6.3 Checking the Structure of the Model (p. 92).** **Added-variable (partial regression) plots**: residuals of $y$ on the other predictors against residuals of $x_j$ on the other predictors; the slope equals $\hat\beta_j$ from the full model. **Partial residual plots** ($e+\hat\beta_jx_j$ against $x_j$, via `termplot`) are better for detecting nonlinearity, added-variable plots for spotting influential points. For `pop15`, the partial residual plot shows two clusters; separate fits for countries with `pop15` above and below 35% give very different relationships. Faceting and symbols (`ggplot2`) add a third variable to plots.

**6.4 Discussion (p. 96).** Ranking of assumptions by importance: (1) the systematic form of the model, (2) independence of errors, (3) constant variance, (4) normality, the least important for large samples. Above all, the data must be relevant to the question.

## Key results to know

1. $e=(I-H)y=(I-H)\varepsilon$, $\mathrm{Var}(e)=\sigma^2(I-H)$, $\mathrm{Var}(e_i)=\sigma^2(1-h_{ii})$. Faraway writes $\hat\varepsilon_i$ and $h_i$.
2. Leverage: $\sum_ih_{ii}=p$; flag $h_{ii}>2p/n$.
3. Standardised residual $r_i=e_i/(\hat\sigma\sqrt{1-h_{ii}})$ (`rstandard`).
4. Studentised residual $t_i=e_i/(\hat\sigma_{(i)}\sqrt{1-h_{ii}})=r_i\sqrt{(n-p-1)/(n-p-r_i^2)}\sim t_{n-p-1}$ (`rstudent`); Bonferroni cut-off $t_{n-p-1,\,1-\alpha/(2n)}$.
5. Cook's distance $D_i=\dfrac{(\hat y-\hat y_{(i)})^\top(\hat y-\hat y_{(i)})}{p\,\hat\sigma^2}=\dfrac{r_i^2}{p}\,\dfrac{h_{ii}}{1-h_{ii}}$.
6. Variance stabilisation: choose $h$ with $h'(\mu)\propto1/\mathrm{SD}(y)$; $\mathrm{Var}\propto\mu\Rightarrow\sqrt y$, $\mathrm{SD}\propto\mu\Rightarrow\log y$.
7. Durbin–Watson: $DW=\sum_{i=2}^n(e_i-e_{i-1})^2/\sum_{i=1}^ne_i^2$; values well below 2 indicate positive serial correlation.

## Connect to class

- **Session 5 deck**, section *Diagnostics*: the same formulas and the same `savings` numbers (Zambia 2.85 vs 3.53; Libya, Japan, Zambia as the largest Cook's distances). The deck also gives screening guides for $D_i$ ($F_{p,n-p}$ median, $4/n$); Faraway uses half-normal plots instead of cut-offs.
- **Session 7 / Lab 02, Part 1** (`07-lab-part1-savings.Rmd`): the four default plots, leverage, outlier test and influence, exactly as in 6.1–6.2.
- **Session 8**, Problem 4 (`08-diagnostics-teengamb.Rmd`): diagnose a `teengamb` fit from plots and summary numbers.
- Added-variable plots are the Frisch–Waugh–Lovell result from the Session 6 deck.
- Serial correlation anticipates the dependence handled by mixed models (Sessions 15–19).

## Read carefully / safe to skim

- **Read carefully:** the opening of 6.1, 6.1.1, 6.1.2, all of 6.2, and 6.4.
- **Read once:** 6.1.3 and 6.3 (know what each plot is for).
- **Safe to skim:** the plot-simulation loops, the `ggplot2` and GGobi remarks.

## Check yourself

1. Show that $\mathrm{Var}(e_i)=\sigma^2(1-h_{ii})$ and explain why a high-leverage point tends to have a small raw residual.
2. With $n=50$, $p=5$ and $\alpha=0.05$, which quantile do you compare $\max_i|t_i|$ with, and why not $t_{45,0.975}$?
3. Sketch the residual-vs-fitted pattern you expect when the error SD is proportional to the mean, and name a transformation that fixes it.
4. Explain in words the difference between a high-leverage point, an outlier and an influential point, using Figure 6.9's three cases.
5. Why does Faraway rank normality as the least important assumption, and why does the systematic part come first?
