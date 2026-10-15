# Pawitan (2001), Ch. 17 — Random and mixed effects models

**Session(s):** 15, 16 and 17 (also useful for 21 and 27)  ·  **Source:** Pawitan, *In All Likelihood: Statistical Modelling and Inference Using Likelihood*, OUP, Ch. 17, pp. 435–472 (text pp. 435–469, exercises pp. 469–472)
**Reading time:** ~100 min in total (~30 min per session)  ·  **Level:** core: 17.1–17.2 (Session 15), 17.4–17.6 (Session 16), 17.8–17.10 (Session 17); optional: 17.3, 17.7 and the starred parts

## Why read it
Wood gives the matrix algebra and R code; Pawitan gives the likelihood view of this course: why random effects help when there are many parameters and few observations per parameter, where GLS, BLUP and REML come from, and why a GLMM likelihood is hard to compute. One chapter covers the whole mixed-model block.

## The big idea
When each group (subject, plate, animal) has its own parameter but few observations, treat those parameters as random draws from a distribution. Pawitan's **extended likelihood** (Ch. 16) is the joint density of the data and the unobserved random effects, $L(\beta,\theta,b)=p(y\mid b)\,p(b)$. Maximising it over $b$ gives shrunken (BLUP) predictions; integrating $b$ out gives the marginal likelihood of $(\beta,\theta)$: closed-form for normal models, numerical or approximate for GLMMs. The same algebra returns in smoothing (Ch. 18).

## Section by section

**Introduction (p. 435).** Random effects are needed when there are many parameters for the amount of data, e.g. a growth line for each of 100 subjects measured two to four times; treating them as random beats fitting each subject separately.

**17.1 Simple random effects models (p. 436).** One-way model $y_{ij}=\mu+b_i+e_{ij}$ for repeated estrone measurements on five women (16 each, log scale). Maximising the joint likelihood over $b_i$ with the variances known gives a **shrinkage** estimate: the raw group deviation $\bar y_i-\hat\mu$ multiplied by a factor below 1. Its information, $n/\sigma^2+1/\sigma_b^2$, exceeds the fixed-effect value $n/\sigma^2$, so the standard error is smaller. Empirical Bayes reading: each group mean is a weighted average of its own mean and the overall mean (here the weight on its own mean is about 0.99: almost no shrinkage).

**17.2 Normal linear mixed models (p. 439).** The general model, also written conditionally on $b$ (the form that extends to GLMMs). The marginal likelihood of $(\beta,\theta)$, the GLS estimate of $\beta$, the profile likelihood of $\theta$, and REML as the modified profile likelihood of Example 10.12. The random effects come from the joint likelihood: the BLUP equation, and the information matrix of $b$ for prediction intervals.

**17.3 Estimating genetic value from family data\* (p. 442).** Animal breeding: genetic merits with covariance given by a pedigree relationship matrix.

**17.4 Joint estimation of β and b (p. 444).** Henderson's **mixed model equations**: maximising the joint likelihood over $\beta$ and $b$ simultaneously gives the same $\hat\beta$ as GLS and the same $\hat b$ as BLUP, without inverting $V$. They can be solved by backfitting (Gauss–Seidel), alternating between the fixed and random parts.

**17.5 Computing the variance component via β̂ and b̂ (p. 445).** Matrix identities rewrite the profile log-likelihood of $\theta$ as the joint log-likelihood at $(\hat\beta,\hat b)$ minus half the log-determinant of the information on $b$, which involves only small matrices. An iterative algorithm alternates between $(\hat\beta,\hat b)$ and updates of $\sigma^2,\sigma_b^2$ in which a "model degrees of freedom" (a trace) appears.

**17.6 Examples (p. 448).** The one-way model again, and 19 dogs under four treatments: random and fixed dog effects give the same treatment estimates, with slightly smaller standard errors for the random-effects fit.

**17.7 Extension to several random effects (p. 452).** Several random factors stack into one $Z$. Example: jaw-bone heights of 20 boys at four ages with random intercepts and slopes (independent, age centred). Ordinary least squares gives the same $\hat\beta$ but wrong standard errors: too small for the intercept and twice too large for the slope. The implied covariance is close to an unstructured estimate.

**17.8 Generalized linear mixed models (p. 458).** Overdispersed germination counts on 10 plates; binomial-normal and Poisson-normal models (beta-binomial and negative binomial as alternatives). Specification: given $b$, $y_i$ follows a GLM with $g(\mu_i)=x_i^\top\beta+z_i^\top b$. The marginal variance is $\phi\,\mathrm E\{V(\mu)\}+\mathrm{Var}(\mu)$, so random effects produce overdispersion with a richer pattern than a single dispersion parameter.

**17.9 Exact likelihood in GLMM (p. 460).** The marginal likelihood is an integral over $b$ with no closed form; Gaussian quadrature works when random effects are independent. Crowder's seed data (Example 6.4) with a random plate effect: estimates close to ordinary logistic regression, larger standard errors, and an irregular profile likelihood for $\sigma_b$ that gives $\sigma_b=0$ about 31% likelihood, in tension with the deviance goodness-of-fit test.

**17.10 Approximate likelihood in GLMM (p. 462).** Use the joint ("hierarchical", Lee and Nelder) likelihood $\log p(y\mid b)+\log p(b)$. For fixed $\theta$, IWLS with a working response gives the mixed-model equations again (the PQL idea); $\theta$ maximises the same modified profile likelihood as in the normal case, justified by Laplace's approximation (Breslow and Clayton), which tends to underestimate large variance components. On the seed data it is very close to the exact fit.

## Key results to know
Course notation: $y=X\beta+Zb+\varepsilon$, $b\sim N(0,G)$, $\varepsilon\sim N(0,\sigma^2I)$, $V=ZGZ^\top+\sigma^2I$; groups $i=1,\dots,m$. Pawitan writes $\Sigma$ for $\mathrm{Var}(\varepsilon)$, $D$ for $G$, $q$ for the number of groups, and uses "estimate" for random effects where we say "predict".
1. Marginal model: $y\sim N(X\beta,V)$; $\ell(\beta,\theta)=-\tfrac12\log|V|-\tfrac12(y-X\beta)^\top V^{-1}(y-X\beta)$.
2. GLS: $\hat\beta=(X^\top V^{-1}X)^{-1}X^\top V^{-1}y$, $\ \mathrm{Var}(\hat\beta)=(X^\top V^{-1}X)^{-1}$.
3. BLUP: $\tilde b=(Z^\top Z/\sigma^2+G^{-1})^{-1}Z^\top(y-X\hat\beta)/\sigma^2=GZ^\top V^{-1}(y-X\hat\beta)$; prediction variance from $(Z^\top Z/\sigma^2+G^{-1})^{-1}$.
4. Random intercept, balanced: $\tilde b_i=\dfrac{n\sigma_b^2}{n\sigma_b^2+\sigma^2}(\bar y_i-\hat\mu)$, the same shrinkage factor as deck 16.
5. Mixed model equations: $\begin{pmatrix}X^\top X & X^\top Z\\ Z^\top X & Z^\top Z+\sigma^2G^{-1}\end{pmatrix}\begin{pmatrix}\hat\beta\\ \tilde b\end{pmatrix}=\begin{pmatrix}X^\top y\\ Z^\top y\end{pmatrix}$.
6. $\ell_p(\theta)=\ell(\hat\beta,\theta,\tilde b)-\tfrac12\log|Z^\top Z/\sigma^2+G^{-1}|$ (Pawitan 17.15; up to constants), and REML: $\ell_R=\ell_p-\tfrac12\log|X^\top V^{-1}X|$.
7. GLMM: $g\{\mathrm E(y\mid b)\}=X\beta+Zb$; $\mathrm{Var}(y_i)=\phi\,\mathrm E\{V(\mu_i)\}+\mathrm{Var}(\mu_i)$.

## Connect to class
- **Session 15** (`15-pooling.Rmd`, `15-random-intercept-slope.Rmd`): pooling, fixed vs random effects, the marginal model, "Ignoring the grouping gives the wrong standard error" (Pawitan's jaw-bone comparison). ICC and compound symmetry are not named in Ch. 17.
- **Session 16** (`16-gls-ml-reml.Rmd`, `16-blup-shrinkage.Rmd`): GLS, profile likelihood, REML, BLUP and shrinkage, "BLUPs as penalised least squares". Pawitan does not cover the boundary (50:50 mixture) test for variance components.
- **Session 17** (`17-cbpp-glmm.Rmd`, `17-poisson-olre.Rmd`): the GLMM integral, quadrature and Laplace/PQL. Conditional vs marginal effects (attenuation) are not discussed by Pawitan; his Example 17.4 is the variance side of the observation-level random effect.
- Lab 04. Sessions 21 and 27: the "model degrees of freedom" of 17.5 is a smoother's edf (Ch. 18).

## Read carefully / safe to skim
- **Read carefully:** introduction, 17.1, 17.2 (Session 15); 17.4, 17.5 up to the update formulas, 17.6 and the jaw-bone example of 17.7 (Session 16); 17.8, 17.9 and the first half of 17.10 (Session 17).
- **Skim:** 17.3, the update formulas and $\mathrm{Var}(\hat\beta)$ trick in 17.5, the two-random-effect algebra in 17.7, the starred non-normal random effects.

## Check yourself
1. In the one-way model with known variances, derive $\tilde b_i$ by maximising $\log p(y\mid b)+\log p(b)$ over $b_i$. What happens as $n\to\infty$, and as $\sigma_b^2\to0$?
2. Write the joint log-likelihood $\ell(\beta,\theta,b)$ of a normal LMM with $\varepsilon\sim N(0,\sigma^2I)$ and set its derivatives in $\beta$ and $b$ to zero. Which system do you get, and which matrix does it avoid inverting?
3. Why can OLS on grouped data give a standard error that is too small for one coefficient and too large for another?
4. Explain in words why the likelihood of a GLMM is an integral, and why this integral is easy in the normal case.
5. A random effect on each plate makes the binomial overdispersed. Use the marginal variance formula to say which term creates the extra variance.
