# Session 25 — Exercises

**Course:** Statistical Modelling (BAM), Spring 2027 · Prof. Dae-Jin Lee (`daelee@faculty.ie.edu`)

Exercises 1–4 are by hand; 5–8 use R (`mgcv`, `MASS`).

### Exercise 1 (tensor-product model matrix)
Marginal bases: $a_1(x)=1-x$, $a_2(x)=x$ on $[0,1]$, and $c_1(z)=1$, $c_2(z)=z$, $c_3(z)=z^2$.
(a) Write $f(x,z)=\sum_k\sum_l\beta_{kl}a_k(x)c_l(z)$ and the model-matrix row for $(x,z)=(0.25,2)$ as a Kronecker product.
(b) With marginal penalty matrices $S_x$ ($2\times2$) and $S_z$ ($3\times3$), write the two penalty matrices of the tensor product and give their dimensions.

### Exercise 2 (scale invariance)
(a) Let $x=cu$ with $c>0$. Show that $\int\{\partial^2f/\partial u^2\}^2du=c^{3}\int\{\partial^2f/\partial x^2\}^2dx$ for a function of one variable on the corresponding ranges.
(b) Use (a) to explain why the fit of `te(x, z)` does not change when $x$ is measured in different units, while an isotropic smooth with penalty $\iint(f_{xx}^2+2f_{xz}^2+f_{zz}^2)\,dx\,dz$ does.

### Exercise 3 (ANOVA constraints and dependence)
Take one centred marginal function per variable, $u(x)=x-\bar x$ and $v(z)=z-\bar z$, and the interaction $f_{xz}(x,z)=\beta\,u(x)v(z)$.
(a) Product design: $(x,z)\in\{(0,0),(0,1),(1,0),(1,1)\}$. Show that the average of $f_{xz}$ over the points with $x=0$ is zero, and likewise for $x=1$, $z=0$, $z=1$.
(b) Dependent design: $(0,0),(0,0),(0,1),(1,1)$. Compute $u$, $v$ and the average of $f_{xz}$ over the points with $x=0$. What does this imply for the interpretation of the main effect $f_x$?

### Exercise 4 (model comparison)
For $\log(\text{Ozone})$, AIC is 166.4 (additive, df 10.3), 144.1 (`te`, df 20.1) and 137.9 (`ti` decomposition, df 23.4).
An `anova()` of the additive vs `ti` models gives $p=0.0036$ with ML fits and $p=2.8\times10^{-5}$ with REML fits.
(a) Which model do you prefer and why?
(b) Give two reasons why the two $p$-values differ, and say which comparison is more defensible.
(c) Why can AIC compare `te` and `ti` models that are not nested in the usual sense?

### Exercise 5 (concurvity simulation, R)
Use the simulation of `25-concurvity-selection.Rmd` with `x2 <- pmin(pmax(x1 + rnorm(n, sd = s), 0), 1)` and `set.seed(26)` before generating `x2` and `y`, for $s\in\{0.02,0.08,0.3\}$.
(a) Report $\mathrm{Corr}(x_1,x_2)$, the concurvity estimate of `s(x1)`, and the mean standard error of $\hat f_1$.
(b) Describe how the standard error grows with concurvity.

### Exercise 6 (shrinkage)
(a) Explain why, without `select = TRUE`, a smooth of pure noise usually keeps edf of at least about 1.
(b) What does `select = TRUE` add to the penalty, and why does it allow edf $\to0$?
(c) In the deck's example, the edf of `s(Temp)` changes from 1.00 to 2.86 when `select = TRUE` is used. Suggest why.

### Exercise 7 (interpretation, R)
Fit the `ti` model of the deck.
(a) Estimate the ratio of median ozone for Temp 90 vs 70 °F at Wind $=10$ mph and Solar.R $=207$, with a 95% interval.
(b) Predict the median ozone, with a 95% interval, for a day with Temp $=85$, Wind $=7$, Solar.R $=250$.
(c) Why would an interval of the form $e^{\hat\eta}\pm1.96\,\text{se}$ be wrong?

### Exercise 8 (an interaction in a binomial GAM, R)
For `pima <- rbind(MASS::Pima.tr, MASS::Pima.te)`, add `ti(age, bmi)` to the binomial GAM of Session 23.
(a) Report the edf and $p$-value of the `ti` term and the AIC of both models.
(b) Is there evidence that the age effect depends on bmi?
