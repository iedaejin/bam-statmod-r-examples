# Session 8 — Exercises

**Topic:** Linear-model exercises
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

No software. Data: `faraway::teengamb`, a 1988 survey of 47 teenagers in Britain. `gamble` is gambling expenditure (pounds per year); `sex` is 0 for male, 1 for female; `status` is a socioeconomic status score from the parents' occupation; `income` is in pounds per week; `verbal` is the number of words out of 12 correctly defined. All output was produced by `08-printed-output.Rmd`.

Useful quantiles: $t_{42,0.975}=2.018$, $t_{43,0.975}=2.017$, $F_{2,42,0.95}=3.22$.

```
lm(formula = gamble ~ sex + status + income + verbal, data = teengamb)
             Estimate Std. Error t value Pr(>|t|)
(Intercept)  22.55565   17.19680   1.312   0.1968
sex         -22.11833    8.21111  -2.694   0.0101
status        0.05223    0.28111   0.186   0.8535
income        4.96198    1.02539   4.839 1.79e-05
verbal       -2.95949    2.17215  -1.362   0.1803
Residual standard error: 22.69 on 42 degrees of freedom
Multiple R-squared:  0.5267,	Adjusted R-squared:  0.4816
```

## 1. Formulation and interpretation

(a) Write the model in matrix form. Give $n$, $p$ and the row of $X$ for a girl with `status` 40, `income` 5, `verbal` 6.
(b) Interpret the `sex` and `income` coefficients in context, with units.
(c) What does the intercept represent? Is it meaningful? (`status` ranges 18–75, `verbal` 1–10, `income` 0.6–15.)

## 2. Tests and intervals by hand

(a) Check the $t$ value for `income` and give a 95% confidence interval for its coefficient.
(b) `gamble ~ sex + income` has $\mathrm{RSS}_0=22781$; the full model has $\mathrm{RSS}=21624$. Test $H_0:\beta_{\texttt{status}}=\beta_{\texttt{verbal}}=0$ at the 5% level.
(c) The total sum of squares is 45689. Recompute $R^2$ and $R^2_{\text{adj}}$.
(d) "`status` has $p=0.85$, so socioeconomic status does not affect gambling." Give two reasons why this is wrong.

## 3. An interaction with sex

```
lm(formula = gamble ~ income * sex, data = teengamb)
            Estimate Std. Error t value Pr(>|t|)
(Intercept)  -2.6596     6.3164  -0.421  0.67580
income        6.5181     0.9881   6.597 4.95e-08
sex           5.7996    11.2003   0.518  0.60724
income:sex   -6.3432     2.1446  -2.958  0.00502
Residual standard error: 20.98 on 43 degrees of freedom
```

(a) Write the fitted line for boys and for girls; interpret each income slope.
(b) Where do the lines cross? Observed incomes are 0.6–15 (boys) and 1.5–10 (girls). Is the crossing inside the data? What does this mean for the `sex` coefficient 5.80?
(c) Without fitting anything, give the $F$ statistic for adding `income:sex` to `gamble ~ income + sex`.

## 4. Diagnostics from plots

For the model of Problem 1 see the three panels in the deck (residuals vs fitted, normal QQ plot, residuals vs leverage; also `08-diagnostics-teengamb.Rmd`). Largest leverages: 0.312 (case 35), 0.302 (42), 0.240 (31), 0.221 (33). Largest studentized residuals: 6.02 (case 24), 2.15 (36). Bonferroni 5% cut-off $t_{41,1-0.05/94}=3.52$. Largest Cook's distances: 0.557 (24), 0.112 (39).

(a) Which assumptions do the residual-vs-fitted and QQ plots call into question?
(b) Is case 24 an outlier? Is it influential? Which cases have high leverage ($h_{ii}>2p/n$)?
(c) Propose two remedies and say what each would change.

## 5. Explanation or prediction?

| | Model | $p$ | $R^2_{\text{adj}}$ | AIC | BIC | LOOCV MSE |
|---|---|---|---|---|---|---|
| M1 | `income` | 2 | 0.37 | 439.7 | 445.3 | 671.6 |
| M2 | `sex + income` | 3 | 0.48 | 432.0 | 439.4 | 564.1 |
| M3 | `sex + income + verbal` | 4 | 0.49 | 431.6 | 440.9 | 564.8 |
| M4 | `sex + status + income + verbal` | 5 | 0.48 | 433.6 | 444.7 | 579.9 |
| M5 | `sex * income` | 4 | 0.56 | 425.3 | 434.6 | 482.9 |

LOOCV MSE is $\frac1n\sum_i\{e_i/(1-h_{ii})\}^2$, the leave-one-out prediction error.

(a) A charity wants to predict each teenager's spending to target a campaign. Which model, and why?
(b) A researcher asks: "Do girls spend less than boys at the same income?" Which model answers this, and what do you report?
(c) Which column estimates out-of-sample error, and why is $R^2_{\text{adj}}$ not a substitute?

## 6. Mean response vs new observation

For a boy with `status` 40, `income` 5, `verbal` 6, the model of Problem 1 gives $\hat y_0=31.70$, $\mathrm{se}(\hat y_0)=5.15$ and $\hat\sigma=22.69$.

(a) Compute a 95% CI for the mean spending of boys with this profile and a 95% prediction interval for one such boy.
(b) The prediction interval has a negative lower limit. What does this tell you about the model?
(c) If we refit on the square-root scale and transform back, which interval is more affected, and why?

## 7. Derivation: the hat matrix and $E[\mathrm{RSS}]$

Let $y=X\beta+\varepsilon$, $X$ of size $n\times p$ with rank $p$, $E[\varepsilon]=0$, $\mathrm{Var}(\varepsilon)=\sigma^2I_n$, $H=X(X^\top X)^{-1}X^\top$.

(a) Show that $H$ is symmetric and idempotent and that $\operatorname{tr}H=p$.
(b) Show that the eigenvalues of $H$ are 0 or 1 and deduce $\operatorname{rank}H=p$.
(c) Show that $e=(I-H)\varepsilon$ and $\mathrm{RSS}=\varepsilon^\top(I-H)\varepsilon$.
(d) Prove $E[\mathrm{RSS}]=\sigma^2(n-p)$. Which assumptions did you use? Is normality needed?
(e) Deduce $\mathrm{Var}(e_i)=\sigma^2(1-h_{ii})$ and explain why high-leverage points have small residuals.

## 8. Derivation: the variance of a prediction

A new response $y_0=x_0^\top\beta+\varepsilon_0$, with $\varepsilon_0$ independent of $\varepsilon$, $\mathrm{Var}(\varepsilon_0)=\sigma^2$.

(a) Show $\mathrm{Var}(x_0^\top\hat\beta)=\sigma^2x_0^\top(X^\top X)^{-1}x_0$ and $\mathrm{Var}(y_0-x_0^\top\hat\beta)=\sigma^2\{1+x_0^\top(X^\top X)^{-1}x_0\}$.
(b) For simple regression, with $X=[\mathbf 1,x]$ and the new point at $x_0$ (row $(1,x_0)$), show that the quadratic form equals $\frac1n+\frac{(x_0-\bar x)^2}{S_{xx}}$. Where is prediction most precise?
(c) Under normality, show that $(y_0-\hat y_0)/\{\hat\sigma\sqrt{1+x_0^\top(X^\top X)^{-1}x_0}\}\sim t_{n-p}$.
(d) In Problem 6, what is $x_0^\top(X^\top X)^{-1}x_0$? What fraction of the estimated prediction variance comes from estimating $\beta$?
