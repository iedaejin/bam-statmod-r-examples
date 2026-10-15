# Session 2 — Exercises

**Topic:** Introduction to statistical modelling
**Faculty:** Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Exercises 1–6 are done by hand (a calculator is enough). Exercise 7 needs R. Exercise 8 is a short written answer.

---

## Exercise 1 — Two location estimates as minimisers

Let $y_1,\dots,y_n$ be real numbers.

1. Show that $Q(\mu)=\sum_{i=1}^n (y_i-\mu)^2$ is minimised at $\hat\mu=\bar y$, using the decomposition $Q(\mu)=\sum_i(y_i-\bar y)^2+n(\bar y-\mu)^2$. Prove the decomposition.
2. Show that $A(\mu)=\sum_{i=1}^n |y_i-\mu|$ is minimised at a sample median. (Hint: for $\mu$ not equal to any $y_i$, $A'(\mu)=\#\{y_i<\mu\}-\#\{y_i>\mu\}$.)
3. For `nhtemp`, $\bar y=51.16$ and the median is $51.20$. Which estimate would change more if the warmest year (54.6 °F) had been recorded by mistake as 64.6 °F? By how much would $\bar y$ change?

---

## Exercise 2 — Variance of the mean with and without independence

Let $y_1,\dots,y_n$ have $\mathrm{E}(y_i)=\mu$ and $\mathrm{Var}(y_i)=\sigma^2$.

1. Show that $\mathrm{E}(\bar y)=\mu$ for any dependence structure.
2. Assume independence and show $\mathrm{Var}(\bar y)=\sigma^2/n$.
3. Now assume $\mathrm{Cov}(y_i,y_{i+1})=\rho\sigma^2$ for $i=1,\dots,n-1$ and all other covariances are zero. Show that
   $$\mathrm{Var}(\bar y)=\frac{\sigma^2}{n}\Bigl[1+2\rho\,\frac{n-1}{n}\Bigr].$$
4. With $n=60$, $s=1.266$ and $\rho=0.3$, compute the standard error under independence and under this dependence. By what percentage does ignoring the correlation understate the standard error?

---

## Exercise 3 — Variability, uncertainty and intervals by hand

For the New Haven series under model 1, $n=60$, $\bar y=51.16$, $s=1.266$, and $t_{59,0.975}=2.001$.

1. Compute $\mathrm{se}(\bar y)$ and a 95% confidence interval for $\mu$.
2. Show that, for a new independent year $y_0$, $\mathrm{Var}(y_0-\bar y)=\sigma^2(1+1/n)$. Compute a 95% prediction interval for $y_0$.
3. How many years of data (same process) would be needed for $\mathrm{se}(\bar y)\le 0.05$? Would the prediction interval become narrower than $\pm 2$ °F? Explain using the words *variability* and *uncertainty*.

---

## Exercise 4 — Least squares through the origin

Consider the model $y_i=\beta x_i+\varepsilon_i$, $i=1,\dots,n$, with $\mathrm{E}(\varepsilon_i)=0$, $\mathrm{Var}(\varepsilon_i)=\sigma^2$, independent errors, and fixed $x_i$ not all zero.

1. Derive the least-squares estimator $\hat\beta$.
2. Show that $\hat\beta$ is unbiased and that $\mathrm{Var}(\hat\beta)=\sigma^2/\sum_i x_i^2$.
3. Data: $x=(1,2,3,4,5)$, $y=(2.1,3.9,6.2,7.8,10.1)$. Compute $\hat\beta$, $\hat\sigma^2=\mathrm{RSS}/(n-1)$ and $\mathrm{se}(\hat\beta)$.
4. Which systematic part and which random part does this model assume? Name one situation where forcing the line through the origin is a poor approximation.

---

## Exercise 5 — Measurement error in a covariate

The true model is $y=\beta_0+\beta_1x+\varepsilon$ with $x$ independent of $\varepsilon$. We observe $w=x+u$, with $u$ independent of $(x,\varepsilon)$, $\mathrm{E}(u)=0$, $\mathrm{Var}(u)=\sigma_u^2$.

1. Show that $\mathrm{Cov}(y,w)=\beta_1\sigma_x^2$ and $\mathrm{Var}(w)=\sigma_x^2+\sigma_u^2$. Deduce the limit of the least-squares slope of $y$ on $w$.
2. With $\beta_1=2$, $\sigma_x^2=4$ and $\sigma_u^2=1$, what slope do we expect in a very large sample?
3. Now the error is in the response: $y^{\mathrm{obs}}=y+v$, $v$ independent of everything with variance $\sigma_v^2$. Is the slope of $y^{\mathrm{obs}}$ on $x$ biased? What happens to the residual variance and to $\mathrm{se}(\hat\beta_1)$?

---

## Exercise 6 — Missing-data mechanisms

For each situation, say whether the missingness is most plausibly MCAR, MAR or MNAR, and whether the complete-case mean of the variable with missing values is likely to be biased.

1. A laboratory loses a random 5% of blood samples because a centrifuge fails at random times.
2. In a household survey, people with high incomes are less likely to report their income.
3. In a clinical study, older patients (age is recorded for everyone) miss more follow-up visits, and the outcome depends on age.
4. In `airquality`, 21 of the 30 June Ozone values are missing, against 5, 5, 5 and 1 in the other months.
5. A weather station records temperatures only on days when its sensor does not freeze.

---

## Exercise 7 — R: two models, simulation and a hold-out check

Use `data(nhtemp)` (do not type the values).

1. Fit model 1 (`temp ~ 1`) and model 2 (`temp ~ year`). Report $\mathrm{RSS}_1$, $\mathrm{RSS}_2$ and $\hat\beta_1$ per decade.
2. With `set.seed(1)`, simulate 1000 series from the fitted model 1 and fit a line to each. Report the share of simulated slopes at least as large as the observed slope, and the SD of the simulated slopes. Compare that SD with $\hat\sigma_1/\sqrt{S_{tt}}$.
3. Fit both models to 1912–1956 only and predict 1957–1971. Report the test RMSE of each model. Which predicts better? Is that consistent with the result for the 1962–1971 split shown in class?
4. End your script with `sessionInfo()` and knit it as a Quarto or R Markdown document from a clean session.

---

## Exercise 8 — Two cultures (≤ 150 words)

A city council asks for "the temperature trend in New Haven" and, separately, "the best forecast of next year's mean temperature". For each request, say which of Breiman's two cultures is better suited, how you would validate your answer, and what one of today's analyses suggests about using the same model for both.
