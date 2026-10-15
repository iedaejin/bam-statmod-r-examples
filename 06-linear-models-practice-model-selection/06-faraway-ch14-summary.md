# Faraway (2014), Ch. 14 — Categorical Predictors

**Session(s):** 6 (also useful for 8)  ·  **Source:** Faraway, *Linear Models with R*, 2nd ed., Chapman & Hall/CRC, Ch. 14, pp. 205–222  
**Reading time:** ~50 min  ·  **Level:** core

## Why read it

Many predictors are categories, not numbers: treatment group, region, sex, number of cylinders. This chapter shows how factors enter $y=X\beta+\varepsilon$ through dummy variables, so that everything from Sessions 5–7 (estimation, $F$ tests, diagnostics) applies unchanged. It also explains how to read coefficients when a factor interacts with a continuous predictor, the core of the *Categorical predictors* and *Interactions* parts of Session 6 and of Problem 3 in Session 8.

## The big idea

A factor with $k$ levels is coded by $k-1$ dummy columns plus the intercept; using all $k$ dummies with an intercept makes $X$ rank-deficient. With the default **treatment coding**, the intercept is the mean (or line) of the **reference level** and each dummy coefficient is a *difference* from that level. Adding a continuous covariate gives parallel lines; adding the interaction lets the slopes differ, and then the "group effect" depends on where along $x$ you look. The coding changes the meaning of $\hat\beta$ but not the fitted values, $R^2$, $\hat\sigma$ or the overall $F$.

## Section by section

**14.1 A Two-Level Factor (p. 205).** Data from a clinical study (`sexab`): post-traumatic stress scores of 76 women, grouped by whether they reported childhood sexual abuse, together with a score for childhood physical abuse. A pooled-variance two-sample $t$ test finds a large difference. Reproducing it as a linear model: two dummies plus an intercept give a singular $X$ (the dummies add up to the intercept column), so R drops one. Dropping a dummy gives intercept = mean of one group and slope = difference, with the same $t$ statistic (up to sign) as the $t$ test. Dropping the intercept instead gives the two group means directly, but the tests are uninteresting, the trick does not extend to several factors, and $R^2$ is wrong. R does the coding automatically for factor variables; the alphabetically first level is the reference, changed with `relevel()`. Fitted values and residuals do not depend on the choice.

**14.2 Factors and Quantitative Predictors (p. 209).** With a continuous $x$ and a dummy $d$, four nested models: one common line (`y ~ x`); a group effect only (`y ~ d`); parallel lines (`y ~ x + d`), where the dummy coefficient is the vertical distance between them; separate lines (`y ~ x * d`), with the interaction column formed as the elementwise product $x\cdot d$. On the stress data the interaction is not significant, so the parallel-lines model is kept: the group difference adjusted for physical abuse is somewhat smaller than the unadjusted one, and the physical-abuse slope is smaller after adjusting for group. Check residuals by group for unequal variances. Causal caution: other variables may differ between groups.

**14.3 Interpretation with Interaction Terms (p. 212).** Weekly gas consumption of a house against outside temperature, before and after wall insulation (`MASS::whiteside`). In `Gas ~ Temp * Insul`, the temperature slope before insulation is about $-0.39$ and after it is about $-0.39+0.12\approx-0.28$. The main effect of insulation is the difference at $0^\circ$C, at the edge of the data. **Centring** temperature at its mean makes the intercept and the insulation coefficient refer to an average week, without changing the slopes or the fit.

**14.4 Factors With More Than Two Levels (p. 213).** $f$ levels need $f-1$ dummies. Fruit-fly longevity (`fruitfly`): 125 males randomly assigned to five groups differing in sexual activity, with thorax length as a covariate. The full model `longevity ~ thorax * activity` gives one line per group. To test the interaction as a whole use one $F$ test (sequential `anova()`, Table 14.1), not four $t$ tests; it is clearly not needed (its $p$-value is close to one). `drop1(..., test = "F")` tests each term given the other. In the parallel-lines model, the high-activity group lives about 20 days less than isolated flies; the low-activity difference would not survive a Bonferroni adjustment. Residuals fan out, so the response is logged; coefficients then act multiplicatively ($e^{\hat\beta}\approx0.66$ for the high group, about one third shorter life). Because thorax size is unrelated to the randomised groups, including it barely changes the effects but makes them much more precise.

**14.5 Alternative Codings of Qualitative Predictors (p. 219).** General form: dummy matrix $B$ ($n\times k$) times a $k\times(k-1)$ contrast matrix $C$. **Treatment** coding (R's default): compare with level 1. **Helmert** coding: orthogonal columns in balanced designs, rarely easy to interpret. **Sum** coding: intercept = average of the group means, coefficients = deviations from it, useful without a natural reference level. Any full-rank coding gives the same $R^2$, $\hat\sigma$ and overall $F$; only $\hat\beta$ changes.

## Key results to know

1. A $k$-level factor contributes $k-1$ columns; $k$ dummies plus an intercept are collinear (Section 2.10).
2. Treatment coding: $\hat\beta_0$ = reference-level mean (or line), $\hat\beta_j$ = level $j$ minus reference.
3. Two lines: $y=\beta_0+\beta_1x+\beta_2d+\beta_3\,x d+\varepsilon$. Reference group: intercept $\beta_0$, slope $\beta_1$; other group: intercept $\beta_0+\beta_2$, slope $\beta_1+\beta_3$. The lines cross at $x^*=-\beta_2/\beta_3$.
4. With an interaction, $\beta_2$ is the group difference at $x=0$; centring $x$ makes it the difference at $\bar x$.
5. Test a multi-level factor or its interaction with one $F$ test (`anova`, `drop1`), not with separate $t$ tests.
6. Coding (treatment, sum, Helmert) changes $\hat\beta$ but not $\hat y$, $R^2$, $\hat\sigma$ or the overall $F$.

## Connect to class

- **Session 6 deck**, *Categorical predictors* and *Interactions*: dummy coding with `mtcars` (`cyl`), `relevel`, other contrasts, the continuous × factor "two lines" model, where the lines cross, continuous × continuous interactions and the hierarchical principle (`06-categorical-interactions.Rmd`). The deck's examples are `mtcars`; Faraway's are the stress, gas and fruit-fly data.
- **Session 8**, Problem 3 (`teengamb`, `income * sex`) is Section 14.3 by hand: write each group's line, find the crossing point and ask whether it lies inside the data.
- Faraway calls models with a factor and a covariate "analysis of covariance" (Ch. 1); Chapters 15–17 (one- and multi-factor ANOVA) are not part of our reading list.
- The log-response interpretation links to Faraway 9.1.

## Read carefully / safe to skim

- **Read carefully:** 14.1 (why one dummy is dropped), 14.2 (the four models), 14.3 (interpretation and centring), and the testing part of 14.4.
- **Read once:** 14.5.
- **Safe to skim:** the `ggplot2` faceting code and the aside on suspiciously large $p$-values.

## Check yourself

1. Write the rows of $X$ for one observation from each of three levels under treatment coding and under sum coding.
2. In `Gas ~ Temp * Insul`, derive the temperature at which the "before" and "after" lines would cross. Is it a meaningful temperature?
3. Why is the $t$ statistic for the dummy in `y ~ d` the same as the pooled two-sample $t$ statistic?
4. Explain in words why including thorax length made the fruit-fly effects more precise but hardly changed them, and why that would not hold in an observational study.
5. A colleague drops the intercept to get the group means "directly" and reports $R^2=0.89$. What is wrong with that number?
