# Session 19 — Exercises

**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Work in groups of three at the board. No software is needed during the session. Notation: groups $i$, observations $j$; $y = X\beta + Zb + \varepsilon$, $b\sim N(0,G)$, $V = ZGZ^\top + \sigma^2 I$; ICC $=\sigma_b^2/(\sigma_b^2+\sigma^2)$; random-intercept shrinkage $k_i = n_i\sigma_b^2/(n_i\sigma_b^2+\sigma^2)$.

Data for Problems 3–5 and 7: `nlme::Orthodont` — distance (mm) from the pituitary to the pterygomaxillary fissure, measured on X-rays of 27 children (16 boys, 11 girls) at ages 8, 10, 12 and 14. Data for Problem 6: `MASS::bacteria` — 220 tests for *H. influenzae* in 50 children with otitis media, weeks 0–11, treatment placebo / drug / drug+ (drug with compliance encouragement).

## Problem 1 — Fixed or random?

For each study, should the factor in *italics* be fixed or random? Justify, and state the assumption you make.

(a) Reading scores of 2 000 pupils in 60 *schools* drawn at random from a region; a new teaching method is randomised within schools.
(b) Crop yield under 4 *fertilisers*, each applied to 10 plots.
(c) Monthly sales of 200 *shops*; shops in richer areas were more likely to receive a marketing campaign (the covariate of interest).
(d) Pain scores of 30 *patients*, each measured under 3 *treatments* in random order.
(e) Productivity in 3 *factories* of one company; management asks which factory is best.

## Problem 2 — $Z$, $G$ and $V$ for a small design

Three classes with 2, 3 and 1 students; $y_{ij} = \beta_0 + \beta_1x_{ij} + b_{0i} + \varepsilon_{ij}$, $\sigma_b^2 = 4$, $\sigma^2 = 12$.

(a) Write $Z$ ($6\times 3$) and $G$, and compute $V$.
(b) Give the ICC and the shrinkage factor of each class. Which class's BLUP is shrunk most?
(c) Add a random slope with $G_i = \begin{pmatrix}4 & -1\\ -1 & 1\end{pmatrix}$ and measure one class at $x = 0, 1, 2$. Compute $V_i$. At which $x$ is $\Var(y_{ij})$ smallest?
(d) Why is $V$ block diagonal? Give a design that would break this.

## Problem 3 — ICC and BLUP by hand

`lmer(distance ~ age + Sex + (1 | Subject))` (REML) gives $\hat\sigma_b^2 = 3.267$, $\hat\sigma^2 = 2.049$, $\hat\beta = (17.70671,\ 0.66019,\ -2.32102)$ for (intercept, age, SexFemale).

(a) Compute and interpret the ICC.
(b) Compute the shrinkage factor ($n_i = 4$).
(c) Boy M10 has mean distance 29.5 mm over his four visits. Compute his raw deviation $\bar y_{i\cdot} - \bar x_{i\cdot}^\top\hat\beta$ and his BLUP.

## Problem 4 — Comparing structures

| Model | Fit | npar | logLik | AIC |
|---|---|---|---|---|
| `m_ri`: `distance ~ age + Sex + (1 | Subject)` | REML | 5 | −218.76 | 447.51 |
| `m_rs`: `distance ~ age + Sex + (age | Subject)` | REML | 7 | −217.62 | 449.23 |
| `m_ml1`: `distance ~ age + Sex + (1 | Subject)` | ML | 5 | −217.43 | 444.86 |
| `m_ml0`: `distance ~ age + (1 | Subject)` | ML | 4 | −221.69 | 451.39 |

(a) Test the random slope. Give $T$, the reference distribution and an approximate p-value ($P(\chi^2_1 > 2.28) = 0.131$, $P(\chi^2_2 > 2.28) = 0.320$). Why may REML fits be used?
(b) Test the effect of `Sex` ($P(\chi^2_1 > 8.53) = 0.0035$). Which fits do you use, and why?
(c) A student compares the two REML fits with and without `Sex` and gets $T = 9.49$. What is wrong?
(d) Which random-effects structure does AIC prefer?

## Problem 5 — Reading `lmer` output

`lmer(distance ~ age + Sex + (age | Subject))`: $\hat\sigma_{b0} = 2.797$, $\hat\sigma_{b1} = 0.2264$, $\hat\rho = -0.77$, $\hat\sigma = 1.310$; fixed effects 17.635 (se 0.886), age 0.660 (0.071), SexFemale −2.145 (0.757). With `I(age - 11)` instead of `age`: intercept SD 1.832, slope SD 0.226, correlation 0.19, same log-likelihood.

(a) Interpret the fixed effects of `age` and `SexFemale` in mm.
(b) Give the range of growth rates (mm/year) expected for about 95% of children.
(c) Explain why centring age changes the intercept SD and the correlation. Which parametrisation is easier to interpret?
(d) `distance ~ age * Sex + (1 | Subject)` gives `age` 0.784 and `age:SexFemale` −0.305 (se 0.121); the ML LRT against `m_ri` gives $T = 6.22$. Interpret, and give the growth rate of girls.

## Problem 6 — Reading `glmer` output

`glmer(y ~ trt + I(week > 2) + (1 | ID), family = binomial, data = bacteria)`: $\hat\sigma_b^2 = 1.543$; fixed effects: intercept 3.548, `trtdrug` −1.367 (se 0.677), `trtdrug+` −0.783 (0.683), `I(week > 2)TRUE` −1.599 (0.476).

(a) Interpret $e^{-1.367}$ for a given child.
(b) Approximate the population-averaged odds ratio for `drug`.
(c) A `glm()` ignoring `ID` gives −1.119 for `trtdrug`. Is that a contradiction?

## Problem 7 — Diagnostics

The deck shows, for `m_ri`: (a) standardised conditional residuals vs fitted values, coloured by sex; (b) a normal QQ plot of these residuals; (c) a normal QQ plot of the 27 predicted intercepts.

(a) What does each panel check, and at which level of the model?
(b) Two boys (M09 and M13) give the most extreme residuals. What would you do?
(c) The residual SD is 1.50 mm for boys and 0.83 mm for girls. Which assumption fails, and how could the model be extended?
